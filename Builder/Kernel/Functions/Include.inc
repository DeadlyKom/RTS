
                ifndef _BUILDER_KERNEL_FUNCTIONS_INCLUDE_
                define _BUILDER_KERNEL_FUNCTIONS_INCLUDE_

                module Functions

                display " - Functions : \t\t", /A, Begin, " = busy [ ", /D, Size, " bytes  ]"
Begin:          EQU $
                include "LoadFont.asm"
                include "LoadLevel.asm"
                include "String.asm"
Size:           EQU $ - Begin

                endmodule

                endif ; ~_BUILDER_KERNEL_FUNCTIONS_INCLUDE_
