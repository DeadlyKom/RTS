
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

                ; проверка что юнит составной
                BIT COMPOSITE_UNIT_BIT, (IX + FUnit.Type)
                JR Z, .NotComposite                                             ; юнит не является составным

                RET

.NotComposite   ;
                LD A, (IX + FUnit.CounterDown)                                  ; получим значение текущего счётчика
                AND FUAF_COUNT_MASK
                JR NZ, .DEC
                LD A, #02
                LD (IX + FUnit.CounterDown), A

                CALL Animation.IncrementDown

                ; обновление облости
                JP Unit.RefUnitOnScr

.DEC            DEC (IX + FUnit.CounterDown)
                RET

                endif ; ~_CORE_MODULE_ANIMATION_BLAND_DEAD_
