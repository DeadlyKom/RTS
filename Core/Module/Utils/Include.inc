
                ifndef _CORE_MODULE_UTILS_INCLUDE_
                define _CORE_MODULE_UTILS_INCLUDE_

                module Utils

                include "DeltaBetweenLocationAndTarget.asm"     ; remove ?
                include "GetPositionSelectedUnits.asm"
                
                ; units
                include "Unit/Reconnaissance.asm"
                include "Unit/TurnDown.asm"
                include "Unit/GetScreenAABB.asm"

                ; convert
                include "Convert/ToTilemap.asm"
                include "Convert/Tilemap.asm"

                ; waypoint
                include "Waypoint/Waypoint.asm"
                include "Waypoint/WaypointsSequencer.asm"

                ; surface
                include "Surface/SurfaceProperty.asm"

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_INCLUDE_