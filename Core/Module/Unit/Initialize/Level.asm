
                ifndef _CORE_MODULE_UNIT_INITIALIZE_LEVEL_
                define _CORE_MODULE_UNIT_INITIALIZE_LEVEL_
; -----------------------------------------
; инициализация юнитов из блока метаданных карты о юнитов
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
LevelUnits:     ; инициализация
                LD HL, SharedBuffer
                LD C, (HL)                                                      ; количество структур FLevelUnitInfo в массиве
                INC L

.UnitInfoLoop   ; -----------------------------------------
                ; чтение структуры FLevelUnitInfo
                ; -----------------------------------------
                LD A, (HL)                                                      ; FLevelUnitInfo.Faction
                INC HL
                LD B, (HL)                                                      ; FLevelUnitInfo.Number
                INC L

.UnitDataLoop   PUSH AF
                PUSH BC

                ; FLevelUnitData.Flags
                BIT LUDF_SL_BIT, (HL)                                           ; проверка флаг шаттла
                JR NZ, .Shattle
                BIT LUDF_PL_BIT, (HL)                                           ; флаг расположения юнита:
                                                                                ; 0 - находится на карте, Location  позиция на карте
                                                                                ; 1 - спавнится через спавнер, Location позиция спавнера
                JR NZ, .SpawnUnit

                ; -----------------------------------------
                ; юнит расположен на карте
                ; -----------------------------------------
                CALL .ReadStruct                                                ; чтение данных структуры
                PUSH HL
                ; HL - информация о Way Points  (L - FUnit.Data,    H - FUnit.Idx)
                ; DE - позиция юнита            (D - y,             E - x)
                ; BC - параметры                (B - ранг,          C - тип юнита)
                CALL Spawn

.NextData       POP HL
                ; -----------------------------------------
                ; переход к следующему юниту
                ; -----------------------------------------
                POP BC
                POP AF
                DJNZ .UnitDataLoop

                ; -----------------------------------------
                ; переход к следующему пакету данных юнита
                ; -----------------------------------------
                DEC C
                JR NZ, .UnitInfoLoop

                RET

.Shattle        ; -----------------------------------------
                ; инициализация шаттла
                ; -----------------------------------------
                CALL .ReadStruct                                                ; чтение данных структуры
                PUSH HL
                PUSH DE

                ; определение стартовой локации          
                PUSH HL
                BIT FACTION_TYPE_BIT, C                                         ; тип фракции (0 - нейтральная, 1 - враждебная)
                LD HL, GameVar.StartSlotC
                JR NZ, .ReadLocation
                LD HL, GameFlags.Gameplay
                BIT GAMEPLAY_BIT, (HL)                                          ; флаг базового старта миссии
                                                                                ; 0 - нормальный старт со слота StartSlotA
                                                                                ; 1 - режим защиты старт со слота StartSlotB
                LD HL, GameVar.StartSlotA
                JR Z, .ReadLocation
                LD HL, GameVar.StartSlotB
.ReadLocation   LD E, (HL)
                INC HL
                LD D, (HL)
                POP HL
                PUSH DE

                ; HL - информация о Way Points  (L - FUnit.Data,    H - FUnit.Idx)
                ; DE - позиция юнита            (D - y,             E - x)
                ; BC - параметры                (B - ранг,          C - тип юнита)
                CALL Spawn

                POP DE
                POP HL

                ; HL - начальная позици     (H - y, L - x)
                ; DE - конечная позиция     (D - y, E - x)
                ; IX - адрес юнита
                CALL FlyTo
                JR .NextData

.SpawnUnit      ; -----------------------------------------
                ; инициализация спавна юнита
                ; -----------------------------------------
                PUSH HL
                JR .NextData

.ReadStruct     ; -----------------------------------------
                ; чтение структуры FLevelUnitData
                ; -----------------------------------------
                INC L
                OR (HL)                                                         ; FLevelUnitData.Type
                LD C, A
                INC L
                LD E, (HL)                                                      ; FLevelUnitData.Location.X
                INC L
                LD D, (HL)                                                      ; FLevelUnitData.Location.Y
                INC L
                LD B, (HL)                                                      ; FLevelUnitData.Rank
                INC L
                LD A, (HL)                                                      ; FLevelUnitData.WayPointIdx
                INC L
                
                RET

                display " - Initialize Level Units : \t\t\t\t", /A, Core, " = busy [ ", /D, $ - Core, " bytes  ]"

                endif ; ~ _CORE_MODULE_UNIT_INITIALIZE_LEVEL_
