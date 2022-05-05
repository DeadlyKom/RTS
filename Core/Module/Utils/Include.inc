
                ifndef _CORE_MODULE_UTILS_INCLUDE_
                define _CORE_MODULE_UTILS_INCLUDE_

                module Utils

                include "DeltaBetweenLocationAndTarget.asm"     ; remove ?
                
                ; units
                include "Unit/Include.inc"

                ; RNG
                include "RNG/Rand8.asm"

                ; unit/visibility
                include "Unit/Visibility/GetListUnits.asm"
                include "Unit/Visibility/CheckRadius.asm"

                ; convert
                include "Convert/ToTilemap.asm"
                include "Convert/Tilemap.asm"

                ; waypoint
                include "Waypoint/Waypoint.asm"
                include "Waypoint/WaypointsSequencer.asm"

                ; surface
                include "Surface/SurfaceProperty.asm"

                ; chunk array
                include "ChunkArray/Include.inc"

                ;
                ; include "Projectile/Include.inc"

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_INCLUDE_