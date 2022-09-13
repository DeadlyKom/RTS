
                ifndef _CORE_MODULE_DRAW_CHARBOUNDARY_DRAW_CHAR_BOUNDARY_
                define _CORE_MODULE_DRAW_CHARBOUNDARY_DRAW_CHAR_BOUNDARY_

                module Attribute
; -----------------------------------------
; отрисовка знакоместа с атрибутами (в одном экране)
; In:
;   HL - адрес спрайта
;   DE - адрес экрана пикселей
; Out:
; Corrupt:
;   HL, DE, AF
; Note:
; -----------------------------------------
DrawCharOne:    dup  7
                LD A, (HL)
                LD (DE), A
                INC HL
                INC D
                edup
                LD A, (HL)
                LD (DE), A
                INC HL
                CALL PixelAttribute
                LD A, (HL)
                LD (DE), A
                RET
DrawCharTwo:    PUSH BC
                LD B, D
                RES 7, B
                LD C, E
                dup  7
                LD A, (HL)
                LD (DE), A
                LD (BC), A
                INC HL
                INC D
                INC B
                edup
                LD A, (HL)
                LD (DE), A
                LD (BC), A
                INC HL
                CALL PixelAttribute
                LD A, (HL)
                LD (DE), A
                RES 7, D
                LD (DE), A
                SET 7, D
                POP BC
                RET

                display " - Draw Char : \t\t", /A, DrawCharOne, " = busy [ ", /D, $ - DrawCharOne, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_CHARBOUNDARY_DRAW_CHAR_BOUNDARY_
