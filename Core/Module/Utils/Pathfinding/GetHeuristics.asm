
                ifndef _CORE_MODULE_UTILS_PATHFINDING_HEURISTICS_
                define _CORE_MODULE_UTILS_PATHFINDING_HEURISTICS_

; -----------------------------------------
; get heuristic value
; In:
;   DE - tile position (D - y, E - x)
; Out:
;   HL  - heuristic value
; Corrupt:
;   HL, BC, AF, AF'
; Note:
;   Cost_45 = 7
;   Cost_90 = 5
; -----------------------------------------
GetHeuristics:  ;
.EndLocation    EQU $+1
                LD HL, #0000

                ; dY = abs(Position.y - End.y);
                LD A, D
                SUB H
                JP P, $+5
                NEG
                LD H, A
                EX AF, AF'

                ; dX = abs(Position.x - End.x);
                LD A, E
                SUB L
                JP P, $+5
                NEG
                LD L, A

                ; Delta = (dX - dY)
                SUB H               ; dX - dY
                JP P, .dX_more_dY   ; jump if dX > dY   { A = dY * Cost_45 + (dX - dY) * Cost_90 }
                                    ; else              { A = dX * Cost_45 + (dY - dX) * Cost_90 }

                NEG                 ; Delta = (dY - dX)

                ; replace dY with dX
                EX AF, AF'
                LD A, L
                EX AF, AF'

.dX_more_dY     ; Delta = (dX - dY) or (dY - dX)

                ; Delta * Cost_90 
                LD H, #00
                LD L, A
                LD C, L
                LD B, H
                ADD HL, HL
                ADD HL, HL
                ADD HL, BC
                PUSH BC

                ; (dY or dX) * Cost_45
                EX AF, AF'
                LD H, #00
                LD L, A
                LD C, L
                LD B, H
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                SBC HL, BC

                ; HL = (dY or dX) * Cost_45 + Delta * Cost_90
                POP BC
                ADD HL, BC

                RET

                endif ; ~ _CORE_MODULE_UTILS_PATHFINDING_HEURISTICS_
