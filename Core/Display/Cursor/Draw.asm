
                ifndef _CORE_DISPLAY_CURSOR_
                define _CORE_DISPLAY_CURSOR_

Draw:           LD (.CurrentScreen), A
                LD (.CurrentScreen_), A

                ; show debug border
                ifdef SHOW_DEBUG_BORDER_CURSOR
                LD A, CURSOR_COLOR
                OUT (#FE), A
                endif

                LD (.ContainerSP), SP
                ; инициализация
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

                ; FSprite Height (8), Offset_Y (8), Width (8), Offset_X (8), Dummy (8), Page Sprite (8), Address Sprite (16)
                
                ; bottom_edge_sprite = My + Sy - SOy (нижний край спрайта)
                LD A, (MousePositionY)                      ; A = My
                ADD A, (HL)                                 ; A += Sy
                INC HL                                      ; HL указывает на - SOy
                SUB (HL)                                    ; A -= SOy
                ; - если отрицательное или равно нулю, спрайт выше экрана (не видим)
                ; - если больше или равно 192, спрайт ниже экрана (не видим)
                ; RET M                                       ; bottom_edge_sprite - значение отрицательное
                JP Z, .Exit                                 ; bottom_edge_sprite - значение нулевое

                ; A - хранит номер нижней линии (bottom_edge_sprite)
                LD C, A                                     ; C - хранит номер нижней линии спрайта

                ; top_edge_sprite = bottom_edge_sprite - Sy (верхний край спрайта)
                DEC HL                                      ; HL указывает на - Sy
                SUB (HL)
                JP C, .CroppedTop                           ; урезан верхней частью экрана
                LD C, A                                     ; C - хранит номер верхней линии спрайта
                ADD A, #40
                JP C, .Exit                                 ; если переполнение, то верхняя линия спрайта больше или равно 192
                                                            ; спрайт ниже экрана
                NEG                                         ; А - хранит количество рисуемых строк
                SUB (HL)
                JP C, .CroppedBottom                        ; урезан нижней частью экрана

                ; рисуется полностью
                LD A, (HL)                                  ; A = Sy
                LD (.OffsetRow), A
                EX DE, HL
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
                EX DE, HL
                JP .Row

.CroppedTop     ; урезан верхней частью экрана
                ; LD C, A                                     ; C - хранит номер нижней линии спрайта
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
                ; если не чётное увеличим в большую сторону (портит 32 байта после экранной области!)
                ADD A, (HL)                                 ; А - хранит количество пропускаемых строк
                RRA
                ADC A, #00
                RLA
                ; ~ модификация

                LD (.OffsetRow), A
                JR .CalcRowScrAdr

.Row            ; ------------------------ горизонталь ------------------------
                ; HL указывает на - Sy
                INC HL                                      ; HL указывает на - SOy
                INC HL                                      ; HL указывает на - Sx

                ; right_edge_sprite = Mx + Sx - SOx (правый край спрайта)
                ; LD A, (MousePositionX)                      ; A = Mx
                ; ADD A, (HL)                                 ; A += Sx
                ; INC HL                                      ; HL указывает на - SOx
                ; SUB (HL)                                    ; A -= SOx
                XOR A
                LD B, A
                LD D, A
                LD A, (MousePositionX)                      ; A = Mx
                LD C, A
                LD E, (HL)            
                EX DE, HL
                ADD HL, BC                                  ; A += Sx
                INC DE                                      ; DE указывает на - SOx
                LD A, (DE)
                LD C, A
                OR A
                SBC HL, BC                                  ; A -= SOx
                
                ; - если отрицательное или равно нулю, спрайт левее экрана (не видим)
                ; - если больше или равно 256, спрайт правее экрана (не видим)
                JP M, .Exit                                 ; right_edge_sprite - значение отрицательное
                JP Z, .Exit                                 ; right_edge_sprite - значение нулевое

                ; HL - хранит номер правой линии (right_edge_sprite)


                ; left_edge_sprite = right_edge_sprite - Sx (левый край спрайта)
                ; DEC HL                                      ; HL указывает на - Sx
                ; SUB (HL)                                    ; A -= Sx
                ; LD C, A                                     ; C - хранит номер левой линии спрайта
                ; JP Z, .IsFullNotShift                       ; на краю экрана ???????????????
                ; JP C, .CroppedLeft                          ; урезан левой частью экрана
                ; NEG
                ; SUB (HL)
                ; JP C, .CroppedRight                         ; урезан правой частью экрана

                DEC DE                                      ; DE указывает на - Sx
                LD A, (DE)
                LD C, A
                OR A
                SBC HL, BC                                  ; A -= Sx
                EX DE, HL
                LD C, E                                     ; C - хранит номер левой линии спрайта
                JP Z, .IsFullNotShift                       ; на краю экрана ???????????????
                JP C, .CroppedLeft                          ; урезан левой частью экрана
                LD A, E
                NEG
                SUB (HL)
                JP C, .CroppedRight                         ; урезан правой частью экрана

                ; рисуется полностью

                ; расчёт знакоместа
                LD A, C
                RRA
                RRA
                RRA
                AND %00011111
                LD (.OffsetX), A

                ; расчёт смещения в знакоместе
                LD A, C
                AND %00000111
                JR NZ, .IsFullShift

.IsFullNotShift ; выровнен по знакоместу

                ; расчёт адреса в таблице по длине спрайта
                LD A, (HL)                                  ; A = Sx
                RRA
                RRA
                RRA
                DEC A
                ADD A, A
                EX DE, HL
                LD HL, HandlerUnits.TableJumpDraw
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H
                LD A, (HL)
                LD IXL, A
                INC HL
                LD A, (HL)
                LD IXH, A
                EX DE, HL
                JP .Draw

.IsFullShift    ; спрайт виден полность, но со смещением
                EXX
                ; calculate address of shift table
                DEC A
                ADD A, A
                ADD A, HIGH ShiftTable
                LD H, A
                EXX

                ; расчёт адреса в таблице по длине спрайта
                LD A, (HL)
                RRA
                RRA
                RRA
                DEC A
                ADD A, A
                EX DE, HL
                LD HL, HandlerUnits.TableShiftJumpDraw
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H
                LD A, (HL)
                LD IXL, A
                INC HL
                LD A, (HL)
                LD IXH, A
                EX DE, HL
                JP .Draw

.CroppedLeft    ; урезан левой частью экрана
                ; C - номер левой части спрайта (в пикселах)
                ; A - количество пропускаемых пикселей слева

                ; LD A, C
                ; расчёт количество пропускаемых байт слева
                NEG
                RRA
                RRA
                RRA
                AND %00011111
                ADD A, A    ; x2
                ADD A, A    ; x4
                ; смещение в таблице, если байт выравнен
                LD E, A
                LD A, C
                AND %00000111
                LD B, A
                LD A, E
                JR NZ, $+4
                ADD A, 12
                ; LD E, #01   ; !!!!!!!!!!!!!!!!! (ширина спрайта константна)
                ; ADD A, E    ; + смещение (байтовое)
                INC A
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
                ADD A, HIGH ShiftTable
                LD H, A
                INC H       ; временно (т.к. для текущей функции 24_2)
                EXX
                ; ~ лишний если байт выравнен

                JR .Draw

.CroppedRight   ; урезан правой частью экрана
                ; C - номер левой части спрайта (в пикселах)
                ; A - количество пропускаемых пикселей спрайта

                ;
                NEG
                RRA
                RRA
                RRA
                AND %00011111
                ADD A, A    ; x2
                ADD A, A    ; x4

                ; смещение в таблице, если байт выравнен
                LD E, A
                LD A, C
                AND %00000111
                LD B, A
                LD A, E
                JR NZ, $+4
                ADD A, 12
                 ; LD E, #01   ; !!!!!!!!!!!!!!!!! (ширина спрайта константна)
                ; ADD A, E    ; + смещение (байтовое)
                INC A
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
                ; INC H       ; временно (т.к. для текущей функции 24_2)
                EXX
                ; ~ лишний если байт выравнен

                ; расчёт знакоместа
                LD A, C
                RRA
                RRA
                RRA
                AND %00011111
                LD (.OffsetX), A
                ; ------------------------ горизонталь ------------------------

.Draw           ; HL указывает на - Sx
                INC HL                                      ; HL указывает на - SOx
                INC HL                                      ; HL указывает на - dummy
                INC HL                                      ; HL указывает на - страницу спрайта
                
                ; установим страницу спрайта
                LD A, (HL)                                  ; A - номер странички спрайта (F - dummy)
                SeMemoryPage_A

                ; модификация адреса спрайта
                INC HL                                      ; HL указывает на - адрес спрайта
                LD A, (HL)
                INC HL
                LD H, (HL)
                LD L, A

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
