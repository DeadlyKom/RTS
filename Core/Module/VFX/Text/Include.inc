
                ifndef _CORE_MODULE_VFX_TEXT_RENDER_INCLUDE_
                define _CORE_MODULE_VFX_TEXT_RENDER_INCLUDE_

                module Text

                include "Const.inc"
                include "Variables.inc"
Begin:          EQU $
                include "Core.asm"
                include "Render.asm"
                include "RenderTick.asm"
Variables:      FTextVFX

                include "VFX.asm"

                display " - Text New Render VFX : \t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"
                endmodule

                endif ; ~ _CORE_MODULE_VFX_TEXT_RENDER_INCLUDE_