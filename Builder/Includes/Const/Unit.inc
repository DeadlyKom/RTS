
                ifndef _CONST_UNIT_
                define _CONST_UNIT_
PLAYER_SHUTTLE_IDX  EQU 0x00
ENEMY_SHUTTLE_IDX   EQU 0x01
PLAYER_SHUTTLE  EQU #C000 + UNIT_SIZE * PLAYER_SHUTTLE_IDX                      ; адрес шаттла игрока
ENEMY_SHUTTLE   EQU #C000 + UNIT_SIZE * ENEMY_SHUTTLE_IDX                       ; адрес шаттла противника

                endif ; ~_CONST_UNIT_
