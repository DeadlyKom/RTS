
                ifndef _CORE_MODULE_DRAW_ATTRIBUTE_PIXEL_ATTRIBUTE_
                define _CORE_MODULE_DRAW_ATTRIBUTE_PIXEL_ATTRIBUTE_

                module Attribute
; -----------------------------------------
; расчёт экраного адреса атрибутов
; In:
;   DE - координаты в знакоместах (D - y, E - x)
; Out:
;   DE - адрес экрана атрибутов
; Corrupt:
; Note:
; -----------------------------------------
PixelAttribute: LD A, D
                RRA
                RRA
                RRA
                AND #03
                ADD A, #D8
                LD D, A
                RET

                display " - Pixel Attribute : \t\t", /A, PixelAttribute, " = busy [ ", /D, $ - PixelAttribute, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_ATTRIBUTE_PIXEL_ATTRIBUTE_
