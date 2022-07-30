
                ifndef _MODULE_GAME_INITIALIZE_
                define _MODULE_GAME_INITIALIZE_
; -----------------------------------------
; инициализация игры
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Initialize:     

                ; -----------------------------------------
                ; очистка экранов
                ; -----------------------------------------
                ; подготовка экрана 1
                CLS_4000
                ATTR_4000_IPB BLACK, WHITE, 0

                ; подготовка экрана 2
                SET_SCREEN_SHADOW
                CLS_C000
                ATTR_C000_IPB BLACK, WHITE, 0

                ; бордюр белого цвета
                BORDER WHITE
                ; -----------------------------------------


                RET

                endif ; ~_MODULE_GAME_INITIALIZE_
