
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
                ; LD A, E
                ; RRA
                ; RRA
                ; RRA
                ; RRA
                ; AND %00001111
                ; ADD A, (HL)
                ; LD E, A
                ; JR $
                PUSH HL
                LD L, (HL)
                LD H, #00
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                PUSH DE
                LD D, #00
                ADD HL, DE

                LD (.ContainerX), HL

                POP DE
                POP HL
                
                INC HL

                ; LD A, D
                ; RRA
                ; RRA
                ; RRA
                ; RRA
                ; AND %00001111
                ; ADD A, (HL)
                ; LD D, A

                LD L, (HL)
                LD H, #00
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                LD E, D
                LD D, #00
                ADD HL, DE
                EX DE, HL
                
.ContainerX     EQU $+1
                LD BC, #0000

                XOR A
                CALL AI.Utils.WayPoint.Set
                ; успешно найденый Way Point
                SCF
                RET

                endif ; ~_CORE_MODULE_AI_TASK_WAY_POINT_
