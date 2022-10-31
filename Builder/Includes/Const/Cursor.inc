
                ifndef _CONST_CURSOR_
                define _CONST_CURSOR_
MIN_CURSOR_SPEED EQU 3                                                          ; минимальная дефолтная скорость курсора
MAX_CURSOR_SPEED EQU 24                                                         ; максимальная дефолтная скорость курсора

CURSOR_FLAG
.LEFT_EDGE      EQU 0x80
.RIGHT_EDGE     EQU 0x40
.UP_EDGE        EQU 0x20
.DOWN_EDGE      EQU 0x10
.ALL_EDGES      EQU CURSOR_FLAG.LEFT_EDGE | CURSOR_FLAG.RIGHT_EDGE | CURSOR_FLAG.UP_EDGE | CURSOR_FLAG.DOWN_EDGE
.ACCELERATE     EQU 0x01

                endif ; ~_CONST_CURSOR_
