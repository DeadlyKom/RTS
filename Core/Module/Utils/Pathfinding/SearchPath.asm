
                ifndef _CORE_MODULE_UTILS_PATHFINDING_SEARCH_PATH_
                define _CORE_MODULE_UTILS_PATHFINDING_SEARCH_PATH_

; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SearchPath:     ;

                ; initialize
                LD HL, #FFFF
                LD (Step.LeastHeuristic), HL

                ; не нужно каждый раз перед поиском (только при смене размера карты)
                LD A, (TilemapWidth_NEG)
                LD (Step.NegWidthTM_A), A
                LD (Step.NegWidthTM_B), A

                LD A, (TilemapHeight_NEG)
                LD (Step.NegHeightTM_A), A
                LD (Step.NegHeightTM_B), A
                LD (Step.NegHeightTM_C), A

                RET

                endif ; ~ _CORE_MODULE_UTILS_PATHFINDING_SEARCH_PATH_
