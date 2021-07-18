
                ifndef _CORE_MODULE_UTILS_WAY_POINT_
                define _CORE_MODULE_UTILS_WAY_POINT_

                module WayPoint
; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
Add:            RET
; -----------------------------------------
; set waypoint at specified index
; In:
;   A  - insert index
;   DE - waypoint location (tile center) (D - y, E - x)
;   IX - pointer to FUnitState (1)
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
Set:            ; INC IXH                                     ; FUnitLocation   (2)
                ; INC IXH                                     ; FUnitTargets    (3)
                ; RES FUTF_INDEX, (IX + FUnitTargets.Flags)
                ; LD (IX + FUnitTargets.Location.IDX_X), A
                ; DEC IXH                                     ; FUnitLocation   (2)
                ; DEC IXH                                     ; FUnitState  (1)
                ; LD L, A
                ; LD A, (HighWayPointArrayRef)
                ; LD H, A
                ; LD (HL), E
                ; INC H
                ; LD (HL), D

                RET
; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
Remove:         RET

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_WAY_POINT_