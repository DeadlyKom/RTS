
                ifndef _CORE_MODULE_DRAW_ATTRIBUTE_PIXEL_ADDRESS_
                define _CORE_MODULE_DRAW_ATTRIBUTE_PIXEL_ADDRESS_

                module Attribute
; -----------------------------------------
; расчёт экраного адреса
; In:
;   DE - координаты в знакоместах (D - y, E - x)
; Out:
;   DE - адрес экрана пикселей
; Corrupt:
; Note:
; -----------------------------------------
PixelAddress:   LD A, D
                RRCA
                RRCA
                RRCA
                AND #E0
                ADD A, E
                LD E, A
                LD A, D
                AND #18
                OR #C0
                LD D, A
                RET

                display " - Pixel Address : \t\t", /A, PixelAddress, " = busy [ ", /D, $ - PixelAddress, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_ATTRIBUTE_PIXEL_ADDRESS_
