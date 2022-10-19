
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
                LD (HL), #04                                                    ; обновление массива юнитов (ToDo заменить на константное имя)

                ; -----------------------------------------
                ; инициализация
                ; -----------------------------------------
                CALL Functions.InitializeUnit                                   ; инициализация ядра работы с юнитами
                
                RET

                endif ; ~_MODULE_GAME_INITIALIZE_LEVEL_
