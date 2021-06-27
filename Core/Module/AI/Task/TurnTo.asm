
                ifndef _CORE_MODULE_AI_TASK_TURN_TO_
                define _CORE_MODULE_AI_TASK_TURN_TO_

; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
TurnTo:         ; go to FUnitTargets
                INC IXH                                     ; FUnitLocation (2)
                INC IXH                                     ; FUnitTargets  (3)

                CALL AI.Utils.GetDeltaTarget                ; calculate direction delta

                ; ---------------------------------------------
                ; IX - pointer to FUnitLocation (2)
                ; D - dY
                ; E - dX
                ; ---------------------------------------------

                ; restor register IX
                DEC IXH                                     ; FUnitState    (1)

                LD A, (IX + FUnitState.Direction)
                JP AI.Utils.Turn.Down                     ; вернёт флаг успешности

                endif ; ~_CORE_MODULE_AI_TASK_TURN_TO_
