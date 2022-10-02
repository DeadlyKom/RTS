
                ifndef _MODULE_GAME_INITIALIZE_LEVEL_
                define _MODULE_GAME_INITIALIZE_LEVEL_
; -----------------------------------------
; инициализация уровня
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Level:
                LD DE, #0608
                LD BC, UNIT_COMBAT_SHUTTLE | PLAYER_FACTION
                CALL Functions.SpawnUnit

                ;   HL - начальная позици (H - y, L - x)
                ;   DE - конечная позиция (D - y, E - x)
                ;   A' - номер юнита
                XOR A
                EX AF, AF'
                LD HL, #0310
                LD DE, #0704
                CALL Functions.FlyToUnit

                ; -----------------------------------------
                ; инициализация структуры FGame
                ; -----------------------------------------
                LD HL, GameVar.TilemapCountdown
                LD (HL), DURATION_TILE_ANIM                                     ; GameVar.TilemapCountdown
                INC L
                LD (HL), DURATION_FLY_ANIM                                      ; GameVar.FlyingCountdown
                
                RET

                endif ; ~_MODULE_GAME_INITIALIZE_LEVEL_
