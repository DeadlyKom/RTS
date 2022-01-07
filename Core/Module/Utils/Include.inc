
                ifndef _CORE_MODULE_UTILS_INCLUDE_
                define _CORE_MODULE_UTILS_INCLUDE_

                module Utils

                include "DeltaBetweenLocationAndTarget.asm"     ; remove ?
                
                ; units
                include "Unit/Reconnaissance.asm"
                include "Unit/TurnDown.asm"
                include "Unit/GetScreenAABB.asm"
                include "Unit/GetAddressInTable.asm"
                include "Unit/CalculateUnitAddress.asm"
                include "Unit/CalculateIndexUnitByAddress.asm"

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

                ; RNG
                include "RNG/Rand8.asm"

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_INCLUDE_