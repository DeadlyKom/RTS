
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
                ; SET FUSF_ATTACK_BIT, (IX + FUnit.State)
                CALL Utils.Unit.State.SetATTACK
                ; XOR A
                ; LD (IX + FUnit.Animation), A
                SCF
                ; OR A
                RET

                endif ; ~_CORE_MODULE_AI_TASK_ATTACK_
