
                ifndef _CORE_MODULE_FILE_SYSTEM_LOAD_LEVEL_POST_
                define _CORE_MODULE_FILE_SYSTEM_LOAD_LEVEL_POST_
; -----------------------------------------
; инициализация после загрузки
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
PostInitialize: ; инициализация
.Surface        EQU $+1
                LD HL, #0000
                LD BC, Size.Tilemap.Surface

                PUSH HL
                PUSH BC

                ; -----------------------------------------
                ; перенос блока метаданных карты о юнитов
                ; -----------------------------------------
                LD DE, SharedBuffer
                ADD HL, BC
                LD C, (HL)
                LD B, #00
                INC HL
                CALL Memcpy.FastLDIR                                            ; перенос блока метаданных карты о юнитов

                ; -----------------------------------------
                ; перенос свойств тайлов (свойства всегда находятся после карты)
                ; -----------------------------------------
                POP BC
                POP HL

                LD DE, Adr.Tilemap.Surface
                OR A
                SBC HL, DE
                EX AF, AF'
                ADD HL, DE
                EX AF, AF'
                CALL NZ, Memcpy.FastLDIR                                        ; перенос свойств, если необходимо

                ; -----------------------------------------
                ; расчёт адрес расположения стартовой локации
                ; -----------------------------------------
                LD DE, (GameVar.TilemapOffset)
                CALL Game.Tilemap.GetAdrTilemap
                LD (GameVar.TilemapCachedAdr), HL

                RET          

                display " - Load Level Post : \t\t\t\t\t", /A, PostInitialize, " = busy [ ", /D, $ - PostInitialize, " bytes  ]"

                endif ; ~ _CORE_MODULE_FILE_SYSTEM_LOAD_LEVEL_POST_
