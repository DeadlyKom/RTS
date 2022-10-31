
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
                ; ToDo сделать нормальную инициализацию
                LD HL, Tilemap.Countdown
                LD (HL), DURATION.TILE_ANIM                                     
                INC L                                                           ; Tilemap.FlyingCountdown 
                LD (HL), DURATION.FLY_ANIM                                      
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
