
                ifndef _CORE_MODULE_MENU_CORE_INCLUDE_
                define _CORE_MODULE_MENU_CORE_INCLUDE_

                include "Const.inc"
                include "Variables.inc"

                include "Core.asm"
                include "CoreSuboption.asm"
                include "Input.asm"
                include "Fadein.asm"
                include "Fadeout.asm"
                include "LoadText.asm"
                include "InterruptHandler.asm"
                include "../../VFX/Include.inc"

@MenuVariables: FMenu
@SelectCursor:  DB %00000000
                DB %00000000
                DB %01000000
                DB %00100000
                DB %01010000
                DB %01100000
                DB %01000000
                DB %00000000
                ZX_COLOR_IPB RED, BLACK, 1

                endif ; ~ _CORE_MODULE_MENU_CORE_INCLUDE_
