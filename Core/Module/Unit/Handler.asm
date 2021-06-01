
                ifndef _CORE_MODULE_UNIT_HANDLER_
                define _CORE_MODULE_UNIT_HANDLER_

; -----------------------------------------
; visibility computation handler of units
; In:
; Out:
; Corrupt:
;   HL, DE, BC, AF, AF'
; -----------------------------------------
Handler:        ; включить страницу
                SeMemoryPage MemoryPage_Tilemap

                ; инициализация
                LD HL, MapStructure + FMap.UnitsArray
                LD E, (HL)
                INC L
                LD D, (HL)
                LD A, (CountUnitsRef)
                LD (.ProcessedUnits), A

                ifdef SHOW_VISIBLE_UNITS
                XOR A
                LD (VisibleUnits), A
                endif

                ; ---------------------------------------------
                ; Lx, Ly   - позиция юнита (в тайлах)
                ; Vx, Vy   - позиция видимой области карты (в тайлах)
                ; Ox, Oy   - смещение относительно тайла в которых расположен юнит (в пикселах)
                ; Sx, Sy   - ширина спрайта (в пикселах)  !!!! [ х - в знакоместах ]
                ; SOx, SOy - смещение спрайта (в пикселах)
                ; ---------------------------------------------

.Loop           ; грубый расчёт
                LD HL, TilemapOffsetRef

                ; position_x = (Lx - Vx) + 1
                LD A, (DE)
                INC E
                SUB (HL)
                INC HL
                INC A
                JP M, .NextUnit                                     ; position_x < 0, находится левее экран
                CP TilesOnScreenX + 2
                JP NC, .NextUnit                                    ; position_x >= 18, находится правее экрана

                ; ---------------------------------------------
                ; A = [0..17] - position_x
                ; ---------------------------------------------
                LD (.Pos_X), A

                ; position_y = (Ly - Vy) + 1
                LD A, (DE)
                SUB (HL)
                INC A
                JP M, .NextUnit                                     ; position_y < 0, находится левее экран
                CP TilesOnScreenY + 2
                JP NC, .NextUnit                                    ; position_y >= 14, находится правее экрана

                ; ---------------------------------------------
                ; A = [0..13] - position_y
                ; ---------------------------------------------
                EX AF, AF'                  ; save position_y
                PUSH DE                     ; save current address UnitsArray
                XOR A
                LD (.SpriteOffset), A       ; отсутствует пропуск байт в спрайте

                ; получение адреса хранения информации о спрайте
                INC D                                               ; перейдём на адрес структуры FUnitState
                DEC E
                CALL Animation.SpriteInfo                           ; получение информации о спрайте

                ; ---------------------------------------------
                ; вертикальный клипинг
                ; ---------------------------------------------

                ; ---------------------------------------------
                ; HL - указывает на адрес информации о спрайте
                ; DE - указывает на адрес структуры FUnitState + 3
                ; A' - position_y
                ; ---------------------------------------------

                LD C, (HL)
                INC HL
                LD B, (HL)
                INC HL
                LD (.ContainerSpr), HL

                ; ---------------------------------------------
                ; B - вертикальное смещение (SOy), C - высота спрайта (Sy)
                ; ---------------------------------------------

                DEC D                                               ; перейдём на адрес структуры FUnitLocation + 3
                
                ; добавить смещение относительно тайла (можно объеденить с константным значением 8)
                ; (Oy + 8)
                LD A, (DE)                                          ; A = FUnitLocation.OffsetByPixel.Y (Oy)
                ADD A, #08                                          ; A += 8

                ; (Sy - SOy)
                ADD A, C                                            ; A += Sy
                SUB B                                               ; A -= SOy

                ; преобразуем резульат (Oy + 8 + Sy - SOy) в 16-битное число
                LD L, A                                             ; L = Oy + 8 + Sy - SOy
                SBC A, A                                            ; если было переполнение (отрицательное число), корректируем
                LD H, A

                ; сохранение FUnitLocation.OffsetByPixel.X
                DEC E
                LD A, (DE)                                          ; A = FUnitLocation.OffsetByPixel.Y
                LD (.LocOffset_X), A

                ; A = position_y * 16
                EX AF, AF'
                DEC A                   ; A = [-1..12] - position_y
                ADD A, A
                ADD A, A
                ADD A, A
                ADD A, A

                ; преобразуем результат (position_y * 16) в 16-битное число
                LD E, A
                SBC A, A
                LD D, A

                ; offset_y = position_y * 16 + (Sy - SOy + Oy + 8)
                ADC HL, DE                                          ; необходим для определения знака (16-битного числа)
                ; - если отрицательное или равно нулю, спрайт выше экрана (не видим)
                JP M, .PreNextUnit                                  ; offset_y - значение отрицательное
                JP Z, .PreNextUnit                                  ; offset_y - значение нулевое

                ; расчитаем верхнюю часть спрайта
                ; offset_y -= Sy
                LD A, L                                             ; L - хранит номер нижней линии спрайта
                SUB C
                JP C, .ClipAtTop                                    ; урезан верхней частью экрана
                LD L, A                                             ; L - хранит номер верхней линии спрайта
                ADD A, #40
                JP C, .NextUnit                                     ; если переполнение, то верхняя линия спрайта больше или равно 192
                                                                    ; спрайт ниже экрана
                NEG                                                 ; А - хранит количество рисуемых строк
                SUB C
                JP C, .ClipAtBottom                                 ; урезан нижней частью экрана

                ; ---------------------------------------------
                ; спрайт рисуется полностью
                ; ---------------------------------------------

                ; сохраним высоту спрайта
                LD A, C                                             ; A = Sy (высота спрайта)                    
                LD (.RowOffset), A

                ; получение адреса строки
.ScrRowAdr      LD H, (HIGH SCR_ADR_ROWS_TABLE) >> 1
                ADD HL, HL
                LD A, (HL)
                INC HL
                LD H, (HL)
                LD L, A
                LD (.ScrAdr), HL
                JP .ClipRow

                ; ---------------------------------------------
                ; спрайт урезан верхней частью экрана
                ; ---------------------------------------------
.ClipAtTop      NEG                                                 ; меняем знак, чтобы получить количество пропускаемых строк
                LD B, A                                             ; B = хранит количество пропускаемых строк
                
                LD DE, (.ContainerSpr)
                LD A, (DE)                                          ; A =  Sx (ширина спрайта в знакоместах)
                DEC A
                LD C, A
                JR Z, .SkipMult_YxSx
.Mult_YxSx      ADD A, D
                DEC E
                JR NZ, .Mult_YxSx
.SkipMult_YxSx  ADD A, A                                            ; x2 т.к. OR & XOR
                LD (.SpriteOffset), A                               ; сохраним количество пропускаемых строк
                LD A, L                                             ; L - хранит номер нижней линии спрайта == количество рисуемых строк
                LD (.RowOffset), A                                  ; сохраним количество рисуемых строк
                ;
                LD HL, #4000
                LD (.ScrAdr), HL
                JP .ClipRow

                ; ---------------------------------------------
                ; спрайт урезан нижней частью экрана
                ; ---------------------------------------------
.ClipAtBottom   ;если не чётное увеличим в большую сторону (портит 32 байта после экранной области!)
                ADD A, E                                            ; А - хранит количество пропускаемых строк
                RRA
                ADC A, #00
                RLA
                LD (.RowOffset), A
                JP .ScrRowAdr

                ; ---------------------------------------------
                ; горизонтальный клипинг
                ; ---------------------------------------------
.ClipRow
.ContainerSpr   EQU $+1
                LD HL, #0000

                LD C, (HL)
                INC HL
                LD B, (HL)
                INC HL
                LD (.ContainerSpr_), HL

                ; ---------------------------------------------
                ; B - горизонтальное смещение (SOx), C - ширина спрайта (Sx)  !!!! [ в знакоместах ]
                ; ---------------------------------------------

                ; добавить смещение относительно тайла (можно объеденить с константным значением 8)
                ; (Ox + 8)
.LocOffset_X    EQU $+1
                LD A, #00                                   ; A = FUnitLocation.OffsetByPixel.Y (Ox)
                ADD A, #08                                  ; A += 8

                ; (Sx - SOx)
                SUB B                                       ; A -= SOx
                EX AF, AF'
                LD A, C
                ADD A, A
                ADD A, A
                ADD A, A
                LD B, A
                EX AF, AF'
                ADD A, B                                    ; A += Sx

                ; ---------------------------------------------
                ; B - ширина спрайта в пикселах (Sx), C - ширина спрайта в знакоместах (Sx)
                ; ---------------------------------------------

                ; преобразуем резульат (Ox + 8 + Sx - SOx) в 16-битное число
                LD E, A                                     ; E = Ox + 8 + Sx - SOx
                SBC A, A                                    ; если было переполнение (отрицательное число), корректируем
                LD D, A

                ; A = position_x * 16
.Pos_X          EQU $+1
                LD A, #00
                DEC A                   ; A = [-1..16] - position_x
                ADD A, A
                ADD A, A
                ADD A, A

                ; преобразуем результат (position_x * 16) в 16-битное число
                LD L, A
                SBC A, A
                LD H, A
                ADD HL, HL

                ; offset_x = position_x * 16 + (Sx - SOx + Ox + 8)
                OR A
                ADC HL, DE                                  ; необходим для определения знака (16-битного числа)
                ; - если отрицательное или равно нулю, спрайт левее экрана (не видим)
                JP M, .PreNextUnit                          ; offset_x - значение отрицательное
                JP Z, .PreNextUnit                          ; offset_x - значение нулевое

                ; расчитаем левую часть спрайта
                ; offset_x -= Sx
                XOR A
                LD D, A
                LD E, B
                SBC HL, DE
                JP Z, .SpriteNotShift                       ; на краю экрана ???????????????
                JP C, .ClipAtLeft                           ; урезан левой частью экрана
                OR H
                JP NZ, .PreNextUnit                         ; левая часть спрайта за правой частью экрана
                LD A, L
                NEG
                SUB B
                JP C, .ClipAtRight                          ; урезан правой частью экрана

                ; ---------------------------------------------
                ; спрайт рисуется полностью
                ; ---------------------------------------------

                ; получение номера столбца
                LD A, L
                RRA
                RRA
                RRA
                AND %00011111
.SpriteNotShift LD (.ColumnOffset), A

                ; расчёт смещения в знакоместе
                LD A, L
                AND %00000111
                LD HL, TableJumpDraw
                JR Z, .CalcJumpAdr                          ; если ноль, спрайт рисуется полность, без сдвига

                ; ---------------------------------------------
                ; спрайт рисуется полность, со сдвигом
                ; ---------------------------------------------
                ; calculate address of shift table
                EXX
                DEC A
                ADD A, A
                ADD A, HIGH ShiftTable
                LD H, A
                EXX

                LD HL, TableShiftJumpDraw
                
.CalcJumpAdr    ; расчёт адреса в таблице по длине спрайта
                LD A, C                                     ; A =  Sx (ширина спрайта в знакоместах)
                DEC A
                ADD A, A     
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H
                PUSH HL
                POP IX
                JP .Draw

                ; ---------------------------------------------
                ; спрайт урезан левой частью экрана
                ; ---------------------------------------------
                ; L - номер правой части спрайта (в пикселах)
                ; B - ширина спрайта в пикселах (Sx), C - ширина спрайта в знакоместах (Sx)

.ClipAtLeft     ; расчёт смещения в знакоместе
                LD A, L
                AND %00000111
                JR Z, .CalcJumpAdr_L                        ; если ноль, спрайт урезан левой частью экрана, без сдвига

                ; ---------------------------------------------
                ; спрайт урезан левой частью экрана, со сдвига
                ; ---------------------------------------------
                ; calculate address of shift table
                EXX
                DEC A
                ADD A, A
                ADD A, HIGH ShiftTable
                LD H, A
                INC H       ; временно
                EXX

.CalcJumpAdr_L  ; расчёт адреса в таблице по длине спрайта
                LD A, L
                NEG
                RRA
                RRA
                RRA
                AND %00011111
                ADD A, A    ; x2
                ADD A, A    ; x4

                ; смещение в таблице, если байт выравнен
                JR NZ, $+4
                ADD A, 12
                DEC C
                ADD A, C    ; + смещение (байтовое)
                ADD A, A    ; x2 (адрес)

                ; расчёт адреса обработчика
                LD HL, TableLSJumpDraw
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H
                PUSH HL
                POP IX

                ; сброс смещения колонки
                XOR A
                LD (.ColumnOffset), A
                JP .Draw

                ; ---------------------------------------------
                ; спрайт урезан правой частью экрана
                ; ---------------------------------------------
                ; L - номер правой части спрайта (в пикселах)
                ; A - количество пропускаемых пикселей спрайта
                ; B - ширина спрайта в пикселах (Sx), C - ширина спрайта в знакоместах (Sx)
.ClipAtRight    EX AF, AF'          ; save A

                ; расчёт смещения в знакоместе
                LD A, L
                AND %00000111
                JR Z, .CalcJumpAdr_R                        ; если ноль, спрайт урезан правой частью экрана, без сдвига

                ; ---------------------------------------------
                ; спрайт урезан правой частью экрана, со сдвига
                ; ---------------------------------------------
                ; calculate address of shift table
                EXX
                DEC A
                ADD A, A
                ADD A, HIGH ShiftTable
                LD H, A
                EXX

.CalcJumpAdr_R  ; расчёт знакоместа
                LD A, L
                RRA
                RRA
                RRA
                AND %00011111
                LD (.ColumnOffset), A

                ; расчёт адреса в таблице по длине спрайта
                EX AF, AF'      ; resore A
                NEG
                RRA
                RRA
                RRA
                AND %00011111
                ADD A, A    ; x2
                ADD A, A    ; x4

                ; смещение в таблице, если байт выравнен
                JR NZ, $+4
                ADD A, 12
                DEC C
                ADD A, C    ; + смещение (байтовое)
                ADD A, A    ; x2 (адрес)

                ; расчёт адреса обработчика
                LD HL, TableRSJumpDraw
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H
                PUSH HL
                POP IX

                ; ---------------------------------------------
                ; отображение спрайта
                ; ---------------------------------------------
.Draw           ; подсчёт видимых юнитов
                ifdef SHOW_VISIBLE_UNITS
                LD A, (VisibleUnits)
                INC A
                LD (VisibleUnits), A
                endif

.ContainerSpr_  EQU $+1
                LD HL, #0000

                LD A, (HL)
                INC HL
                LD B, (HL)
                INC HL

                ; 7 бит, говорит об использовании маски по смещению
                BIT 7, B

                ; ---------------------------------------------
                ; установим страницу спрайта
                ; ---------------------------------------------
                SeMemoryPage_A

                ; ---------------------------------------------
                ; модификация адреса спрайта
                ; ---------------------------------------------
                LD A, (HL)
                INC HL
                LD H, (HL)
                LD L, A
.SpriteOffset   EQU $+1
                LD DE, #0000
                ADD HL, DE

                ; ---------------------------------------------
                ; корректировка адреса экран
                ; ---------------------------------------------
                EXX
.ScrAdr         EQU $+1                        
                LD BC, #0000    ; экран
                LD A, C
.ColumnOffset   EQU $+1
                ADD A, #00
                LD C, A
                EXX

                ; ---------------------------------------------
                ; двухпроходные вызовы
                ; ---------------------------------------------
                LD HL, .JumpsRows
                LD A, #18
.RowOffset      EQU $+1
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
.JumpsRows      rept 12
                JP (IX)
                endr

                ; ---------------------------------------------
                ; всё же, спрайт за пределами экрана
                ; ---------------------------------------------
.PreNextUnit    POP DE                      ; restore address UnitsArray

.NextUnit       INC E
                INC E
                INC E
                ;
                LD HL, .ProcessedUnits
                DEC (HL)
                JP NZ, .Loop

.Exit           ; включить страницу
                SeMemoryPage MemoryPage_ShadowScreen

                RET

.ProcessedUnits DB #00

                ifdef SHOW_VISIBLE_UNITS
VisibleUnits    DB #00
                endif

                endif ; ~ _CORE_MODULE_UNIT_HANDLER_