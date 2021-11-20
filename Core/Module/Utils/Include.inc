
                ifndef _CORE_MODULE_UTILS_INCLUDE_
                define _CORE_MODULE_UTILS_INCLUDE_

                module Utils

                include "AddNeighbors.asm"
                include "BuildPath.asm"                         ; remove ?
                include "ConvertMousePosition.asm"
                include "DeltaBetweenLocationAndTarget.asm"
                include "GetHeuristic.asm"                      ; remove ?
                include "GetPositionSelectedUnits.asm"
                include "Reconnaissance.asm"
                include "SurfaceProperty.asm"
                include "Tilemap.asm"
                include "TurnDown.asm"
                include "VectorField.asm"                       ; remove ?
                include "Waypoint.asm"
                include "WaypointsSequencer.asm"
                include "Queue.asm"

                ; new pathfinding
                include "Pathfinding/GetTileInfo.asm"
                include "Pathfinding/GetHeuristics.asm"
                include "Pathfinding/AddToOpenList.asm"

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_INCLUDE_