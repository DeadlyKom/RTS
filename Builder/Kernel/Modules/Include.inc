
                ifndef _BUILDER_KERNEL_MODULES_INCLUDE_
                define _BUILDER_KERNEL_MODULES_INCLUDE_

                module Modules

                display " - Modules : \t\t\t\t", /A, Begin, " = busy [ ", /D, Size, " bytes  ]"
Begin:          EQU $
                include "Loader.asm"
Size:           EQU $ - Begin

                endmodule

                endif ; ~_BUILDER_KERNEL_MODULES_INCLUDE_
