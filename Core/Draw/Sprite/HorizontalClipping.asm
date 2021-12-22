
                ifndef _DRAW_SPRITE_HORIZONTAL_CLIPPING_
                define _DRAW_SPRITE_HORIZONTAL_CLIPPING_

                module Clipping

; -----------------------------------------
; отсечение спрайта по горизонтали
; In:
;   HL - указатель на структуру FSprite
;   DE - указывает на структуру FSpriteLocation
; Out:
;   если флаг переполнения C установлен, объект вне экрана
; Corrupt:
; Note:
;   Lx, Ly   - позиция спрайта (в тайлах)
;   Vx, Vy   - позиция видимой области карты (в тайлах)
;   Ox, Oy   - смещение спрайта относительно тайла (в пикселах)
;   Sx, Sy   - размер спрайта (х - в знакоместах, y - в пикселах)
;   SOx, SOy - смещение спрайта (в пикселах)
; -----------------------------------------
Horizontal:     ;

.Clipped        ; ---------------------------------------------
                ; спрайт вне экрана
                ; ---------------------------------------------
                SCF
                RET

                endmodule

                endif ; ~_DRAW_SPRITE_HORIZONTAL_CLIPPING_
