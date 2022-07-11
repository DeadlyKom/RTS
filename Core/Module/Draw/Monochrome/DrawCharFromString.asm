
                ifndef _CORE_MODULE_DRAW_MONOCHROME_DRAW_CHAR_FROM_STRING_
                define _CORE_MODULE_DRAW_MONOCHROME_DRAW_CHAR_FROM_STRING_

                module Monochrome
; -----------------------------------------
; отображение символа из строки на экран
; In:
;   HL - адрес строки
;   DE - координаты в пикселах (D - y, E - x)
;   A' - смещение в строке
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawCharToScr:  CALL PixelAddressP                                              ; DE - адрес экрана
                RES 7, D

                ;   BC - адрес экрана
                ;   A  - номер бита

                LD HL, SharedBuffer
                LD B, #08

.Loop           LD A, (HL)
                LD (DE), A

                LD A, L
                ADD A, #20
                LD L, A

                ; classic method "DOWN_DE" 25/59
                INC D
                LD A, D
                AND #07
                JP NZ, $+12
                LD A, E
                SUB #E0
                LD E, A
                SBC A, A
                AND #F8
                ADD A, D
                LD D, A

                DJNZ .Loop
                
                RET

                display " - Draw Char : \t\t", /A, DrawCharToScr, " = busy [ ", /D, $ - DrawCharToScr, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_MONOCHROME_DRAW_CHAR_FROM_STRING_
