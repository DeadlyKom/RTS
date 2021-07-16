
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
                CALL Utils.Mouse.ConvertToTilemap

                XOR A
                CALL Utils.WayPoint.Set
                ; успешно найденый Way Point
                SCF
                RET

                endif ; ~_CORE_MODULE_AI_TASK_WAY_POINT_
