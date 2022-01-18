
                ifndef _CORE_MODULE_UTILS_INCLUDE_
                define _CORE_MODULE_UTILS_INCLUDE_

                module Utils

                include "DeltaBetweenLocationAndTarget.asm"     ; remove ?
                
                 ; RNG
                include "RNG/Rand8.asm"

                ; units
                module Unit
                include "Unit/Reconnaissance.asm"
                include "Unit/TurnDown.asm"
                include "Unit/GetScreenAABB.asm"
                include "Unit/GetAddressInTable.asm"
                include "Unit/GetAddress.asm"
                include "Unit/GetIndex.asm"
                include "Unit/State/CheckState.asm"
                include "Unit/State/SetState.asm"
                endmodule

                ; unit/visibility
                include "Unit/Visibility/CheckRadius.asm"
                include "Unit/Visibility/GetListUnits.asm"

                ; convert
                include "Convert/ToTilemap.asm"
                include "Convert/Tilemap.asm"

                ; waypoint
                include "Waypoint/Waypoint.asm"
                include "Waypoint/WaypointsSequencer.asm"

                ; surface
                include "Surface/SurfaceProperty.asm"

                ; include "Projectile/Direction.asm"

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_INCLUDE_