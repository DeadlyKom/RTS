
                ifndef _CORE_MODULE_GAME_VARIABLES_
                define _CORE_MODULE_GAME_VARIABLES_

                module Tilemap
Size:           FMapSize 0, 0                                                   ; размер карты
SizeNEG:        FMapSize 0, 0                                                   ; размер карты (отрицательные значения)
Offset:         FLocation 0, 0                                                  ; смещения тайловой карты
CachedAddress:  DW #0000                                                        ; кешированное значение адрес тайловой карты 
                module Animation
Countdown:      DB DURATION_TILE_ANIM                                           ; обратный счётчик продолжительности (DURATION_TILE_ANIM)

                endmodule
                endmodule

                endif ; ~ _CORE_MODULE_GAME_VARIABLES_
