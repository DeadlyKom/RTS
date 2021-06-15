
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
                INC IXH                                     ; FUnitLocation
                INC IXH                                     ; FUnitTargets

                ; get target location
                BIT FUTF_INDEX, (IX + FUnitTargets.Flags)
                LD L, (IX + FUnitTargets.Location.IDX_X)
                JR Z, .GetLocation
                LD H, (IX + FUnitTargets.Location.Y)

                ; calculate direction
                DEC IXH                                     ; FUnitLocation

                ; delta x
                LD A, H
                SUB (IX + FUnitLocation.TilePosition.X)
                LD E, A
                
                ; delta y
                LD A, L
                SUB (IX + FUnitLocation.TilePosition.Y)
                LD D, A
                
                JR .CalcDirection

.GetLocation    ; calculate direction
                DEC IXH                                     ; FUnitLocation
                LD H, HIGH WayPointArray

                ; delta x
                LD A, (HL)
                SUB (IX + FUnitLocation.TilePosition.X)
                LD E, A

                INC H

                ; delta y
                LD A, (HL)
                SUB (IX + FUnitLocation.TilePosition.Y)
                LD D, A

.CalcDirection  ; restor register IX
                DEC IXH                                     ; FUnitState

                LD A, (IX + FUnitState.Direction)
                CALL AI.Utils.Turn.Down                     ; вернёт флаг успешности
                RET

                endif ; ~_CORE_MODULE_AI_TASK_TURN_TO_
