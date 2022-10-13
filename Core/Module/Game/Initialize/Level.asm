
                ifndef _MODULE_GAME_INITIALIZE_LEVEL_
                define _MODULE_GAME_INITIALIZE_LEVEL_
; -----------------------------------------
; инициализация уровня
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Level:          ; -----------------------------------------
                ; инициализация структуры FGame
                ; -----------------------------------------
                LD HL, GameVar.TilemapCountdown
                LD (HL), DURATION_TILE_ANIM                                     
                INC L                                                           ; GameVar.FlyingCountdown 
                LD (HL), DURATION_FLY_ANIM                                      
                INC L                                                           ; GameAI.UnitArraySize
                LD (HL), #00                                                    ; обновление массива юнитов
                INC L                                                           ; GameAI.AI_UpdateRate
                LD (HL), #04                                                    ; обновление массива юнитов

                ; -----------------------------------------
                ; инициализация
                ; -----------------------------------------
                CALL Functions.InitializeUnit                                   ; инициализация ядра работы с юнитами

                LD DE, #0608
                LD BC, UNIT_COMBAT_SHUTTLE | PLAYER_FACTION
                CALL Functions.SpawnUnit

                ;   HL - начальная позици (H - y, L - x)
                ;   DE - конечная позиция (D - y, E - x)
                LD HL, #FAF0
                LD DE, #0A0A
                CALL Functions.FlyToUnit

                LD DE, #0608
                LD BC, UNIT_COMBAT_SHUTTLE | PLAYER_FACTION
                CALL Functions.SpawnUnit

                ;   HL - начальная позици (H - y, L - x)
                ;   DE - конечная позиция (D - y, E - x)
                LD HL, #0608
                LD DE, #0A0A
                CALL Functions.FlyToUnit
                
                LD DE, #0A08
                LD BC, UNIT_COMBAT_SHUTTLE | PLAYER_FACTION
                CALL Functions.SpawnUnit

                ;   HL - начальная позици (H - y, L - x)
                ;   DE - конечная позиция (D - y, E - x)
                LD HL, #0A08
                LD DE, #000A
                CALL Functions.FlyToUnit

                LD DE, #0103
                LD BC, UNIT_COMBAT_SHUTTLE | PLAYER_FACTION
                CALL Functions.SpawnUnit

                ;   HL - начальная позици (H - y, L - x)
                ;   DE - конечная позиция (D - y, E - x)
                LD HL, #0103
                LD DE, #0101
                CALL Functions.FlyToUnit
                
                RET

                endif ; ~_MODULE_GAME_INITIALIZE_LEVEL_
