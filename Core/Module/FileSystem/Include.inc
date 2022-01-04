
                ifndef _CORE_MODULE_FILE_SYSTEM_INCLUDE_
                define _CORE_MODULE_FILE_SYSTEM_INCLUDE_

                module FileSystem

                include "Load/Include.inc"
                include "Read.asm"
                include "FindFile.asm"
FileNameMap:    DS 9, 0
FileNameInfo:   BYTE "MapsInfoC"

                endmodule

                endif ; ~ _CORE_MODULE_FILE_SYSTEM_INCLUDE_