
                ifndef _CORE_MODULE_MENU_MAIN_SCREENSAVER_SKIP_
                define _CORE_MODULE_MENU_MAIN_SCREENSAVER_SKIP_

CheckSkip:      ; обработка ввода
                CALL Keyboard.GetPressedKey
                JR C, .PressedSelect

.Reset          LD HL, .CounterPressed
                LD (HL), #00
                RET

.CounterPressed EQU $+1
.PressedSelect  LD A, #00
                INC A
                LD (.CounterPressed), A
                CP 3 * 50
                RET C
                LD HL, Finish
                EX (SP), HL
                RET


                endif ; ~ _CORE_MODULE_MENU_MAIN_SCREENSAVER_SKIP_
