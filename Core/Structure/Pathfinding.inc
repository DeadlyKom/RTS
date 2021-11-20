
                    ifndef _STRUCTURE_PATHFINDING_
                    define _STRUCTURE_PATHFINDING_

; pathfinding flags
PF_IN_OPEN_LIST_FLAG    EQU 0x01
PF_CLOSED_FLAG          EQU 0x02

                    struct FTileData
ParentCoord         FLocation
OpenListIdx         DB #00      ; index in open list
G_Cost              DB #00      ; distance from starting node
H_Cost              DB #00      ; distance from end node
F_Cost              DW #0000    ; G_Cost + H_Cost
Flags               DB #00      ; pathfinding flags

                    ends

                    endif ; ~_STRUCTURE_PATHFINDING_