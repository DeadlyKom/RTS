
                ifndef _CORE_MODULE_DRAW_ATTRIBUTE_DRAW_CHAR_
                define _CORE_MODULE_DRAW_ATTRIBUTE_DRAW_CHAR_

                module Attribute
DrawChar:       dup  7
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
                INC HL
                RET

                display " - Draw Char : \t\t", /A, DrawChar, " = busy [ ", /D, $ - DrawChar, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_ATTRIBUTE_DRAW_CHAR_
