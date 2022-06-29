
                ifndef _CORE_MODULE_LOADER_INCLUDE_
                define _CORE_MODULE_LOADER_INCLUDE_

                define ProgressX        16
                define ProgressY        179
                define LoadProgress     #C000 + (((ProgressY >> 3) & 0x18) << 8) + ((ProgressY & 0x07) << 8) + ((ProgressY & 0x38) << 2) + (ProgressX >> 3)
                define ProgressLength   64

                include "Saver.asm"
                include "Progress.asm"
                include "Core/Module/Math/Div/DivFix8x8.asm"
LoadingSprAttr  incbin "Sprites/Menu/Loader/Compressed/Loading.ar.spr"
ProgressSprAttr incbin "Sprites/Menu/Loader/Compressed/Progress.ar.spr"

                endif ; ~ _CORE_MODULE_LOADER_INCLUDE_
