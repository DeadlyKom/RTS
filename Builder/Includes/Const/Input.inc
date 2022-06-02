
                    ifndef _CONST_INPUT_FLAGS_
                    define _CONST_INPUT_FLAGS_

DEFAULT_UP          EQU 0x00
DEFAULT_LEFT        EQU 0x01
DEFAULT_DOWN        EQU 0x02
DEFAULT_RIGHT       EQU 0x03
DEFAULT_SELECT      EQU 0x04

                    ; активное значение false
SELECTION_RECT_FLAG EQU 0x80                                                    ; режим выбора прямоугольником

                    endif ; ~_CONST_INPUT_FLAGS_
