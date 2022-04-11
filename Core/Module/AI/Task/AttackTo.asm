
                ifndef _CORE_MODULE_AI_TASK_ATTACK_
                define _CORE_MODULE_AI_TASK_ATTACK_

; -----------------------------------------
; атака цели
; In:
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
AttackTo:       
                ; JR$
                CALL Utils.Unit.State.SetATTACK                                 ; установка состояния атаки
                ; SCF

                ; RET
                LD A, BTS_SUCCESS 
                JP AI.SetState

                endif ; ~_CORE_MODULE_AI_TASK_ATTACK_
