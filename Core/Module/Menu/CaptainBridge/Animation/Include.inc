
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_ANIMATION_INCLUDE_
                define _CORE_MODULE_CAPTAIN_BRIDGE_ANIMATION_INCLUDE_

                module Animation

                display " - Animation : \t\t", /A, Begin, " = busy [ ", /D, Size, " bytes  ]"
Begin:          EQU $
                include "Core/Include.inc"
                include "LeftFrame/Include.inc"
; Flags:          DB #00
Size:           EQU $-Begin

                endmodule

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_ANIMATION_INCLUDE_
