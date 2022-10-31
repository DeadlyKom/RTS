
                ifndef _CORE_MODULE_PATHFINDING_ASTAR_SEARCH_PATH_
                define _CORE_MODULE_PATHFINDING_ASTAR_SEARCH_PATH_

; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SearchPath:     ; ---------------------------------------------
                ; preparation before initialization
                ; ---------------------------------------------
                SetFrameFlag (SWAP_SCREENS_FLAG | RENDER_FINISHED)              ; сбросить переключение экрана,
                                                                                ; с последующим перерисованием первого экрана
                                                                                ; запрещает обновление данных на экране (при скролле)

                ; clear temp buffer
                LD DE, #0000
                LD HL, PathfindingBuffer | FPFInfo.Flags + #0100
                CALL MEMSET.SafeFill_256

                ; ---------------------------------------------
                ; initialize
                ; ---------------------------------------------
                ; set max heuristics
                LD HL, #FFFF
                LD (Step.LeastHeuristic), HL

                ; ---------------------------------------------
                ; CALL OpenList.ResetOpenList
                ; ---------------------------------------------
                LD A, #FF
                LD (AddToOpenList.OpenListIndex), A
                ; ---------------------------------------------
                ; ~CALL OpenList.ResetOpenList
                ; ---------------------------------------------

                ; не нужно каждый раз перед поиском (только при смене размера карты)
                LD A, (TilemapWidth_NEG)
                LD (Step.NegWidthTM_A), A
                LD (Step.NegWidthTM_B), A

                LD A, (TilemapHeight_NEG)
                LD (Step.NegHeightTM_A), A
                LD (Step.NegHeightTM_B), A
                LD (Step.NegHeightTM_C), A

                ; compute end point
                CALL Unit.Select.DefineTarget                                   ; DE = end tile position
                ; LD (GetHeuristics.EndLocation), DE
                PUSH DE

                ; compute start point
                CALL Unit.Select.InitSelected                                   ; DE = start tile position
                POP HL
                RET C

                ; расчитать окно поиска
                CALL SearchWindow

                ; return address after completion of 'AddToOpenList' function
                LD HL, .Complite
                PUSH HL

                ; preparation of arguments
                CALL GetHeuristics
                PUSH HL                                                         ; SP+2 - cost value H_Cost
                LD BC, #0000                                                    ; perent tile position
                PUSH BC                                                         ; SP+0 - cost value G_Cost
                LD BC, #FFFF                                                    ; perent tile position

                ; ---------------------------------------------
                ;   SP+0 - cost value G_Cost
                ;   SP+2 - cost value H_Cost
                ;   DE   - tile position        (D - y, E - x)
                ;   BC   - perent tile position (B - y, C - x)
                ; ---------------------------------------------

                ; ---------------------------------------------
                ; AddToOpenList
                ; ---------------------------------------------

                CALL GetTileInfo
                LD L, A
                LD H, HIGH PathfindingBuffer

                ; ---------------------------------------------
                ; HL - pointer to FPFInfo structure in buffer
                ; ---------------------------------------------

                ; FPFInfo.Flags.bInOpenList = true
                LD (HL), PF_IN_OPEN_LIST | PF_IS_START_COORD                    ; HL - pointer to FPFInfo.Flags                     (0)

                ; ---------------------------------------------
                
                JP AddToOpenList.First

.Complite       SET_PAGE_TILEMAP
                CALL Step
                CALL Tilemap.ForceScreen                                        ; обновление экранов

                RET

                endif ; ~ _CORE_MODULE_PATHFINDING_ASTAR_SEARCH_PATH_
