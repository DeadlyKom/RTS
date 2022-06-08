
                ifndef _CORE_MODULE_MENU_OPTIONS_INCLUDE_
                define _CORE_MODULE_MENU_OPTIONS_INCLUDE_

                module Options
OPTION_LANGUAGE         EQU 0x04
OPTION_CONTROL          EQU 0x03
OPTION_GAME_SPEED       EQU 0x02
OPTION_CURSOR_SPEED     EQU 0x01
OPTION_BACK             EQU 0x00

                include "Options.asm"
                include "Select.asm"
                include "Suboptions.asm"
                include "Language/Change.asm"
                include "GameSpeed/Change.asm"
                include "CursorSpeed/Change.asm"
                include "Control/Change.asm"
                include "../Control/include.inc"

                endmodule

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_INCLUDE_
