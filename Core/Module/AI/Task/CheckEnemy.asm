
                ifndef _CORE_MODULE_AI_TASK_CHECK_ENEMY_
                define _CORE_MODULE_AI_TASK_CHECK_ENEMY_

; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
CheckEnemy:     EX AF, AF'
                SCF
                EX AF, AF'
                RET

                endif ; ~_CORE_MODULE_AI_TASK_CHECK_ENEMY_
 