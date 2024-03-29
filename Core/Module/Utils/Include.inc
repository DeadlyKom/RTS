
                ifndef _CORE_MODULE_UTILS_INCLUDE_
                define _CORE_MODULE_UTILS_INCLUDE_

                module Utils

                include "DeltaBetweenLocationAndTarget.asm"     ; remove ?

                ; RNG
                include "RNG/Rand8.asm"
                
                ; units
                include "Unit/Include.inc"

                ; convert
                include "Tilemap/Include.inc"

                ; waypoint
                include "Waypoint/Waypoint.asm"
                include "Waypoint/WaypointsSequencer.asm"

                ; chunk array
                include "ChunkArray/Include.inc"

                ;
                ; include "Projectile/Include.inc"

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_INCLUDE_
