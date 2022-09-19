
                ifndef _MACRO_DEBUG_
                define _MACRO_DEBUG_
DEBUG_BREAK_POINT_C: macro
                ifdef _DEBUG
                JR C, $                                                         ; произошла ошибка
                endif
                endm

                endif ; ~_MACRO_DEBUG_
