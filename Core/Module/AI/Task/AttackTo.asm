
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
AttackTo:       ; 
                CALL Utils.Unit.State.SetATTACK                                 ; установка состояния атаки
                JP AI.SetBTS_SUCCESS

                endif ; ~_CORE_MODULE_AI_TASK_ATTACK_
