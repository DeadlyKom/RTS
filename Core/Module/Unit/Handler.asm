
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

                RestoreBC

                ifdef SHOW_VISIBLE_UNITS
                XOR A
                LD (VisibleUnits), A
                endif

                ; ---------------------------------------------
                ; Lx, Ly   - позиция юнита (в тайлах)
                ; Vx, Vy   - позиция видимой области карты (в тайлах)
                ; Ox, Oy   - смещение относительно тайла в которых расположен юнит (в пикселах)
                ; Sx, Sy   - ширина спрайта (в пикселах)
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

                ; получение адреса хранения информации о спрайте
                INC D                                               ; перейдём на адрес структуры FUnitState
                DEC E
                CALL Animation.SpriteInfo                           ; получение информации о спрайте

                ; ---------------------------------------------
                ; HL - указывает на адрес информации о спрайте
                ; DE - указывает на адрес структуры FUnitState + 3
                ; A' - position_y
                ; ---------------------------------------------

                ; protection data corruption during interruption
                LD (.ContainerSP), SP
                LD C, (HL)
                INC HL
                LD B, (HL)
                INC HL
                LD SP, HL

                ; ---------------------------------------------
                ; SP - указывает на адрес информации о спрайте
                ; B - вертикальное смещение (SOy), C - высота спрайта (Sy) [нельзя изменять!]
                ; ---------------------------------------------

                DEC D                                               ; перейдём на адрес структуры FUnitLocation + 3
                
                ; добавить смещение относительно тайла (можно объеденить с константным значением 8)
                ; (Oy + 8)
                LD A, (DE)                                          ; A = FUnitLocation.OffsetByPixel.Y
                ADD A, #08                                          ; A += 8

                ; ; (Sy - SOy)
                ; ADD A, C                                            ; A += Sy
                ; SUB B                                               ; A -= SOy

                ; ; преобразуем резульат (Oy + 8 + Sy - SOy) в 16-битное число
                ; LD C, A                                             ; C = Oy + 8 + Sy - SOy
                ; SBC A, A                                            ; если было переполнение (отрицательное число), корректируем
                ; LD B, A


                ; A = position_y * 16
                EX AF, AF'
                ADD A, A
                ADD A, A
                ADD A, A
                ADD A, A




                ; подсчёт видимых юнитов
                ifdef SHOW_VISIBLE_UNITS
                LD A, (VisibleUnits)
                INC A
                LD (VisibleUnits), A
                endif

.PreNextUnit    ; всё же, спрайт за пределами экрана
.ContainerSP    EQU $+1
                LD SP, #0000

                POP DE                      ; restore address UnitsArray

.NextUnit       INC E
                INC E
                INC E
                ;
                LD HL, .ProcessedUnits
                DEC (HL)
                JR NZ, .Loop

.Exit           ; включить страницу
                SeMemoryPage MemoryPage_ShadowScreen

                RET

.ProcessedUnits DB #00

                ifdef SHOW_VISIBLE_UNITS
VisibleUnits    DB #00
                endif

                endif ; ~ _CORE_MODULE_UNIT_HANDLER_