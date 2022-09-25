
                ifndef _MODULE_GAME_INITIALIZE_LEVEL_
                define _MODULE_GAME_INITIALIZE_LEVEL_
; -----------------------------------------
; инициализация уровня
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
InitializeLevel:
                LD DE, #0608
                LD BC, UNIT_COMBAT_SHUTTLE | PLAYER_FACTION
                CALL Functions.SpawnUnit

                RET

                endif ; ~_MODULE_GAME_INITIALIZE_LEVEL_
