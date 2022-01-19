
                ifndef _CORE_MODULE_ANIMATION_BLAND_IDLE_TURN_
                define _CORE_MODULE_ANIMATION_BLAND_IDLE_TURN_

; -----------------------------------------
; бленд анимации простоя
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Idle:               ; расчитаем вероятность поворота
                    CALL Utils.Math.Rand8
                    CP #10                                                      ; чем меньше тем чаще происходит поворот
                    RET NC
                    EX AF, AF'                                                  ; сохраним рандомное число
                    
                    ; уменьшим счётчик поворота
                    LD A, (IX + FUnit.CounterDown)
                    LD C, A
                    AND FUAF_IDLE_COUNT_MASK
                    SUB FUAF_IDLE_DECREMENT
                    JR C, .Turn                                                 ; счётчик обнулился

                    ;
                    LD A, C
                    SUB FUAF_IDLE_DECREMENT
                    LD (IX + FUnit.CounterDown), A

                    RET
                    
.Turn               ; обновим счётчик поворота юнита в состоянии простоя
                    LD A, C
                    ; AND FUAF_IDLE_COUNT_MASK_INV                              ; не требуется т.к. тупа перезапишим OR новое значение
                    OR FUAF_IDLE_COUNT_MASK
                    LD (IX + FUnit.CounterDown), A
                    
                    ; получим текущий поворот
                    LD A, (IX + FUnit.Direction)
                    RRA
                    RRA
                    RRA
                    AND DF_DOWN_MASK >> 3
                    LD C, A                                                     ; сохраним текущий поворот

                    EX AF, AF'                                                  ; востановим рандомное число
                    RRA

                    SBC A, A                                                    ; < 4 = -1, > 4 = 0
                    CCF
                    ADC A, #00

                    ; вращение нижней части/всего объекта
                    JP Animation.TurnDown

                    endif ; ~_CORE_MODULE_ANIMATION_BLAND_IDLE_TURN_
