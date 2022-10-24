
                ifndef _CORE_MODULE_DRAW_UTILS_PIXEL_ADDRESS_
                define _CORE_MODULE_DRAW_UTILS_PIXEL_ADDRESS_

                module Utils
; -----------------------------------------
; расчёт экраного адреса
; In:
;   DE - координаты в знакоместах (D - y, E - x)
; Out:
;   DE - адрес экрана пикселей
; Corrupt:
; Note:
; -----------------------------------------
PixelAddressC:  LD A, D
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
; -----------------------------------------
; расчёт экраного адреса
; In :
;   DE - координаты в пикселях (D - y, E - x)
; Out :
;   DE - адрес экрана (адресное пространство теневого экрана)
;   A  - номер бита (CPL)/ смещение от левого края
; Corrupt :
;   DE, AF
; Time :
;   128cc
; -----------------------------------------
PixelAddressP:  LD A, D
                RRA
                RRA
                RRA
                XOR D
                AND %00011000
                XOR D
                AND %00011111
                OR #C0
                EX AF, AF'
                LD A, D
                ADD A, A
                ADD A, A
                LD D, A
                LD A, E
                RRA
                RRA
                RRA
                XOR D
                AND %00011111
                XOR D
                EX AF, AF'
                LD D, A
                LD A, E
                ; CPL
                AND %00000111
                EX AF, AF'
                LD E, A
                EX AF, AF'
                RET
 
                display " - Pixel Address : \t\t\t\t\t", /A, PixelAddressC, " = busy [ ", /D, $ - PixelAddressC, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_UTILS_PIXEL_ADDRESS_
