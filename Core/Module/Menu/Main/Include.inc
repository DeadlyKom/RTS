
                ifndef _CORE_MODULE_MENU_MAIN_INCLUDE_
                define _CORE_MODULE_MENU_MAIN_INCLUDE_

MENU_NEW_GAME   EQU 0x02
MENU_CONTINUE   EQU 0x01
MENU_OPTIONS    EQU 0x00

                include "Main.asm"
                include "Select.asm"

                endif ; ~ _CORE_MODULE_MENU_MAIN_INCLUDE_
