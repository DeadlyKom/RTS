
                ifndef _CORE_MODULE_UNIT_RENDER_UPDATE_
                define _CORE_MODULE_UNIT_RENDER_UPDATE_
; -----------------------------------------
; обновление юнита на экране
; In:
;   A - номер юнита
; Out:
; Corrupt:
;   HL, DE, BC, AF, AF'
; -----------------------------------------
RefUnitOnScr:   ; включить страницу
                EX AF, AF'
                SeMemoryPage MemoryPage_Tilemap, REFRESH_UNIT_ON_SCR_ID
                EX AF, AF'

                ToDo "RefUnitOnScr", "Make a light version, consider everything oversimplified, or break it down into what is 100% visible and may be invisible."

                ; определение адреса указанного юнита
                LD HL, MapStructure + FMap.UnitsArray ; UnitArrayPtr
                LD E, (HL)
                INC HL                       ; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                LD D, (HL)
                ADD A, A
                ADD A, A
                LD L, A
                LD H, #00
                ADD HL, DE

                ; ---------------------------------------------
                ; Lx, Ly   - позиция юнита (в тайлах)
                ; Vx, Vy   - позиция видимой области карты (в тайлах)
                ; Ox, Oy   - смещение относительно тайла в которых расположен юнит (в пикселах)
                ; Sx, Sy   - ширина спрайта (в пикселах)  !!!! [ х - в знакоместах ]
                ; SOx, SOy - смещение спрайта (в пикселах)
                ; ---------------------------------------------

                ; установим флаги обновления юнита в 2-х экранах
                LD A, (HL)
                OR %11000000
                LD (HL), A

                EX DE, HL
                INC D                                               ; переход к стурктуре FUnitLocation

                ; грубый расчёт
                LD HL, TilemapOffsetRef

                ; position_x = (Lx - Vx) + 1
                LD A, (DE)
                INC E
                SUB (HL)
                INC HL
                INC A
                RET M                                               ; position_x < 0, находится левее экран
                CP TilesOnScreenX + 2
                RET NC                                              ; position_x >= 18, находится правее экрана

                ; ---------------------------------------------
                ; A = [0..17] - position_x
                ; ---------------------------------------------
                LD (.Pos_X), A

                ; position_y = (Ly - Vy) + 1
                LD A, (DE)
                SUB (HL)
                INC A
                RET M                                               ; position_y < 0, находится левее экран
                CP TilesOnScreenY + 2
                RET NC                                              ; position_y >= 14, находится правее экрана

                ; ---------------------------------------------
                ; A = [0..13] - position_y
                ; ---------------------------------------------
                EX AF, AF'                  ; save position_y

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
                RET M                                               ; offset_y - значение отрицательное
                RET Z                                               ; offset_y - значение нулевое

                ; расчитаем верхнюю часть спрайта
                ; offset_y -= Sy
                LD A, L                                             ; L - хранит номер нижней линии спрайта
                LD (.BottomRow), A                                  ; A - хранит нижнию грань спрайта
                SUB C
                LD (.TopRow), A                                     ; A - хранит верхнию грань спрайта
                JP C, .ClipRow                                      ; урезан верхней частью экрана
                LD L, A                                             ; L - хранит номер верхней линии спрайта
                ADD A, #40
                RET C                                               ; если переполнение, то верхняя линия спрайта больше или равно 192

                ; ---------------------------------------------
                ; горизонтальный клипинг
                ; ---------------------------------------------
.ClipRow
.ContainerSpr   EQU $+1
                LD HL, #0000

                LD C, (HL)
                INC HL
                LD E, (HL)
                ; ---------------------------------------------
                ; E - горизонтальное смещение в пикселях (SOx), C - ширина спрайта в знакоместах (Sx)
                ; ---------------------------------------------

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
                RET M                                       ; offset_x - значение отрицательное
                RET Z                                       ; offset_x - значение нулевое

                LD A, H
                OR A
                JR Z, $+4
                LD L, #FF   ; клипинг (правый)
                LD A, L
                LD (.RightColumn), A                        ; A - хранит правую грань спрайта

                ; расчитаем левую часть спрайта
                ; offset_x -= Sx
                XOR A
                LD D, A
                LD E, B
                SBC HL, DE

                JR NC, .L1
                EX AF, AF'
                XOR A
                JR .L2

.L1             EX AF, AF'
                LD A, L
.L2             LD (.LeftColumn), A                         ; A - хранит левую грань спрайта
                EX AF, AF'

                JP Z, .UpdateTile                           ; на краю экрана ???????????????
                JP C, .UpdateTile                           ; урезан левой частью экрана
                OR H
                RET NZ                                      ; левая часть спрайта за правой частью экрана

                ; ---------------------------------------------
                ; пометка областей требующие перерисовки
                ; ---------------------------------------------
                ; H - RightColumn
                ; L - LeftColumn
                ; D - TopRow
                ; E - BottomRow
.UpdateTile     
.LeftColumn     EQU $+1
.RightColumn    EQU $+2
                LD HL, #0000
.BottomRow      EQU $+1
                ; LD A, #00
                ; CP 191
                ; JR C, $
.TopRow         EQU $+2
                LD DE, #0000

                JP Tilemap.TileUpdate

                endif ; ~ _CORE_MODULE_UNIT_RENDER_UPDATE_