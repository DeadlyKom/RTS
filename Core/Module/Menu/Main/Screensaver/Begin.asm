
                ifndef _CORE_MODULE_MENU_MAIN_SCREENSAVER_BEGIN_
                define _CORE_MODULE_MENU_MAIN_SCREENSAVER_BEGIN_

Begin:          ; подготовка экрана 1
                SET_SCREEN_BASE
                CLS_C000
                ATTR_C000_IPB RED, BLACK, 1

                ;
                CALL Stars.Initialize
                SHOW_BASE_SCREEN

                SetUserHendler Stars.Tick
                
                JR$

                RET

                endif ; ~ _CORE_MODULE_MENU_MAIN_SCREENSAVER_BEGIN_
