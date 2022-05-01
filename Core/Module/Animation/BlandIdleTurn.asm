
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
Idle:           ; расчитаем вероятность поворота
                CALL Utils.Math.Rand8
                ; CP #10                                                          ; чем меньше тем чаще происходит поворот
                ; RET NC

                PUSH AF
                EX AF, AF'                                                      ; сохраним рандомное число
                CALL .TryTurnDown
                POP AF

                ; проверка что юнит составной
                BIT COMPOSITE_UNIT_BIT, (IX + FUnit.Type)
                RET Z                                                           ; юнит не является составным

                EX AF, AF'                                                      ; сохраним рандомное число

.TryTurnUp      ; проверка верхнего счётчика Idle
                LD A, (IX + FUnit.CounterUp)
                LD C, A
                AND FUAF_IDLE_COUNT_MASK
                ; SUB FUAF_IDLE_DECREMENT
                JR Z, .TurnUp                                                   ; счётчик обнулён, вызов смены анимации

                ; декремент верхнего счётчика Idle
                LD A, C
                SUB FUAF_IDLE_DECREMENT
                LD (IX + FUnit.CounterUp), A

                RET

.TryTurnDown    ; проверка нижнего счётчика Idle
                LD A, (IX + FUnit.CounterDown)
                LD C, A
                AND FUAF_IDLE_COUNT_MASK
                ; SUB FUAF_IDLE_DECREMENT
                JR Z, .TurnDown                                                 ; счётчик обнулён, вызов смены анимации

                ; декремент нижнего счётчика Idle
                LD A, C
                SUB FUAF_IDLE_DECREMENT
                LD (IX + FUnit.CounterDown), A

                RET

.TurnDown       ; обновим счётчик поворота юнита в состоянии простоя
                LD A, C
                OR FUAF_IDLE_COUNT_MASK
                LD (IX + FUnit.CounterDown), A
                
                ; получим текущий поворот
                LD A, (IX + FUnit.Direction)
                RRA
                RRA
                RRA
                AND DF_DOWN_MASK >> 3
                LD C, A                                                         ; сохраним текущий поворот

                ; выбор рандомного направления
                EX AF, AF'                                                      ; востановим рандомное число
                RRA
                SBC A, A                                                        ; < 4 = -1, > 4 = 0
                CCF
                ADC A, #00

                JP Animation.TurnDown                                           ; вращение нижней части/всего объекта

.TurnUp         ; обновим счётчик поворота юнита в состоянии простоя
                LD A, C
                OR FUAF_IDLE_COUNT_MASK
                LD (IX + FUnit.CounterUp), A
                
                ; выбор рандомного направления
                EX AF, AF'                                                      ; востановим рандомное число
                RLA
                SBC A, A                                                        ; < 4 = -1, > 4 = 0
                CCF
                ADC A, #00

                JP Animation.TurnUp                                             ; вращение нижней части/всего объекта

                endif ; ~_CORE_MODULE_ANIMATION_BLAND_IDLE_TURN_
