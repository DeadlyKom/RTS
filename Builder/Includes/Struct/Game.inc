
                ifndef _STRUCT_GAME_
                define _STRUCT_GAME_

                struct FGame
Size:           FMapSize 0, 0                                                   ; размер карты
SizeNEG:        FMapSize 0, 0                                                   ; размер карты (отрицательные значения)
Offset:         FLocation 0, 0                                                  ; смещения тайловой карты
CachedAddress:  DW #0000                                                        ; кешированное значение адрес тайловой карты
Countdown:      DB DURATION_TILE_ANIM                                           ; обратный счётчик продолжительности (DURATION_TILE_ANIM)

; ИИ
UnitArraySize:  DB #00                                                          ; размер массива юнитов
AI_UpdateRate:  DB #00                                                          ; частота обновления ИИ

; флаги
Render          FFlags 0                                                        ; флаги отрисовки

                ends

                endif ; ~_STRUCT_GAME_
