
                ifndef _CORE_MODULE_AI_TASK_TURN_TO_
                define _CORE_MODULE_AI_TASK_TURN_TO_

; -----------------------------------------
; поворот в направление цели
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
TurnTo:         ;BIT FUAF_TURN_MOVE_BIT, (IX + FUnit.Flags)                      ; бит принадлежности CounterDown (0 - поворот, 1 - перемещение)
                ;JR NZ, .IsMoveTo                                                ; счётчик указывает на перемещение

                ; расчёт дельты направления
                CALL Utils.GetDeltaTarget
                JR NC, .Fail                                                    ; неудачая точка назначения
                ; ---------------------------------------------
                ; D - dY
                ; E - dX
                ; ---------------------------------------------
                LD A, E
                OR D
                JR Z, .Complite                                                 ; если позиция юнита совподает с позицией WayPoint
                                                                                ; поворот не требуется
                EX DE, HL
                CALL Utils.Unit.State.SetMOVE                                   ; установка состояния перемещения/поворота
                EX DE, HL

                ; проверка что юнит составной
                BIT COMPOSITE_UNIT_BIT, (IX + FUnit.Type)
                JR Z, .NotComposite                                             ; юнит не является составным

                PUSH DE
                ; получение верхнего поворота
                LD A, (IX + FUnit.Direction)
                AND DF_UP_MASK
                CALL Utils.Unit.Turn.GetDirection
                CALL C, Animation.TurnUp
                POP DE

.NotComposite   ; получение нижнего поворота
                LD A, (IX + FUnit.Direction)
                RRA
                RRA
                RRA
                AND DF_DOWN_MASK >> 3
                CALL Utils.Unit.Turn.GetDirection
                JR NC, .Complite

                CALL Animation.TurnDown

.Progress       JP AI.SetBTS_RUNNING                                            ; в процессе выполнения

.Fail           ; неудачное выполнение
                CALL Utils.Unit.State.SetIDLE                                   ; установка состояния юнита в Idle
                JP AI.SetBTS_FAILURE                                            ; неудачное выполнение

.IsMoveTo       ; счётчик указан на перемещение
                ; CALL Utils.Unit.State.SetMOVE                                   ; установка состояния перемещения/поворота
                JP AI.SetBTS_SUCCESS                                            ; успешное выполнение

.Complite       ; юнит повернулся до требуемого направления
                ; CALL Utils.Unit.State.SetIDLE                                   ; установка состояния юнита в Idle
                JP AI.SetBTS_SUCCESS                                            ; успешное выполнение

                endif ; ~_CORE_MODULE_AI_TASK_TURN_TO_
