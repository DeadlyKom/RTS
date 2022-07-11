
                ifndef _CORE_MODULE_VFX_TEXT_PRINTED_RENDER_INCLUDE_
                define _CORE_MODULE_VFX_TEXT_PRINTED_RENDER_INCLUDE_

                module Text

                display " - Printed Text VFX : \t", /A, Begin, " = busy [ ", /D, Size, " bytes  ]"
Begin:          EQU $
                include "Render.asm"
                include "RenderTick.asm"
Size:           EQU $-Begin

                endmodule

                endif ; ~ _CORE_MODULE_VFX_TEXT_PRINTED_RENDER_INCLUDE_