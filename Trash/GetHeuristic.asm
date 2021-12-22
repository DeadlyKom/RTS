
                ifndef _CORE_MODULE_UTILS_PATH_FINDING_HEURISTIC_
                define _CORE_MODULE_UTILS_PATH_FINDING_HEURISTIC_

                module Pathfinding
; -----------------------------------------
; эвристика = abs(x1 - x2) + abs(y1 - y2)
; In:
;   DE - позиция тайла (D - y, E - x)
; Out:
;   A  - значение эвристики
; Corrupt:
;   HL, AF
; Note:
;   requires included memory page
; -----------------------------------------
GetHeuristic:   ;
.Location       EQU $+1
                LD HL, #0000

                ; abs(y1 - y2)
                LD A, H
                SUB D
                JP P, $+5
                NEG
                LD H, A
                
                ; abs(x1 - x2)
                LD A, L
                SUB E
                JP P, $+5
                NEG
                ADD A, H

                RET NC

                LD A, #FF
                      
                RET

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_PATH_FINDING_HEURISTIC_