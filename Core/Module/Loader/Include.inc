
                ifndef _CORE_MODULE_LOADER_INCLUDE_
                define _CORE_MODULE_LOADER_INCLUDE_

                ; define BackgroundColor ZX_COLOR_IP WHITE, BLACK

                module Saver
Begin:          EQU $
                include "Saver.asm"

                display " - Saver : \t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                include "../Decompressor/Forward.asm"
                include "../Decompressor/Backward.asm"

                endmodule

                endif ; ~ _CORE_MODULE_LOADER_INCLUDE_
