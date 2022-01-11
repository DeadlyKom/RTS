
                ifndef _CORE_MODULE_AI_TASK_ATTACK_OR_MOVE_TO_
                define _CORE_MODULE_AI_TASK_ATTACK_OR_MOVE_TO_

; -----------------------------------------
; атака цели или перемещение к ней
; In:
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
AttackOrMoveTo:       
                ; JR$
                BIT FUTF_ENEMY_WP_BIT, (IX + FUnit.Data)
                JP NZ, AI.BTT.AttackTo

                BIT FUSF_ATTACK_BIT, (IX + FUnit.State)
                JP Z, AI.BTT.MoveTo

                ; сброс анимации атаки
                RES FUSF_ATTACK_BIT, (IX + FUnit.State)
                XOR A
                LD (IX + FUnit.Animation), A

                JP AI.BTT.MoveTo

                endif ; ~_CORE_MODULE_AI_TASK_ATTACK_OR_MOVE_TO_
