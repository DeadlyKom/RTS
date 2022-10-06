
                ifndef _CORE_MODULE_FILE_SYSTEM_LOAD_LEVEL_POST_
                define _CORE_MODULE_FILE_SYSTEM_LOAD_LEVEL_POST_
; -----------------------------------------
; инициализация после загрузки
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
PostInitialize: ; -----------------------------------------
                ; перенос свойств тайлов (свойства всегда находятся после карты)
                ; -----------------------------------------
.Surface        EQU $+1
                LD HL, #0000
                LD DE, Adr.Tilemap.Surface
                LD BC, Size.Tilemap.Surface
                CALL Memcpy.FastLDIR

                ; -----------------------------------------
                ; расчёт адрес расположения стартовой локации
                ; -----------------------------------------
                LD DE, (GameVar.TilemapOffset)
                CALL Game.Tilemap.GetAdrTilemap
                LD (GameVar.TilemapCachedAdr), HL

                RET          

                display " - Load Level Post : \t\t\t\t\t", /A, PostInitialize, " = busy [ ", /D, $ - PostInitialize, " bytes  ]"

                endif ; ~ _CORE_MODULE_FILE_SYSTEM_LOAD_LEVEL_POST_
