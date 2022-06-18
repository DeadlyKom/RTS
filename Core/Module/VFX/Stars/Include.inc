
                ifndef _CORE_MODULE_MENU_MAIN_SCREENSAVER_STARS_INCLUDE_
                define _CORE_MODULE_MENU_MAIN_SCREENSAVER_STARS_INCLUDE_

                module Stars
STAR_INIT_BIT   EQU 0x07
STAR_BIT        EQU 0x06
STAR_CLS_BIT    EQU 0x05
STAR_DESTROY_BIT EQU 0x04

STAR_INIT       EQU 1 << STAR_INIT_BIT
STAR            EQU 1 << STAR_BIT
STAR_CLS        EQU 1 << STAR_CLS_BIT
STAR_DESTROY    EQU 1 << STAR_DESTROY_BIT

StarsMax        EQU 128
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
