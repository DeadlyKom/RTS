
                ifndef _CORE_MODULE_FILE_SYSTEM_LOAD_LEVEL_DATA_
                define _CORE_MODULE_FILE_SYSTEM_LOAD_LEVEL_DATA_
; -----------------------------------------
; загрузка данных уровня
; In:
;   HL - адрес структуры FLevelInfo (указанного уровня)
;   DE - адрес стркутуры FFileArea
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Data:           ; копирование данных из FLevelInfo.Map в первую структуру FFileArea
                LD BC, TRDOS.FILE_LENGTH
                LDIR

                ; переход к следующемей структуре FFileArea
                LD BC, FFileArea - TRDOS.FILE_LENGTH
                EX DE, HL
                ADD HL, BC
                EX DE, HL

                ; копирование данных из FLevelInfo.TilemapSpr в первую структуру FFileArea
                LD BC, TRDOS.FILE_LENGTH
                LDIR

                RET

                display " - Load Level Data : \t\t", /A, Data, " = busy [ ", /D, $ - Data, " bytes  ]"

                endif ; ~ _CORE_MODULE_FILE_SYSTEM_LOAD_LEVEL_DATA_