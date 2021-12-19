
                ifndef _DRAW_SPRITE_FAST_CLIPPING_
                define _DRAW_SPRITE_FAST_CLIPPING_

; -----------------------------------------
; отсечение спрайта, т.к. спрайт приязан к тайлу,
;   можно быстро проверить, видим ли данный тайл
; In:
;   DE - указывает на структуру FSpriteLocation
; Out:
;   DE = DE + 1 [FSpriteLocation.TilePosition.Y]
;   если флаг переполнения C установлен, объект вне экрана
;   иначе в аккамуляторах хранятся значения в пределах
;   A  -  PositionY => [0..13]
;   A' -  PositionX => [0..17]
; Corrupt:
;   HL, DE, AF, AF'
; Note:
;   Lx, Ly   - позиция спрайта (в тайлах)
;   Vx, Vy   - позиция видимой области карты (в тайлах)
; -----------------------------------------
FastClipping:   ; ---------------------------------------------
                ; грубое отсечение спрайта
                ; ---------------------------------------------

                LD HL, TilemapOffsetRef                                         ; HL = позиция X, указатель смещения тайловой карты (координаты тайла, верхнего левого угла)

                ; ---------------------------------------------
                ; PositionX = (Lx - Vx) + 1
                LD A, (DE)                                                      ; [Lx] DE = FSpriteLocation.TilePosition.X
                SUB (HL)                                                        ; [Vx] - позиция видимой области карты (в тайлах)
                INC A

                ; RET M                                                           ; PositionX < 0, находится левее экран
                RLA
                RET C                                                           ; PositionX < 0, находится левее экран
                RRA

                CP TilesOnScreenX + 2
                ; RET NC                                                          ; PositionX >= 18, находится правее экрана
                CCF
                RET C                                                           ; PositionX >= 18, находится правее экрана

                ; A = PositionX => [0..17]
                EX AF, AF'                                                      ; сохраним PositionX
                ; ---------------------------------------------

                INC E                                                           ; DE = FSpriteLocation.TilePosition.Y
                INC HL                                                          ; HL = позиция Y, указатель смещения тайловой карты (координаты тайла, верхнего левого угла)

                ; ---------------------------------------------
                ; PositionY = (Ly - Vy) + 1
                LD A, (DE)                                                      ; [Ly] DE = FSpriteLocation.TilePosition.X
                SUB (HL)                                                        ; [Vy] - позиция видимой области карты (в тайлах)
                INC A
                ; RET M                                                           ; PositionY < 0, находится левее экран
                RLA
                RET C                                                           ; PositionX < 0, находится левее экран
                RRA

                CP TilesOnScreenY + 2
                ; RET NC                                                          ; PositionY >= TilesOnScreenY + 2, находится правее экрана
                CCF
                ; A = PositionY => [0..13]
                ; ---------------------------------------------
                RET

                endif ; ~_DRAW_SPRITE_FAST_CLIPPING_
