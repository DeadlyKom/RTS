
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
                SeMemoryPage MemoryPage_Tilemap, UNIT_HANDLER_BEGIN_ID

                ; инициализация
                ifdef SHOW_VISIBLE_UNITS
                XOR A
                LD (VisibleUnits), A
                endif

                ; ; проверка на наличие юнитов в массиве
                ; ; LD A, (CountUnitsRef)
                ; OR A
                ; JP Z, .Exit
                ; LD (.ProcessedUnits), A

                ; LD HL, MapStructure + FMap.UnitsArray
                ; LD E, (HL)
                ; INC L
                ; LD D, (HL)

                LD HL, UnitClusterRef + FUnitCluster.NumArray
                LD DE, UnitClusterRef + FUnitCluster.TmpNumArray
                dup 8
                LDI
                edup
                ; EX DE, HL                               ; сохраним DE - указывает на FUnitCluster.TmpNumArray + 0

                ;
                ; DE - указывает на FUnitCluster.TmpNumArray + 0
                LD DE, (UnitArrayRef)                   ; HL - указывает на массив юнитов
;                 JP .Continue

; .NextCluster    INC HL
;                 LD A, E
;                 AND %11110000
;                 ADD A, #40
;                 LD E, A

;                 JP C, .Exit                             ; 4 кластера закончились

.Continue       LD A, (HL)
                OR A
                JP Z, .NextCluster
                LD (.ProcessedUnits), HL

                ; EX DE, HL
                
                ; проверка на перерисовку всех юнитов принудительно
                LD HL, FrameUnitsFlagRef
                SRA (HL)
                LD A, #7F                               ; #3F для AND
                LD HL, #C312                            ; LD (DE), A : JP
                LD BC, .Force
                JR C, .Modify                           ; включим пропуск проверки обновления юнита
                LD A, #C0                               ; #C0 для AND
                LD HL, #00CA | (LOW  .PreNextUnit << 8) ; JP Z,. PreNextUnit
                LD BC, #EB00 | (HIGH .PreNextUnit << 0) ; EX DE, HL

.Modify         ; модификация кода
                LD (.ModifyCode + 0), A
                LD (.ModifyCode + 1), HL
                LD (.ModifyCode + 3), BC

.Loop           PUSH DE                                 ; save current address UnitsArray

                ; ---------------------------------------------
                ; Lx, Ly   - позиция юнита (в тайлах)
                ; Vx, Vy   - позиция видимой области карты (в тайлах)
                ; Ox, Oy   - смещение относительно тайла в которых расположен юнит (в пикселах)
                ; Sx, Sy   - ширина спрайта (в пикселах)  !!!! [ х - в знакоместах ]
                ; SOx, SOy - смещение спрайта (в пикселах)
                ; ---------------------------------------------

                ; проврка на перерисовку текущего юнита
                LD A, (DE)
.ModifyCode     EQU $+1
                AND %11000000
                JP Z, .PreNextUnit

                ; сброс состояния обновления спрайта юнита
                EX DE, HL
                LD A, (HL)
                LD E, A
                AND %0011111
                LD D, A
                LD A, E
                RRA
                AND %11000000
                OR D
                LD (HL), A
                EX DE, HL

.Force          INC D                                               ; переход к стурктуре FUnitLocation

                ; грубый расчёт
                LD HL, TilemapOffsetRef

                ; position_x = (Lx - Vx) + 1
                LD A, (DE)
                INC E
                SUB (HL)
                INC HL
                INC A
                JP M, .PreNextUnit                                  ; position_x < 0, находится левее экран
                CP TilesOnScreenX + 2
                JP NC, .PreNextUnit                                 ; position_x >= 18, находится правее экрана

                ; ---------------------------------------------
                ; A = [0..17] - position_x
                ; ---------------------------------------------
                LD (.Pos_X), A

                ; position_y = (Ly - Vy) + 1
                LD A, (DE)
                SUB (HL)
                INC A
                JP M, .PreNextUnit                                  ; position_y < 0, находится левее экран
                CP TilesOnScreenY + 2
                JP NC, .PreNextUnit                                 ; position_y >= 14, находится правее экрана

                ; ---------------------------------------------
                ; A = [0..13] - position_y
                ; ---------------------------------------------
                EX AF, AF'                  ; save position_y
                XOR A
                LD (.SpriteOffset), A       ; отсутствует пропуск байт в спрайте

                ; получение адреса хранения информации о спрайте
                DEC D                                               ; перейдём на адрес структуры FUnitState
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
                ; B - вертикальное смещение в пикселях (SOy), C - высота спрайта в пикселях (Sy)
                ; ---------------------------------------------

                INC D                                               ; перейдём на адрес структуры FUnitLocation + 3
                
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
                OR A
                ADC HL, DE                                          ; необходим для определения знака (16-битного числа)
                ; - если отрицательное или равно нулю, спрайт выше экрана (не видим)
                JP M, .PreNextUnit                                  ; offset_y - значение отрицательное
                JP Z, .PreNextUnit                                  ; offset_y - значение нулевое

                ; расчитаем верхнюю часть спрайта
                ; offset_y -= Sy
                LD A, L                                             ; L - хранит номер нижней линии спрайта
                ; !!!!!!!!!!!!!!!!!!!!!! Top Line
                ; LD (.BottomRow), A
                SUB C
                ; !!!!!!!!!!!!!!!!!!!!!! Bottom Line
                ; LD (.TopRow), A
                JP C, .ClipAtTop                                    ; урезан верхней частью экрана
                LD L, A                                             ; L - хранит номер верхней линии спрайта
                ADD A, #40
                JP C, .PreNextUnit                                  ; если переполнение, то верхняя линия спрайта больше или равно 192
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
                LD (.SpriteSize), A

                ; получение адреса строки
.ScrRowAdr      LD H, (HIGH SCR_ADR_ROWS_TABLE) >> 1
                ADD HL, HL
                LD A, (HL)
                INC HL
                LD H, (HL)
                LD L, A

                AdjustHighScreenByte_H

                LD (.ScrAdr), HL
                JP .ClipRow

                ; ---------------------------------------------
                ; спрайт урезан верхней частью экрана
                ; ---------------------------------------------
                ; L - хранит номер нижней линии спрайта
.ClipAtTop      NEG                                                 ; меняем знак, чтобы получить количество пропускаемых строк
                LD B, A                                             ; B = хранит количество пропускаемых строк
                EX DE, HL
                LD HL, (.ContainerSpr)
                LD C, (HL)                                          ; C =  Sx (ширина спрайта в знакоместах)
                DEC C
                JR Z, .SkipMult_YxSx
.Mult_YxSx      ADD A, B
                DEC C
                JR NZ, .Mult_YxSx
.SkipMult_YxSx  ADD A, A                                            ; x2 т.к. OR & XOR
                LD (.SpriteOffset), A                               ; сохраним количество пропускаемых строк

                ; сохраним высоту спрайта
                LD A, E                                             ; E - хранит номер нижней линии спрайта == количество рисуемых строк
                LD (.RowOffset), A                                  ; сохраним количество рисуемых строк
                LD (.SpriteSize), A
                
                ; адрес константный, меняется только номер столбца
                LD HL, #4000
                AdjustHighScreenByte_H

                LD (.ScrAdr), HL
                JP .ClipRow

                ; ---------------------------------------------
                ; спрайт урезан нижней частью экрана
                ; ---------------------------------------------
                ; L - хранит номер верхней линии спрайта
.ClipAtBottom   ; если не чётное увеличим в большую сторону (портит 32 байта после экранной области!)
                ADD A, C                                            ; А - хранит количество пропускаемых строк
                RRA
                ADC A, #00
                RLA

                ; сохраним высоту спрайта
                LD (.RowOffset), A
                LD (.SpriteSize), A
                JP .ScrRowAdr

                ; ---------------------------------------------
                ; горизонтальный клипинг
                ; ---------------------------------------------
.ClipRow
.ContainerSpr   EQU $+1
                LD HL, #0000

                LD C, (HL)
                INC HL
                LD E, (HL)
                INC HL
                LD (.ContainerSpr_), HL

                ; ---------------------------------------------
                ; E - горизонтальное смещение в пикселях (SOx), C - ширина спрайта в знакоместах (Sx)
                ; ---------------------------------------------

                ; сохраним ширину спрайта
                LD A, C
                LD (.SpriteSize + 1), A

                ; добавить смещение относительно тайла (можно объеденить с константным значением 8)
                ; (Ox + 8)
.LocOffset_X    EQU $+1
                LD A, #00                                   ; A = FUnitLocation.OffsetByPixel.Y (Ox)
                ADD A, #08                                  ; A += 8

                ; ширину спрайта конвертируем в киксели
                EX AF, AF'
                LD A, C
                ADD A, A
                ADD A, A
                ADD A, A
                LD B, A
                EX AF, AF'

                ; (Sx - SOx)
                ADD A, B                                    ; A += Sx
                SUB E                                       ; A -= SOx

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

                ; !!!!!!!!!!!!!!!!!!!!!! Left Line
                ; LD A, L
                ; LD (.RightColumn), A

                ; расчитаем левую часть спрайта
                ; offset_x -= Sx
                XOR A
                LD D, A
                LD E, B
                SBC HL, DE

                ; !!!!!!!!!!!!!!!!!!!!!! Right Line
                ; EX AF, AF'
                ; LD A, L
                ; LD (.LeftColumn), A
                ; EX AF, AF'

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

                ; получим адрес метода отрисовки
                LD A, (HL)
                LD IXL, A
                INC L
                LD A, (HL)
                LD IXH, A
                JP .Draw

                ; ---------------------------------------------
                ; спрайт урезан левой частью экрана
                ; ---------------------------------------------
                ; L - номер правой части спрайта (в пикселах)
                ; B - ширина спрайта в пикселах (Sx), C - ширина спрайта в знакоместах (Sx)

.ClipAtLeft     ; расчёт смещения в знакоместе
                LD A, L
                AND %00000111
                LD B, A     ; спрайт выровнен, смещение в таблице отсутствует
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

                LD B, #0C   ; спрайт не выровнен, смещение в таблице

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
                ADD A, B    ; если спрайт выровнен, смещение в таблице отсутствует
                DEC C
                ADD A, C    ; + смещение (байтовое)
                ADD A, A    ; x2 (адрес)

                ; расчёт адреса обработчика
                LD HL, TableLSJumpDraw
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H
                
                ; получим адрес метода отрисовки
                LD A, (HL)
                LD IXL, A
                INC L
                LD A, (HL)
                LD IXH, A

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
                LD B, A     ; спрайт выровнен, смещение в таблице отсутствует
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

                LD B, #0C   ; спрайт не выровнен, смещение в таблице

.CalcJumpAdr_R  ; расчёт знакоместа
                LD A, L
                RRA
                RRA
                RRA
                AND %00011111
                LD (.ColumnOffset), A

                ; расчёт адреса в таблице по длине спрайта
                EX AF, AF'  ; resore A
                NEG
                RRA
                RRA
                RRA
                AND %00011111
                ADD A, A    ; x2
                ADD A, A    ; x4

                ; смещение в таблице, если байт выравнен
                ADD A, B    ; если спрайт выровнен, смещение в таблице отсутствует
                DEC C
                ADD A, C    ; + смещение (байтовое)
                ADD A, A    ; x2 (адрес)

                ; расчёт адреса обработчика
                LD HL, TableRSJumpDraw
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H

                ; получим адрес метода отрисовки
                LD A, (HL)
                LD IXL, A
                INC L
                LD A, (HL)
                LD IXH, A

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

                LD E, (HL)                  ; Dummy - смещение + Data = адрес маски
                INC HL
                LD D, (HL)                  ; Page - 7 бит, говорит об использовании маски по смещению
                INC HL

                ; ---------------------------------------------
                ; установим страницу спрайта
                ; ---------------------------------------------
                LD A, D
                SeMemoryPage_A RENDER_UINT_PAGE_SPR_ID

                ; ---------------------------------------------
                ; модификация адреса спрайта
                ; ---------------------------------------------
                LD A, (HL)
                INC HL
                LD H, (HL)
                LD L, A
.SpriteOffset   EQU $+1
                LD BC, #0000
                ADD HL, BC

                ; ---------------------------------------------
                ; B - Sx (ширина спрайта в знакоместах)
                ; C - Sy (высота спрайта в пикселях)
                ; ---------------------------------------------
.SpriteSize     EQU $+1
                LD BC, #0000
                ; ---------------------------------------------
                ; копирование спрайта в буфер
                ; ---------------------------------------------
                BIT 7, D                    ; 7 бит, говорит об использовании маски по смещению
                CALL MEMCPY.Sprite

                SeMemoryPage MemoryPage_ShadowScreen, UNIT_HANDLER_RENDER_ID

                ; ---------------------------------------------
                ; корректировка адреса экран
                ; ---------------------------------------------
                EXX
.ScrAdr         EQU $+1                        
                LD DE, #0000    ; экран
                LD A, E
.ColumnOffset   EQU $+1
                OR #00
                LD E, A
                EXX

                ;
                LD (.ContainerSP), SP

                ; protection data corruption during interruption
                RestoreBC
                LD C, (HL)
                INC L
                LD B, (HL)
                DEC L
                PUSH BC
                EXX
                POP BC
                EXX
                LD SP, HL

                ; ---------------------------------------------
                ; двухпроходные вызовы
                ; ---------------------------------------------
                LD HL, .JumpsRows
                LD A, #18
.RowOffset      EQU $+1
                SUB #00
                LD E, A
                LD D, #00
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

.ContainerSP    EQU $+1
                LD SP, #0000

                ; включить страницу 
                SeMemoryPage MemoryPage_Tilemap, UNIT_HANDLER_IT_ID

                ; ---------------------------------------------
                ; всё же, спрайт за пределами экрана
                ; ---------------------------------------------
.PreNextUnit    POP DE                      ; restore address UnitsArray

.NextUnit       INC E
                INC E
                INC E
                INC E
                ;
.ProcessedUnits EQU $+1
                LD HL, #0000
                DEC (HL)
                JP NZ, .Loop

.NextCluster    INC HL
                LD A, E
                AND %11110000
                ADD A, #40
                LD E, A

                JP C, .Exit

                LD A, (HL)
                OR A
                JR Z, .NextCluster
                LD (.ProcessedUnits), HL

                ; EX DE, HL
                JP .Loop

                ; EX DE, HL
                ; JP .NextCluster

                ; ;
                ; ; DE - указывает на FUnitCluster.TmpNumArray + 0
                ; LD HL, (UnitArrayRef)                   ; HL - указывает на массив юнитов
;                 JP .Continue

; .NextCluster    INC DE
;                 LD A, L
;                 AND %11110000
;                 ADD A, #40
;                 LD L, A

;                 JP C, .Exit                             ; 4 кластера закончились

; .Continue       LD A, (DE)
;                 OR A
;                 JR NZ, .NextCluster
;                 LD (.ProcessedUnits), DE

;                 EX DE, HL

.Exit           RET

                ifdef SHOW_VISIBLE_UNITS
VisibleUnits    DB #00

                endif


                endif ; ~ _CORE_MODULE_UNIT_HANDLER_