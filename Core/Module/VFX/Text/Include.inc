
                ifndef _CORE_MODULE_VFX_TEXT_RENDER_INCLUDE_
                define _CORE_MODULE_VFX_TEXT_RENDER_INCLUDE_

                module Text

                include "Const.inc"
                include "Variables.inc"

                display " - Text Render VFX : \t\t\t", /A, Begin, " = busy [ ", /D, Size, " bytes  ]"
Begin:          EQU $
                include "Core.asm"
                include "Render.asm"
                include "RenderTick.asm"
@VariablesVFX:  FTVFX
Size:           EQU $-Begin

                include "VFX.asm"

                endmodule

                endif ; ~ _CORE_MODULE_VFX_TEXT_RENDER_INCLUDE_