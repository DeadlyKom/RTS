
                ifndef _CONST_LEVEL_
                define _CONST_LEVEL_

LUDF_SL_BIT     EQU 0x02                                                        ; флаг шаттла
LUDF_WP_BIT     EQU 0x01                                                        ; флаг наличия в WayPointIdx валидного индекса последовательности Way Points
LUDF_PL_BIT     EQU 0x00                                                        ; флаг расположения юнита:
                                                                                ; 0 - находится на карте, Location  позиция на карте
                                                                                ; 1 - спавнится через спавнер, Location позиция спавнера
LVL_SHATTLE     EQU 1 << LUDF_SL_BIT
LVL_WAY_POINTS  EQU 1 << LUDF_WP_BIT
LVL_SPAWNER     EQU 1 << LUDF_PL_BIT
LVL_NONE_FLAGS  EQU 0x00

                endif ; ~_CONST_LEVEL_
