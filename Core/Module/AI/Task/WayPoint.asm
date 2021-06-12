
                ifndef _CORE_MODULE_AI_TASK_WAY_POINT_
                define _CORE_MODULE_AI_TASK_WAY_POINT_

; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
WayPoint:       EX AF, AF'
                OR A
                EX AF, AF'
                RET

                endif ; ~_CORE_MODULE_AI_TASK_WAY_POINT_
