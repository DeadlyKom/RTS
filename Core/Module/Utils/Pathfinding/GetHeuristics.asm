
                ifndef _CORE_MODULE_UTILS_PATHFINDING_HEURISTICS_
                define _CORE_MODULE_UTILS_PATHFINDING_HEURISTICS_

                module Pathfinding
; -----------------------------------------
; get heuristic value
; In:
;   DE - tile position (D - y, E - x)
; Out:
;   A  - heuristic value
; Corrupt:
;   HL, AF
; Note:
;   Cost_90 = 5
;   Cost_45 = 7
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
                LD H, L             ; H = dX

.dX_more_dY     ; Delta = (dX - dY) or (dY - dX)

                CP 51               ; 51 * Cost_90 = 255 it is max value
                JR NC, .MaxValue    ; A >= 51 jump, overflow protection

                ; Delta * Cost_90 
                LD L, A
                ADD A, A
                ADD A, A
                ADD A, L
                LD L, A

                ; H * Cost_45
                LD A, H
                
                CP 36               ; 36 * Cost_45 = 252 it is max value
                JR NC, .MaxValue    ; A >= 36 jump, overflow protection

                ADD A, A
                ADD A, A
                ADD A, A
                SUB H

                ; H * Cost_45 + Delta * Cost_90
                ADD A, L
                RET NC

.MaxValue       ; max value
                LD A, #FF
                RET

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_PATHFINDING_HEURISTICS_