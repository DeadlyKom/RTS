
                ifndef _TILEMAP_TEST_UNITS_
                define _TILEMAP_TEST_UNITS_

Metadata:
.Units          EQU $

                DB .UnitsSize                                                   ; размер блока метаданных карты о юнитов
                DB 0x02                                                         ; количество структур FLevelUnitInfo в массиве
                ; -----------------------------------------
                ; шаттл игрока
                ; -----------------------------------------
                FLevelUnitInfo {
                PLAYER_FACTION,                                                 ; принадлежность к фракции
                1                                                               ; количество
                }
                FLevelUnitData {
                LVL_SHATTLE,                                                    ; флаги
                UNIT_COMBAT_SHUTTLE,                                            ; тип юнита
                { #FA, #F0 },                                                   ; начальная позиция шаттла, конечная позиция берётся из FLevelInfo.StartFaction
                RANK_ROOKIE                                                     ; ранг
                }

                ; -----------------------------------------
                ; шаттл противника
                ; -----------------------------------------
                FLevelUnitInfo {
                ENEMY_FACTION_A,                                                ; принадлежность к фракции
                1                                                               ; количество
                }
                FLevelUnitData {
                LVL_SHATTLE,                                                    ; флаги
                UNIT_COMBAT_SHUTTLE,                                            ; тип юнита
                { #60, #60 },                                                   ; начальная позиция шаттла, конечная позиция берётся из FLevelInfo.StartFaction
                RANK_ROOKIE                                                     ; ранг
                }

.UnitsSize      EQU $ - Metadata.Units - 1

                assert Metadata.UnitsSize <= 0x0100, "overflow SharedBuffer"

                endif ; ~_TILEMAP_TEST_UNITS_
