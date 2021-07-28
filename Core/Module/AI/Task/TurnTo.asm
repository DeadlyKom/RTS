
                ifndef _CORE_MODULE_AI_TASK_TURN_TO_
                define _CORE_MODULE_AI_TASK_TURN_TO_

; -----------------------------------------
; поворот в направление цели
; In:
;   IX - pointer to FUnitState (1)
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
TurnTo:         ; go to FUnitTargets
                INC IXH                                     ; FUnitLocation     (2)
                INC IXH                                     ; FUnitTargets      (3)

                CALL Utils.GetDeltaTarget                   ; calculate direction delta
                JR NC, .Fail                                ; неудачая точка назначения

                LD A, E
                OR D
                JR Z, .Complite                             ; если позиция юнита совподает с позицией WayPoint
                                                            ; поворот не требуется

                ; ---------------------------------------------
                ; IX - pointer to FUnitLocation (2)
                ; D - dY
                ; E - dX
                ; ---------------------------------------------

                ; restor register IX
                DEC IXH                                     ; FUnitState        (1)
                ; JR $
                LD A, (IX + FUnitState.Direction)
                JP Utils.Turn.Down                          ; вернёт флаг успешности

.Fail           DEC IXH                                     ; FUnitState        (1)

                OR A                                        ; неудачное выполнение
                RET

.Complite       DEC IXH                                     ; FUnitState        (1)

                SCF                                         ; удачное выполнение
                RET

                endif ; ~_CORE_MODULE_AI_TASK_TURN_TO_
