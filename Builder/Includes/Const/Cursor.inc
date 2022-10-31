
                ifndef _CONST_CURSOR_
                define _CONST_CURSOR_
CURSOR
.MIN_SPEED      EQU 3                                                           ; минимальная дефолтная скорость курсора
.MAX_SPEED      EQU 24                                                          ; максимальная дефолтная скорость курсора
.LEFT_EDGE_BIT  EQU 0x07
.RIGHT_EDGE_BIT EQU 0x06
.UP_EDGE_BIT    EQU 0x05
.DOWN_EDGE_BIT  EQU 0x04
.ACCELERATE     EQU 0x01

                endif ; ~_CONST_CURSOR_
