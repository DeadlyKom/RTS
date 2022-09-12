
                ifndef _CORE_MODULE_DRAW_ATTRIBUTE_PIXEL_ATTRIBUTE_
                define _CORE_MODULE_DRAW_ATTRIBUTE_PIXEL_ATTRIBUTE_

                module Attribute
; -----------------------------------------
; конверсия экраного адреса в адрес атрибутов
; In:
;   DE - адрес экрана
; Out:
;   DE - адрес экрана атрибутов
; Corrupt:
;   DE, AF
; Note:
; -----------------------------------------
PixelAttribute: LD A, D
                RRA
                RRA
                AND #06
                ADD A, #B0
                RL D
                RRA
                LD D, A
                RET

                display " - Pixel Attribute : \t\t", /A, PixelAttribute, " = busy [ ", /D, $ - PixelAttribute, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_ATTRIBUTE_PIXEL_ATTRIBUTE_
