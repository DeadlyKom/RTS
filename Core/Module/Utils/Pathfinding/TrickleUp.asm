
                ifndef _CORE_MODULE_UTILS_PATHFINDING_TRICKLE_UP_
                define _CORE_MODULE_UTILS_PATHFINDING_TRICKLE_UP_

; -----------------------------------------
; 
; In:
;   A  - index of element
; Out:
; Corrupt:
; Note:
; -----------------------------------------
TrickleUp:      ; DE = OpenList[A]
                CALL OpenList.GetElement

                RET

                endif ; ~ _CORE_MODULE_UTILS_PATHFINDING_TRICKLE_UP_
