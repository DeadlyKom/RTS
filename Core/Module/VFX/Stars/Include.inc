
                ifndef _CORE_MODULE_MENU_MAIN_SCREENSAVER_STARS_INCLUDE_
                define _CORE_MODULE_MENU_MAIN_SCREENSAVER_STARS_INCLUDE_

                module Stars
StarsMax        EQU 64
Begin:          EQU $
                include "Struct.inc"
                
                include "Add.asm"
                include "Update.asm"
                include "Tick.asm"
                include "Initialize.asm"

@StarFlags      DB #00
@StarCounter:   DB #00
@StarsArray:    DS 128 * 5, 0

                display " - Stars : \t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_MENU_MAIN_SCREENSAVER_STARS_INCLUDE_
