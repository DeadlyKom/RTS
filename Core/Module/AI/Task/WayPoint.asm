
                ifndef _CORE_MODULE_AI_TASK_WAY_POINT_
                define _CORE_MODULE_AI_TASK_WAY_POINT_

; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
WayPoint:       ; драфт Way Point положение мыши
                LD DE, (MousePositionRef)
                LD HL, TilemapOffsetRef

                ; convert mouse position on screen to tilemap location
                LD A, E
                RRA
                RRA
                RRA
                RRA
                AND %00001111
                ADD A, (HL)
                LD E, A

                INC HL

                LD A, D
                RRA
                RRA
                RRA
                RRA
                AND %00001111
                ADD A, (HL)
                LD D, A

                XOR A
                CALL AI.Utils.WayPoint.Set
                ; успешно найденый Way Point
                SCF
                RET

                endif ; ~_CORE_MODULE_AI_TASK_WAY_POINT_
