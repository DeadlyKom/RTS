
                ifndef _CORE_MODULE_ANIMATION_BLAND_DEAD_
                define _CORE_MODULE_ANIMATION_BLAND_DEAD_

; -----------------------------------------
; бленд анимации смерти
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Dead:           ;
                RES FUSF_SELECTED_BIT, (IX + FUnit.State)                       ; сброс флага FUSF_SELECTED
                
                ;
                LD A, (IX + FUnit.CounterDown)                                  ; получим значение текущего счётчика
                AND FUAF_COUNT_DOWN_MASK
                JR NZ, .DEC
                LD A, #02
                LD (IX + FUnit.CounterDown), A

                ;
                LD A, (IX + FUnit.Animation)
                AND %00000011
                INC A
                CP #04
                JR NZ, $+3
                DEC A
                LD (IX + FUnit.Animation), A

                ; обновление облости
                CALL Unit.RefUnitOnScr

                RET

.DEC            DEC (IX + FUnit.CounterDown)
                RET

                endif ; ~_CORE_MODULE_ANIMATION_BLAND_DEAD_
