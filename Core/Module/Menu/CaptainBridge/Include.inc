
                ifndef _CORE_MODULE_MENU_MAIN_CAPTAIN_BRIDGE_INCLUDE_
                define _CORE_MODULE_MENU_MAIN_CAPTAIN_BRIDGE_INCLUDE_

                module CapBridge

                include "Const.inc"

                include "ChangeMission.asm"
                include "ChoiceDialog.asm"
                include "Input.asm"
                include "Room/Include.inc"
                include "Animation/Include.inc"
                include "Dialog/Include.inc"
                include "Core/Module/FileSystem/Game/LoadAndLaunch.asm"         ; загрузчик игры

                ; include "Core/Module/VFX/Hologram/Include.inc"

Flags:          DB #00

                endmodule

                endif ; ~ _CORE_MODULE_MENU_MAIN_CAPTAIN_BRIDGE_INCLUDE_
