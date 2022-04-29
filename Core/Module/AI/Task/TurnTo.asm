
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
TurnTo:         BIT FUAF_TURN_MOVE_BIT, (IX + FUnit.Flags)                      ; бит принадлежности CounterDown (0 - поворот, 1 - перемещение)
                JR NZ, .IsMoveTo                                                ; счётчик указывает на перемещение

                ; расчёт дельты направления
                CALL Utils.GetDeltaTarget
                ; ---------------------------------------------
                ; D - dY
                ; E - dX
                ; ---------------------------------------------
                
                JR NC, .Fail                                                    ; неудачая точка назначения

                LD A, E
                OR D
                JR Z, .Complite                                                 ; если позиция юнита совподает с позицией WayPoint
                                                                                ; поворот не требуется

                CALL Utils.Unit.State.SetMOVE                                   ; установка состояния перемещения/поворота

                LD A, (IX + FUnit.Direction)
                JP Utils.Unit.Turn.Down                                         ; вернёт флаг успешности

.Fail           ; неудачное выполнение
                CALL Utils.Unit.State.SetIDLE                                   ; установка состояния юнита в Idle
                JP AI.SetBTS_FAILURE

.IsMoveTo       ; счётчик указан на перемещение
                CALL Utils.Unit.State.SetMOVE                                   ; установка состояния перемещения/поворота
                JP AI.SetBTS_SUCCESS                                            ; удачное выполнение

.Complite       ; юнит повернулся до требуемого направления
                CALL Utils.Unit.State.SetIDLE                                   ; установка состояния юнита в Idle
                JP AI.SetBTS_SUCCESS                                            ; удачное выполнение

                endif ; ~_CORE_MODULE_AI_TASK_TURN_TO_
