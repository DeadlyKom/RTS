
                ifndef _CORE_MODULE_PATHFINDING_ASTAR_GET_TILE_INFO_
                define _CORE_MODULE_PATHFINDING_ASTAR_GET_TILE_INFO_

; -----------------------------------------
; get pointer to FPFInfo structure in the buffer
; In:
;   DE - tile position (D - y, E - x)
; Out:
;   A  - low pointer to FPFInfo structure in buffer
; Corrupt:
;   HL, AF
; Note:
; -----------------------------------------
GetTileInfo:    ;
.BufferStart    EQU $+1
                LD HL, #0000               

                ; X = (Coord.x - BufferStart.x) & 0x0F
                LD A, E
                SUB L
                LD L, A

                ; Y = (Coord.y - BufferStart.y) & 0x0F
                LD A, D
                SUB H

                ; HL = #4000 | Y << 4 | X
                ;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
                ;   | 15 | 14 | 13 | 12 | 11 | 10 |  9 |  8 |   |  7 |  6 |  5 |  4 |  3 |  2 |  1 |  0 |
                ;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
                ;   |  0 |  1 |  0 |  0 |  0 |  0 |  0 |  0 |   |  Y |  Y |  Y |  Y |  X |  X |  X |  X |
                ;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+

                ; Y << 4
                ADD A, A
                ADD A, A
                ADD A, A
                ADD A, A

                ; Y << 4 | X
                ADD A, L

                ; HL = #4000 | Y << 4 | X
                ; LD L, A
                ; LD H, HIGH PathfindingBuffer

                RET

                endif ; ~ _CORE_MODULE_PATHFINDING_ASTAR_GET_TILE_INFO_
