
                ifndef _CORE_DISPLAY_CURSOR_
                define _CORE_DISPLAY_CURSOR_

Draw:           LD (.CurrentScreen), A
                LD (.CurrentScreen_), A

                ; show debug border
                ifdef SHOW_DEBUG_BORDER_CURSOR
                BEGIN_DEBUG_BORDER_COL CURSOR_COLOR
                endif

                ; инициализация
                LD (.ContainerSP), SP
                XOR A
                LD (.OffsetSprite), A                       ; отсутствует пропуск байт в спрайте
                LD (.OffsetX), A

                CALL CursorTick
                ; JP C, .Exit                                 ; потом !
                
                ; Mx, My   - позиция курсора        (в пикселях)
                ; Sx, Sy   - ширина/высота спрайта  (в пикселях)
                ; SOx, SOy - смещение в спрайте     (в пикселях)

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
                LD A, (Mouse.PositionY)                     ; A = My
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

                ; JR $

.CalcRowScrAdr  ; LD H, (HIGH SCR_ADR_ROWS_TABLE) >> 1
                ; LD L, C
                ; ADD HL, HL
                ; LD A, (HL)
                ; INC HL
                ; LD H, (HL)
                ; LD L, A

                LD H, HIGH SCR_ADR_TABLE
                LD L, C
                LD A, (HL)
                INC H
                LD H, (HL)
                LD L, A

                LD A, H
.CurrentScreen  EQU $+1
                XOR #00
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
                LD DE, #C000
                LD A, D
.CurrentScreen_ EQU $+1
                XOR #00
                LD D, A
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

                LD A, (Mouse.PositionX)                     ; A = Mx
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

                LD IX, Metod.SBPR_16_0
                LD (Metod), IX
                JP .Draw

.IsFullShift    ; спрайт виден полность, но со смещением

                EXX
                ; calculate address of shift table
                DEC A
                ADD A, A
                ADD A, HIGH ShiftTable
                LD H, A
                EXX

                LD IX, Metod.SBPR_16_0_S
                LD (Metod), IX
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
                LD HL, TableRLSJumpDraw
                ADD A, L
                LD L, A
                ADC A, H
                SUB L
                LD H, A
                LD A, (HL)
                LD IXL, A
                INC HL
                LD A, (HL)
                LD IXH, A

                LD (Metod), IX
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
                ; L - номер правой части спрайта (в пикселях)

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
                LD HL, TableRRSJumpDraw
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H
                LD A, (HL)
                LD IXL, A
                INC HL
                LD A, (HL)
                LD IXH, A

                LD (Metod), IX
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
                POP AF                                                          ; A - номер странички спрайта (F - dummy)
                ; SeMemoryPage_A CURSOR_SPR_PAGE_ID                               ; не использовать CALL Memory.SetPage

                ; модификация адреса спрайта
                POP HL                                                          ; HL указывает на - адрес спрайта

.OffsetSprite   EQU $+1
                LD DE, #0000
                ADD HL, DE
                LD SP, HL

                LD BC, Container    ; буфер

                EXX
.ScreenAddress  EQU $+1                        
                LD BC, #0000        ; экран
                LD A, C
.OffsetX        EQU $+1
                ADD A, #00
                LD C, A
                LD (AddressScr), BC
                EXX

                ; двухпроходные вызовы
                LD HL, .JumpsRows
                LD A, #10
.OffsetRow      EQU $+1
                SUB #00
                LD (CountRows), A
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

                ResetFrameFlag RESTORE_CURSOR

                RET

Restore:        ; show debug border
                ifdef SHOW_DEBUG_BORDER_CURSOR_RESTORE
                BEGIN_DEBUG_BORDER_COL RESTORE_CURSOR_COLOR
                endif
                
                ; включим нужную страничку (экранную)
                CALL Memory.SetPage7
                ;
                SetFrameFlag RESTORE_CURSOR

                ; инициализация
                LD (.ContainerSP), SP

                ;
                LD HL, (Metod)
                LD DE, #FFFC        ; -4
                ADD HL, DE

                LD A, (HL)
                LD IXL, A
                INC HL
                LD A, (HL)
                LD IXH, A

                LD A, (CountRows)
                LD E, A
                INC D         

                EXX
                LD HL, (AddressScr)
                EXX

                LD HL, Container
                LD SP, HL

                LD HL, .JumpsRows
                ADD HL, DE

.JumpsRows      rept 8
                JP (IX)
                endr

.ContainerSP    EQU $+1
                LD SP, #0000

                RET
CursorTick:     LD A, (CursorFlagRef)
                INC A
                JR Z, .Reset
                LD A, (TicksCount)
                INC A
                CP 250
                JR Z, .ChangeState
                LD (TicksCount), A
                SCF
                RET

.Reset          XOR A
                LD (TicksCount), A
                LD (SpriteIdx), A
                RET

; .ChangeState    LD HL, SpriteIdx
;                 LD A, (HL)
;                 INC A
;                 CP #04
;                 JR NZ, $+3
;                 XOR A
;                 LD (HL), A
;                 LD A, 246
;                 LD (TicksCount), A
;                 OR A
;                 RET
.ChangeState    LD HL, SpriteIdx
                LD A, (HL)
                INC HL
                ADD A, (HL)
                CP #04
                JR Z, .RevertNeg
                CP #FF
                JR Z, .RevertPos
                DEC HL
                LD (HL), A
                LD A, 246
                LD (TicksCount), A
                RET

.RevertNeg      DEC (HL)
                DEC (HL)
                RET

.RevertPos      INC (HL)
                INC (HL)
                RET
TicksCount:     DB #00
SpriteIdx:      DB #00
Flag:           DB #01
AddressScr:     DW #0000
CountRows:      DB #00
Metod:          DW #00
Container:      DS 3 * 16, 0            ; 3 знакоместа * 16 пикселей высота спрайта

                endif ; ~_CORE_DISPLAY_CURSOR_
