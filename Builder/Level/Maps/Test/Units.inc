
                ifndef _TILEMAP_TEST_UNITS_
                define _TILEMAP_TEST_UNITS_

Metadata:
.Units          EQU $

                DB .UnitsSize                                                   ; размер блока метаданных карты о юнитов
                DB 0x03                                                         ; количество структур FLevelUnitInfo в массиве
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

                ; -----------------------------------------
                ; юниты игрока
                ; -----------------------------------------
                FLevelUnitInfo {
                PLAYER_FACTION,                                                 ; принадлежность к фракции
                16                                                              ; количество
                }
                FLevelUnitData {
                LVL_NONE_FLAGS,                                                 ; флаги
                UNIT_INFANTRY,                                                  ; тип юнита
                { #05, #06 },                                                   ; начальная позиция шаттла, конечная позиция берётся из FLevelInfo.StartFaction
                RANK_ROOKIE                                                     ; ранг
                }
                FLevelUnitData {
                LVL_NONE_FLAGS,                                                 ; флаги
                UNIT_INFANTRY,                                                  ; тип юнита
                { #03, #07 },                                                   ; начальная позиция шаттла, конечная позиция берётся из FLevelInfo.StartFaction
                RANK_ROOKIE                                                     ; ранг
                }
                FLevelUnitData {
                LVL_NONE_FLAGS,                                                 ; флаги
                UNIT_INFANTRY,                                                  ; тип юнита
                { #06, #08 },                                                   ; начальная позиция шаттла, конечная позиция берётся из FLevelInfo.StartFaction
                RANK_ROOKIE                                                     ; ранг
                }
                FLevelUnitData {
                LVL_NONE_FLAGS,                                                 ; флаги
                UNIT_INFANTRY,                                                  ; тип юнита
                { #01, #02 },                                                   ; начальная позиция шаттла, конечная позиция берётся из FLevelInfo.StartFaction
                RANK_ROOKIE                                                     ; ранг
                }
                FLevelUnitData {
                LVL_NONE_FLAGS,                                                 ; флаги
                UNIT_INFANTRY,                                                  ; тип юнита
                { #07, #09 },                                                   ; начальная позиция шаттла, конечная позиция берётся из FLevelInfo.StartFaction
                RANK_ROOKIE                                                     ; ранг
                }
                FLevelUnitData {
                LVL_NONE_FLAGS,                                                 ; флаги
                UNIT_INFANTRY,                                                  ; тип юнита
                { #0A, #09 },                                                   ; начальная позиция шаттла, конечная позиция берётся из FLevelInfo.StartFaction
                RANK_ROOKIE                                                     ; ранг
                }
                FLevelUnitData {
                LVL_NONE_FLAGS,                                                 ; флаги
                UNIT_INFANTRY,                                                  ; тип юнита
                { #07, #0A },                                                   ; начальная позиция шаттла, конечная позиция берётся из FLevelInfo.StartFaction
                RANK_ROOKIE                                                     ; ранг
                }
                FLevelUnitData {
                LVL_NONE_FLAGS,                                                 ; флаги
                UNIT_INFANTRY,                                                  ; тип юнита
                { #09, #0A },                                                   ; начальная позиция шаттла, конечная позиция берётся из FLevelInfo.StartFaction
                RANK_ROOKIE                                                     ; ранг
                }
                FLevelUnitData {
                LVL_NONE_FLAGS,                                                 ; флаги
                UNIT_INFANTRY,                                                  ; тип юнита
                { #01, #01 },                                                   ; начальная позиция шаттла, конечная позиция берётся из FLevelInfo.StartFaction
                RANK_ROOKIE                                                     ; ранг
                }
                FLevelUnitData {
                LVL_NONE_FLAGS,                                                 ; флаги
                UNIT_INFANTRY,                                                  ; тип юнита
                { #05, #03 },                                                   ; начальная позиция шаттла, конечная позиция берётся из FLevelInfo.StartFaction
                RANK_ROOKIE                                                     ; ранг
                }
                FLevelUnitData {
                LVL_NONE_FLAGS,                                                 ; флаги
                UNIT_INFANTRY,                                                  ; тип юнита
                { #09, #02 },                                                   ; начальная позиция шаттла, конечная позиция берётся из FLevelInfo.StartFaction
                RANK_ROOKIE                                                     ; ранг
                }
                FLevelUnitData {
                LVL_NONE_FLAGS,                                                 ; флаги
                UNIT_INFANTRY,                                                  ; тип юнита
                { #08, #01 },                                                   ; начальная позиция шаттла, конечная позиция берётся из FLevelInfo.StartFaction
                RANK_ROOKIE                                                     ; ранг
                }
                FLevelUnitData {
                LVL_NONE_FLAGS,                                                 ; флаги
                UNIT_INFANTRY,                                                  ; тип юнита
                { #01, #0B },                                                   ; начальная позиция шаттла, конечная позиция берётся из FLevelInfo.StartFaction
                RANK_ROOKIE                                                     ; ранг
                }
                FLevelUnitData {
                LVL_NONE_FLAGS,                                                 ; флаги
                UNIT_INFANTRY,                                                  ; тип юнита
                { #0E, #0B },                                                   ; начальная позиция шаттла, конечная позиция берётся из FLevelInfo.StartFaction
                RANK_ROOKIE                                                     ; ранг
                }
                FLevelUnitData {
                LVL_NONE_FLAGS,                                                 ; флаги
                UNIT_INFANTRY,                                                  ; тип юнита
                { #0E, #03 },                                                   ; начальная позиция шаттла, конечная позиция берётся из FLevelInfo.StartFaction
                RANK_ROOKIE                                                     ; ранг
                }
                FLevelUnitData {
                LVL_NONE_FLAGS,                                                 ; флаги
                UNIT_INFANTRY,                                                  ; тип юнита
                { #01, #04 },                                                   ; начальная позиция шаттла, конечная позиция берётся из FLevelInfo.StartFaction
                RANK_ROOKIE                                                     ; ранг
                }

.UnitsSize      EQU $ - Metadata.Units - 1

                assert Metadata.UnitsSize <= 0x0100, "overflow SharedBuffer"

                endif ; ~_TILEMAP_TEST_UNITS_
