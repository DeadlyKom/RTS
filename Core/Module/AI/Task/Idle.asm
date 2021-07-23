
                ifndef _CORE_MODULE_AI_TASK_IDLE_
                define _CORE_MODULE_AI_TASK_IDLE_

; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
Idle:           INC IXH                                                         ; FUnitLocation     (2)

                LD HL, Utils.Tilemap.Radius_3
                CALL Utils.Tilemap.Reconnaissance

                DEC IXH                                                         ; FUnitState        (1)
                OR A
                RET

                endif ; ~_CORE_MODULE_AI_TASK_IDLE_
