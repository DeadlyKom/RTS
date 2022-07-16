
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_INCLUDE_
                define _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_INCLUDE_

                module Dialog

                include "Const.inc"
                include "Dialog.inc"
                
                include "Core.asm"
                include "Initialize.asm"
                include "NextWord.asm"
                include "NextMessage.asm"
                include "Tick.asm"
                include "DrawChar.asm"
                include "DrawCallout.asm"
                include "DrawArrow.asm"
                include "Scroll.asm"
Variables:      FDialogVariable

                endmodule

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_INCLUDE_
