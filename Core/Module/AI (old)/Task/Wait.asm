
                ifndef _CORE_MODULE_AI_TASK_WAIT_
                define _CORE_MODULE_AI_TASK_WAIT_

; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
Wait:           OR A
                RET

                endif ; ~_CORE_MODULE_AI_TASK_WAIT_
