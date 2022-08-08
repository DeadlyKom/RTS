
                ifndef _CORE_MODULE_FILE_SYSTEM_LOAD_LEVEL_POST_
                define _CORE_MODULE_FILE_SYSTEM_LOAD_LEVEL_POST_
; -----------------------------------------
; инициализация после загрузки
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
PostInitialize: ; перенос свойств тайлов (свойства всегда находятся после карты)
.Surface        EQU $+1
                LD HL, #0000
                LD DE, Adr.Tilemap.Surface
                LD BC, Size.Tilemap.Surface
                CALL FastLDIR

                RET          

                display " - Load Level Post : \t\t", /A, PostInitialize, " = busy [ ", /D, $ - PostInitialize, " bytes  ]"

                endif ; ~ _CORE_MODULE_FILE_SYSTEM_LOAD_LEVEL_POST_
