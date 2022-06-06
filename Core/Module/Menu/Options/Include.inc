
                ifndef _CORE_MODULE_MENU_OPTIONS_INCLUDE_
                define _CORE_MODULE_MENU_OPTIONS_INCLUDE_

                module Options
OPTIONS_LANGUAGE        EQU 0x04
OPTIONS_CONTROL         EQU 0x03
OPTIONS_GAME_SPEED      EQU 0x02
OPTIONS_CURSOR_SPEED    EQU 0x01
OPTIONS_BACK            EQU 0x00

                include "Options.asm"
                include "Select.asm"
                include "Suboptions.asm"
                include "Language/Change.asm"
                include "GameSpeed/Change.asm"
                include "CursorSpeed/Change.asm"
                ; include "../Control/include.inc"

                endmodule

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_INCLUDE_
