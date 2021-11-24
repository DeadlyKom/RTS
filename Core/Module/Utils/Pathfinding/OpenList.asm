
                ifndef _CORE_MODULE_UTILS_PATHFINDING_OPEN_LIST_
                define _CORE_MODULE_UTILS_PATHFINDING_OPEN_LIST_

                module OpenList
; -----------------------------------------
; add coordinate value to array of open list
; In:
;   DE - tile position (D - y, E - x)
; Out:
;   A  - index of the added element
; Corrupt:
; Note:
; -----------------------------------------
AddElement:     EXX
.Index          EQU $+1
                LD HL, PathfindingOpenListBuffer
                LD (HL), E
                INC H
                LD (HL), D
                LD A, L
                LD HL, AddElement.Index
                INC (HL)
                EXX

                RET

GetElement:     LD L, A
                LD H, HIGH PathfindingOpenListBuffer
                LD E, (HL)
                INC H
                LD D, (HL)

                RET

SetElement:     LD L, A
                LD H, HIGH PathfindingOpenListBuffer
                LD (HL), E
                INC H
                LD (HL), D

                RET

ResetOpenList:  XOR A
                LD (AddElement.Index), A
                RET

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_PATHFINDING_OPEN_LIST_
