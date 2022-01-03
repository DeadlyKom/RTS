
                ifndef _DRAW_SPRITE_FAST_CLIPPING_
                define _DRAW_SPRITE_FAST_CLIPPING_

; -----------------------------------------
; отсечение спрайта, т.к. спрайт приязан к тайлу,
;   можно быстро проверить, видим ли данный тайл
; In:
;   IY - указывает на структуру FUnit
; Out:
;   если флаг переполнения C установлен, объект вне экрана
;   иначе в аккамуляторах хранятся значения в пределах
;   PixelClipping.PositionX -  PositionX => [0..17]
;   PixelClipping.PositionY -  PositionY => [0..13]
; Corrupt:
;   HL, DE, AF
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
                LD A, (IY + FUnit.Position.X)
                SUB (HL)                                                        ; [Vx] - позиция видимой области карты (в тайлах)
                INC A

                ; замена RET M
                RLA
                RET C                                                           ; PositionX < 0, находится левее экран
                RRA

                CP TilesOnScreenX + 2
                ; замена RET NC
                CCF
                RET C                                                           ; PositionX >= 18, находится правее экрана

                ; A = PositionX => [0..17]
                LD (PixelClipping.PositionX), A                                 ; сохраним PositionX
                ; ---------------------------------------------

                INC HL                                                          ; HL = позиция Y, указатель смещения тайловой карты (координаты тайла, верхнего левого угла)

                ; ---------------------------------------------
                ; PositionY = (Ly - Vy) + 1
                LD A, (IY + FUnit.Position.Y)
                SUB (HL)                                                        ; [Vy] - позиция видимой области карты (в тайлах)
                INC A
                ; замена RET M
                RLA
                RET C                                                           ; PositionX < 0, находится левее экран
                RRA

                CP TilesOnScreenY + 2
                ; замена RET NC
                CCF
                ; A = PositionY => [0..13]
                LD (PixelClipping.PositionY), A                                 ; сохраним PositionX
                ; ---------------------------------------------
                RET
; -----------------------------------------
; сохранение предыдущего значения быстрого клипинга
; In:
; Out:
;   BC - сохраняемы значения (B - y, C - x)
; Corrupt:
;   BC, AF
; Note:
; -----------------------------------------
SaveClip:       LD A, (PixelClipping.PositionX)
                LD C, A
                LD A, (PixelClipping.PositionY)
                LD B, A
                RET
; -----------------------------------------
; востановление ранее сохранёных значений быстрого клипинга
; In:
;   BC - сохраняемы значения (B - y, C - x)
; Out:
; Corrupt:
;   BC, AF
; Note:
; -----------------------------------------
RestoreClip:    LD A, C
                LD (PixelClipping.PositionX), A
                LD A, B
                LD (PixelClipping.PositionY), A
                RET

                endif ; ~_DRAW_SPRITE_FAST_CLIPPING_
