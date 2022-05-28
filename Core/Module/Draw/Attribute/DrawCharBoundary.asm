
                ifndef _CORE_MODULE_DRAW_ATTRIBUTE_DRAW_CHAR_BOUNDARY_
                define _CORE_MODULE_DRAW_ATTRIBUTE_DRAW_CHAR_BOUNDARY_

                module Attribute
DrawCharBoundary: dup  7
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

                display " - Draw Char Boundary : \t", /A, DrawCharBoundary, " = busy [ ", /D, $ - DrawCharBoundary, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_ATTRIBUTE_DRAW_CHAR_BOUNDARY_
