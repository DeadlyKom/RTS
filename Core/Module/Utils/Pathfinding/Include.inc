
                ifndef _CORE_MODULE_UTILS_PATHFINDING_INCLUDE_
                define _CORE_MODULE_UTILS_PATHFINDING_INCLUDE_

                ; new pathfinding
                module Pathfinding
                
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

                endif ; ~ _CORE_MODULE_UTILS_PATHFINDING_INCLUDE_
