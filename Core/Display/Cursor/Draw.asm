
                ifndef _CORE_DISPLAY_CURSOR_
                define _CORE_DISPLAY_CURSOR_

Draw:           LD (.CurrentScreen), A
                LD (.CurrentScreen_), A

                ; show debug border
                ifdef SHOW_DEBUG_BORDER_CURSOR
                LD A, CURSOR_COLOR
                OUT (#FE), A
                endif

                ; инициализация
                LD (.ContainerSP), SP
                XOR A
                LD (.OffsetSprite), A                       ; отсутствует пропуск байт в спрайте
                LD (.OffsetX), A
                
                ; Mx, My   - позиция курсора        (в пикселах)
                ; Sx, Sy   - ширина/высота спрайта  (в пикселах)
                ; SOx, SOy - смещение в спрайте     (в пикселах)

                ; получим смещение (SpriteIdx * FSprite) - выравнить FSprite по 8 байт
                LD DE, Sprite_Cursor_Table
                LD H, #00
                LD A, (SpriteIdx)
                LD L, A
                ADD HL, HL                                  ; HL = SpriteIdx * 2
                ADD HL, HL                                  ; HL = SpriteIdx * 4
                ADD HL, HL                                  ; HL = SpriteIdx * 8
                ADD HL, DE                                  ; HL - указатель на информации о текущем спрайте
                LD SP, HL                                   ; SP - указывает на информацию о текущем спрайте

                ; FSprite Height (8), Offset_Y (8), Width (8), Offset_X (8), Dummy (8), Page Sprite (8), Address Sprite (16)
                POP DE                                      ; D - вертикальное смещение (SOy), E - высота спрайта (Sy)

                ; Eby = My + Sy - SOy (нижний край спрайта)
                LD A, (MousePositionY)                      ; A = My
                ADD A, E                                    ; A += Sy
                SUB D                                       ; A -= SOy
                ; - если отрицательное или равно нулю, спрайт выше экрана (не видим)
                ; - если больше или равно 192, спрайт ниже экрана (не видим)
                ; RET M                                       ; Eby - значение отрицательное
                JP Z, .Exit                                 ; Eby - значение нулевое

                ; A - хранит номер нижней линии (bottom_edge_sprite)
                LD C, A                                     ; C - хранит номер нижней линии спрайта

                ; Ety = EPOP DEby - Sy (верхний край спрайта)
                SUB E
                JP C, .CroppedTop                           ; урезан верхней частью экрана
                LD C, A                                     ; C - хранит номер верхней линии спрайта
                ADD A, #40
                JP C, .Exit                                 ; если переполнение, то верхняя линия спрайта больше или равно 192
                                                            ; спрайт ниже экрана
                NEG                                         ; А - хранит количество рисуемых строк
                SUB E
                JP C, .CroppedBottom                        ; урезан нижней частью экрана

                ; рисуется полностью

                LD A, E                                     ; A = Sy
                LD (.OffsetRow), A

.CalcRowScrAdr  LD H, (HIGH SCR_ADR_ROWS_TABLE) >> 1
                LD L, C
                ADD HL, HL
                LD A, (HL)
                INC HL
                LD H, (HL)
                LD L, A
                LD A, H
.CurrentScreen  EQU $+1
                OR #00
                LD H, A
                LD (.ScreenAddress), HL

                JP .Row

.CroppedTop     ; урезан верхней частью экрана
                NEG                                         ; А - хранит количество пропускаемых строк
                ; ширину спрайта курсора всегда 16 пикселей
                ADD A, A                                    ; A *= 2 байта
                ADD A, A                                    ; x2 т.к. OR & XOR
                LD (.OffsetSprite), A                       ; сохраним количество пропускаемых строк
                LD A, C                                     ; C - хранит номер нижней линии спрайта == количество рисуемых строк
                LD (.OffsetRow), A                          ; сохраним количество рисуемых строк
                ;
.CurrentScreen_ EQU $+2
                LD DE, #0000
                LD (.ScreenAddress), DE
                JP .Row

.CroppedBottom  ; урезан нижней частью экрана

                ; - модификация
                ; если не чётное округлим в большую сторону (портит 32 байта после экранной области!)
                ADD A, E                                    ; А - хранит количество пропускаемых строк
                RRA
                ADC A, #00
                RLA
                ; ~ модификация

                LD (.OffsetRow), A
                JR .CalcRowScrAdr

.Row            ; ------------------------ горизонталь ------------------------
                POP DE                                      ; D - горизонтальное смещение (SOx), E - ширина спрайта (Sx)

                LD A, E                                     ; A - хранит Sx
                SUB D                                       ; A = Sx - SOx
                ; преобразуем резульат (Sx - SOx) в 16-битное число
                LD C, A                                     ; C = Sx - SOx
                SBC A, A                                    ; если было переполнение (отрицательное число), корректируем
                LD B, A

                LD A, (MousePositionX)                      ; A = Mx
                LD L, A                                     ; E - хранит Mx
                LD H, #00

                ; Erx = Mx + (Sx - SOx) (правая грань спрайта)
                OR A
                ADC HL, BC                                  ; необходим для определения знака (16-битного числа)
                ; - если отрицательное или равно нулю, спрайт левее экрана (не видим)
                ; - если больше или равно 256, спрайт правее экрана (не видим)
                JP M, .Exit                                 ; Erx - значение отрицательное
                JP Z, .Exit                                 ; Erx - значение нулевое

                ; Elx = Mx - SOx (левая грань спрайта)
                XOR A
                LD B, A
                LD C, E
                SBC HL, BC

                JP Z, .IsFullNotShift                       ; на краю экрана ???????????????
                JP C, .CroppedLeft                          ; урезан левой частью экрана
                OR H
                JP NZ, .Exit                                ; левая часть спрайта за правой частью экрана
                LD A, L
                NEG
                SUB E
                JP C, .CroppedRight                         ; урезан правой частью экрана

                ; ---------- рисуется полностью ----------
                ; C = Elx (левая грань спрайта)

                ; расчёт знакоместа от левой грани спрайта
                LD A, L
                RRA
                RRA
                RRA
                AND %00011111
                LD (.OffsetX), A

                ; расчёт смещения в знакоместе
                LD A, L
                AND %00000111
                JR NZ, .IsFullShift

.IsFullNotShift ; выровнен по знакоместу

                LD IX, Metod.SBP_16_0
                JP .Draw

.IsFullShift    ; спрайт виден полность, но со смещением

                EXX
                ; calculate address of shift table
                DEC A
                ADD A, A
                ADD A, HIGH ShiftTable
                LD H, A
                EXX

                LD IX, Metod.SBP_16_0_S
                JP .Draw

.CroppedLeft    ; урезан левой частью экрана

                LD A, L
                ; расчёт количество пропускаемых байт слева
                NEG
                RRA
                RRA
                RRA
                AND %00011111
                ADD A, A    ; x2
                ADD A, A    ; x4

                ; смещение в таблице, если байт выравнен
                LD C, A
                LD A, L
                AND %00000111
                LD B, A
                LD A, C
                JR NZ, $+4
                ADD A, 12
                INC A       ; ширина спрайта константна
                ADD A, A    ; x2 (адрес)
                ; расчёт адреса обработчика
                EXX
                LD HL, HandlerUnits.TableLSJumpDraw
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H
                LD A, (HL)
                LD IXL, A
                INC HL
                LD A, (HL)
                LD IXH, A
                EXX

                LD A, B
                ; - лишний если байт выравнен
                EXX
                ; calculate address of shift table
                DEC A
                ADD A, A
                ADD A, HIGH ShiftTable + 1
                LD H, A
                ; INC H       ; временно
                EXX
                ; ~ лишний если байт выравнен

                JR .Draw

.CroppedRight   ; урезан правой частью экрана
                ; L - номер правой части спрайта (в пикселах)

                NEG         ; A - количество пропускаемых пикселей спрайта
                RRA
                RRA
                RRA
                AND %00011111
                ADD A, A    ; x2
                ADD A, A    ; x4

                ; смещение в таблице, если байт выравнен
                LD C, A
                LD A, L
                AND %00000111
                LD B, A
                LD A, C
                JR NZ, $+4
                ADD A, 12
                INC A       ; ширина спрайта константна
                ADD A, A    ; x2 (адрес)

                ; расчёт адреса обработчика
                EXX
                LD HL, HandlerUnits.TableRSJumpDraw
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H
                LD A, (HL)
                LD IXL, A
                INC HL
                LD A, (HL)
                LD IXH, A
                EXX

                LD A, B
                ; - лишний если байт выравнен
                EXX
                ; calculate address of shift table
                DEC A
                ADD A, A
                ADD A, HIGH ShiftTable
                LD H, A
                EXX
                ; ~ лишний если байт выравнен

                ; расчёт знакоместа
                LD A, L
                RRA
                RRA
                RRA
                AND %00011111
                LD (.OffsetX), A
                ; ------------------------ горизонталь ------------------------

.Draw           ; установим страницу спрайта
                POP AF                                      ; A - номер странички спрайта (F - dummy)
                SeMemoryPage_A

                ; модификация адреса спрайта
                POP HL                                      ; HL указывает на - адрес спрайта

.OffsetSprite   EQU $+1
                LD DE, #0000
                ADD HL, DE
                LD SP, HL

                LD BC, #0000    ; буфер

                EXX
.ScreenAddress  EQU $+1                        
                LD BC, #0000    ; экран
                LD A, C
.OffsetX        EQU $+1
                ADD A, #00
                LD C, A
                EXX

                ; двухпроходные вызовы
                LD HL, .JumpsRows
                LD A, #10
.OffsetRow      EQU $+1
                SUB #00
                LD E, A
                RRA
                JP NC, .EvenRows                            ; чётное количество строк
                DEC E
                ADD HL, DE
                LD E, (IX - 2)
                LD D, (IX - 1)
                EX DE, HL
                JP (HL)

.EvenRows       ADD HL, DE
.JumpsRows      rept 8
                JP (IX)
                endr

.Exit           ;                
.ContainerSP    EQU $+1
                LD SP, #0000
                RET
SpriteIdx:      DB #00

                endif ; ~_CORE_DISPLAY_CURSOR_