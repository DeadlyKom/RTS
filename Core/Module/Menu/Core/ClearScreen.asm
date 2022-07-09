
                ifndef _CORE_MODULE_MENU_CLEAR_SCREEN_
                define _CORE_MODULE_MENU_CLEAR_SCREEN_
@CLS:           ; подготовка экрана 1
                SET_SCREEN_BASE
                CLS_C000
                ATTR_C000_IPB RED, BLACK, 1

                ; подготовка экрана 2
                SET_SCREEN_SHADOW
                CLS_C000
                ATTR_C000_IPB RED, BLACK, 0
                RET

                display " - Clear Screen : \t\t", /A, CLS, " = busy [ ", /D, $ - CLS, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_CLEAR_SCREEN_
