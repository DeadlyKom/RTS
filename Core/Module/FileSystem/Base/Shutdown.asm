
                ifndef _CORE_MODULE_FILE_SYSTEM_BASE_SHUTDOWN_
                define _CORE_MODULE_FILE_SYSTEM_BASE_SHUTDOWN_      
; -----------------------------------------
; завершение работы с TR-DOS
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Shutdown:
.TR_DOS         DI
                IM 2
                EI
.ContainerIY    EQU $+2
                LD IY, #0000
                RET

                display " - Shutdown : \t\t\t", /A, Shutdown, " = busy [ ", /D, $ - Shutdown, " bytes  ]"

                endif ; ~ _CORE_MODULE_FILE_SYSTEM_BASE_SHUTDOWN_
