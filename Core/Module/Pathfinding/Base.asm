
                ifndef _CORE_MODULE_PATHFINDING_BASE_
                define _CORE_MODULE_PATHFINDING_BASE_
Begin:          CheckGameplayFlag PATHFINDING_REQUEST_PLAYER_FLAG
                ; JR Z, Player.Request
                JP Z, AStar.SearchPath
                RET

                endif ; ~ _CORE_MODULE_PATHFINDING_BASE_