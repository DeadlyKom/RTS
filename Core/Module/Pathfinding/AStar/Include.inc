
                ifndef _CORE_MODULE_PATHFINDING_ASTAR_INCLUDE_
                define _CORE_MODULE_PATHFINDING_ASTAR_INCLUDE_

                module AStar
                
                include "OpenList.asm"
                include "GetTileInfo.asm"
                include "GetHeuristics.asm"
                include "TrickleUp.asm"
                include "ExtractMin.asm"
                include "AddToOpenList.asm"
                include "Step.asm"
                include "GetFoundPath.asm"
                include "SearchPath.asm"

                endmodule

                endif ; ~ _CORE_MODULE_PATHFINDING_ASTAR_INCLUDE_
