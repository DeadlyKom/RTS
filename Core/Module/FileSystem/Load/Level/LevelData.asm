
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
Data:           ; -----------------------------------------
                ; копирование данных из FLevelInfo.Map в первую структуру FFileArea
                ; -----------------------------------------
                LD BC, TRDOS.FILE_LENGTH
                LDIR

                ; -----------------------------------------
                ; переход к следующемей структуре FFileArea
                ; -----------------------------------------
                LD BC, FFileArea - TRDOS.FILE_LENGTH
                EX DE, HL
                ADD HL, BC
                EX DE, HL

                ; -----------------------------------------
                ; копирование данных из FLevelInfo.TilemapSpr в первую структуру FFileArea
                ; -----------------------------------------
                LD BC, TRDOS.FILE_LENGTH
                LDIR

                ; -----------------------------------------
                ; копирование размера карты FLevelInfo.Size
                ; -----------------------------------------
                LD C, (HL)
                INC HL
                LD B, (HL)
                INC HL
                LD (PostInitialize.TilmapSize), BC

                ; -----------------------------------------
                ; расчёт адрес расположения стартовой локации FLevelInfo.StartFaction_A
                ; -----------------------------------------
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                LD (PostInitialize.StartLocation), DE

                PUSH HL                                                         ; сохранение

                ; -----------------------------------------
                ; генерация таблицы адресов по позиции тайла (не использовать умножение)
                ; -----------------------------------------
                LD HL, Adr.Tilemap.AdrTable
                LD DE, Adr.Tilemap.Map
                LD A, B
                LD B, #00

.Loop           LD (HL), E
                SET 7, L
                LD (HL), D
                RES 7, L
                INC L

                EX DE, HL
                ADD HL, BC
                EX DE, HL

                DEC A
                JR NZ, .Loop

                ; сохранение адреса границы карты (хранятся свойства тайлов)
                LD (PostInitialize.Surface), DE
  
                POP HL                                                          ; восстановление

                RET

                display " - Load Level Data : \t\t", /A, Data, " = busy [ ", /D, $ - Data, " bytes  ]"

                endif ; ~ _CORE_MODULE_FILE_SYSTEM_LOAD_LEVEL_DATA_
