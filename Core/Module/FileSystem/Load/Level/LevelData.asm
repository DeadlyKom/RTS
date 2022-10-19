
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
                LD (GameVar.TilemapSize), BC

                ; -----------------------------------------
                ; расчёт адрес расположения стартовой локации FLevelInfo.StartSlotA
                ; -----------------------------------------
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                LD (GameVar.StartSlotA), DE

                ; -----------------------------------------
                ; расчёт адрес расположения стартовой локации FLevelInfo.StartSlotB
                ; -----------------------------------------
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                LD (GameVar.StartSlotB), DE

                ; -----------------------------------------
                ; расчёт адрес расположения стартовой локации FLevelInfo.StartSlotC
                ; -----------------------------------------
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                LD (GameVar.StartSlotC), DE

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

                ; определение стартовой локации
                START_PLAYER                                                    ; определение стартовой локации игрока

                ; центрирование по горизонтали
                LD A, E
                SUB SCREEN_TILE_X >> 1
                JR NC, $+3
                XOR A
                LD L, A

                ; центрирование по вертикали
                LD A, D
                SUB SCREEN_TILE_Y >> 1
                JR NC, $+3
                XOR A
                LD H, A
                
                LD (GameVar.TilemapOffset), HL

                RET

                display " - Load Level Data : \t\t\t\t\t", /A, Data, " = busy [ ", /D, $ - Data, " bytes  ]"

                endif ; ~ _CORE_MODULE_FILE_SYSTEM_LOAD_LEVEL_DATA_
