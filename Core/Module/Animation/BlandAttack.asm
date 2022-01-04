
                ifndef _CORE_MODULE_ANIMATION_BLAND_ATTACK_
                define _CORE_MODULE_ANIMATION_BLAND_ATTACK_

; -----------------------------------------
; бленд анимации атаки
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Attck:          LD A, (IX + FUnit.Animation)
                INC A
                AND %00000001
                LD (IX + FUnit.Animation), A

                ; обновление облости
                CALL Unit.RefUnitOnScr

                RET

                endif ; ~_CORE_MODULE_ANIMATION_BLAND_ATTACK_
