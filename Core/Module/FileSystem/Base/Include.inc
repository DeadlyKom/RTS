
                ifndef _CORE_MODULE_FILE_SYSTEM_BASE_INCLUDE_
                define _CORE_MODULE_FILE_SYSTEM_BASE_INCLUDE_

                module Base
Begin:          EQU $
                include "Setup.asm"
                include "Shutdown.asm"
                include "Read.asm"
                include "FindFile.asm"
Variables:      FVariables                                                      ; переменные для работы с файлами

                display " - FVariables : \t\t\t", /A, Variables, " = busy [ ", /D, $ - Variables, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_FILE_SYSTEM_BASE_INCLUDE_
