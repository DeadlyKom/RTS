
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
Idle:           EX AF, AF'
                OR A
                EX AF, AF'
                RET

                endif ; ~_CORE_MODULE_AI_TASK_IDLE_
