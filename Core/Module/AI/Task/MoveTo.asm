
                ifndef _CORE_MODULE_AI_TASK_MOVE_TO_
                define _CORE_MODULE_AI_TASK_MOVE_TO_

; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
MoveTo:         EX AF, AF'
                OR A
                EX AF, AF'
                RET

                endif ; ~_CORE_MODULE_AI_TASK_MOVE_TO_
