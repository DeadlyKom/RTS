
                ifndef _CORE_MODULE_MENU_MAIN_SCREENSAVER_STARS_INITIALIZE_
                define _CORE_MODULE_MENU_MAIN_SCREENSAVER_STARS_INITIALIZE_
; -----------------------------------------
; инициализация звёзд
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Initialize:     ;
                XOR A
                LD (StarCounter), A

                LD A, #FF
                LD (StarFlags), A

                LD B, 50
.Loop           CALL Add
                DJNZ .Loop

                XOR A
                LD (StarFlags), A

                RET

                endif ; ~ _CORE_MODULE_MENU_MAIN_SCREENSAVER_STARS_INITIALIZE_
