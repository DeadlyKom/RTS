
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
TurnTo:         CALL Utils.Unit.State.SetMOVE                                   ; установка состояния перемещения/поворота
                BIT FUAF_TURN_MOVE, (IX + FUnit.Flags)                          ; бит принадлежности CounterDown (0 - поворот, 1 - перемещение)
                JR NZ, .IsMoveTo                                                ; счётчик указывает на перемещение

                ; расчёт дельты направления
                CALL Utils.GetDeltaTarget
                JR NC, .Fail                                                    ; неудачая точка назначения

                LD A, E
                OR D
                JR Z, .Complite                                                 ; если позиция юнита совподает с позицией WayPoint
                                                                                ; поворот не требуется
                ; ---------------------------------------------
                ; D - dY
                ; E - dX
                ; ---------------------------------------------

                LD A, (IX + FUnit.Direction)
                JP Utils.Unit.Turn.Down                                         ; вернёт флаг успешности

.Fail           CALL Utils.Unit.State.SetIDLE                                   ; сброс состояния

                ; неудачное выполнение
                ; OR A
                ; RET
                LD A, BTS_FAILURE 
                JP AI.SetState

.IsMoveTo       ; счётчик указан на перемещение
.Complite       ; юнит повернулся до требуемого направления
                CALL Utils.Unit.State.SetIDLE                                   ; сброс состояния

                ; удачное выполнение
                ; SCF
                ; RET
                LD A, BTS_SUCCESS
                JP AI.SetState

                endif ; ~_CORE_MODULE_AI_TASK_TURN_TO_
