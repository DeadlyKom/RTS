
                ifndef _CORE_MODULE_UTILS_TILEMAP_INCLUDE_
                define _CORE_MODULE_UTILS_TILEMAP_INCLUDE_

                module Tilemap

                ; surface
                include "Surface/SurfaceProperty.asm"

                ; convert
                include "Convert/ToTilemap.asm"
                include "Convert/Tilemap.asm"

                ; visible
                include "Check/IsVisibleUnit.asm"

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_TILEMAP_INCLUDE_