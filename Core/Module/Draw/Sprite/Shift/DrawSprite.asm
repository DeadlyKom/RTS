
                ifndef _CORE_MODULE_DRAW_SHIFT_DRAW_SPRITE_
                define _CORE_MODULE_DRAW_SHIFT_DRAW_SPRITE_

                module Shift
; -----------------------------------------
; отображение спрайта без атрибутов
; In:
;   HL - адрес спрайта
;   DE - координаты в знакоместах (D - y, E - x)
;   BC - размер (B - y, C - x)
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Draw:
                display " - Shift Draw : \t\t", /A, Draw, " = busy [ ", /D, $ - Draw, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_SHIFT_DRAW_SPRITE_
