
                ifndef _CORE_MODULE_FILE_SYSTEM_CORE_INCLUDE_
                define _CORE_MODULE_FILE_SYSTEM_CORE_INCLUDE_

                module Base
Begin:          EQU $
                include "Read.asm"
                include "FindFile.asm"

                display " - Base : \t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_FILE_SYSTEM_CORE_INCLUDE_
