
                ifndef _CORE_MODULE_MENU_OPTIONS_CONTROL_INCLUDE_
                define _CORE_MODULE_MENU_OPTIONS_CONTROL_INCLUDE_

                module Control
OPTIONS_KEMPSTON    EQU 0x03
OPTIONS_MOUSE       EQU 0x02
OPTIONS_KEYBOARD    EQU 0x01
OPTIONS_BACK        EQU 0x00

                include "Options.asm"
                include "Select.asm"
                include "Suboptions.asm"
                include "Kempston/Change.asm"
                include "Mouse/Change.asm"
                include "Keyboard/Include.inc"

                endmodule

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_CONTROL_INCLUDE_
