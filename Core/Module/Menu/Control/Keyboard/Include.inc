
                ifndef _CORE_MODULE_MENU_OPTIONS_CONTROL_KEYBOARD_INCLUDE_
                define _CORE_MODULE_MENU_OPTIONS_CONTROL_KEYBOARD_INCLUDE_

                module Keyboard
OPTION_BACK         EQU 0x00
OPTION_MENU_PAUSE   EQU 0x01
OPTION_SPEED_SCROLL EQU 0x02
OPTION_DESELECT     EQU 0x03
OPTION_SELECT       EQU 0x04
OPTION_RIGHT        EQU 0x05
OPTION_LEFT         EQU 0x06
OPTION_DOWN         EQU 0x07
OPTION_UP           EQU 0x08

OPTION_KEY_NUM      EQU 0x08
WAIT_INPUT_KEY      EQU VK_NONE + 1

                include "Options.asm"
                include "Select.asm"
                include "Suboptions.asm"

                endmodule

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_CONTROL_KEYBOARD_INCLUDE_
