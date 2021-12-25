
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
; AddElement:     EXX

;                 ; move to next element
;                 LD HL, AddElement.Index
;                 INC (HL)

;                 ; set coordinate value to current index
; .Index          EQU $+1
;                 LD HL, PathfindingOpenListBuffer
;                 LD (HL), E
;                 INC H
;                 LD (HL), D
;                 LD A, L

;                 EXX

;                 RET

; PopLastElement: LD HL, Utils.Pathfinding.AddToOpenList.OpenListIndex
;                 LD A, (HL)
;                 DEC (HL)
;                 LD B, (HL)
; GetElement:     LD L, A
;                 LD H, HIGH PathfindingOpenListBuffer
;                 LD E, (HL)
;                 INC H
;                 LD D, (HL)

;                 RET

; SetElement:     LD L, A
; .SetL           LD H, HIGH PathfindingOpenListBuffer
;                 LD (HL), E
;                 INC H
;                 LD (HL), D

;                 RET  
; ResetOpenList:  LD A, #FF
;                 LD (AddElement.Index), A
;                 RET

; IsEmpty:        LD A, (AddToOpenList.OpenListIndex)
;                 CP #FF
;                 RET

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_PATHFINDING_OPEN_LIST_
