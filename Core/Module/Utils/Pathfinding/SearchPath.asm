
                ifndef _CORE_MODULE_UTILS_PATHFINDING_SEARCH_PATH_
                define _CORE_MODULE_UTILS_PATHFINDING_SEARCH_PATH_

; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SearchPath:     ; ---------------------------------------------
                ; preparation before initialization
                ; ---------------------------------------------
                SetFrameFlag SWAP_SCREENS_FLAG                                  ; сбросить переключение экрана,
                                                                                ; с последующим перерисованием первого экрана
                SetFrameFlag RENDER_FINISHED                                    ; запрещает обновление данных на экране (при скролле)

                ; SetFrameFlag RESTORE_CURSOR

                CALL Memory.SetPage1                                            ; включить страницу

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

                ;
                LD HL, #0000   
                LD (Utils.Pathfinding.Step.BufferStart), HL
                LD (Utils.Pathfinding.GetTileInfo.BufferStart), HL              ; GetTileInfo.BufferStart
                LD A, L
                LD (Utils.Pathfinding.AddToOpenList.BufferStartX), A            ; AddToOpenList.BufferStartX
                LD A, H
                LD (Utils.Pathfinding.AddToOpenList.BufferStartY), A            ; AddToOpenList.BufferStartY
                LD HL, #0B0F
                LD (Utils.Pathfinding.Step.BufferEnd), HL  

                ; compute end point
                CALL Utils.Mouse.ConvertToTilemap                               ; DE = end tile position
                LD (Utils.Pathfinding.GetHeuristics.EndLocation), DE

                ; compute start point
                CALL Utils.Units.GetSelected                                    ; DE = start tile position

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
                ;   DE   - tile position (D - y, E - x)
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

.Complite       CALL Step

                CALL Tilemap.ForceScreen                                        ; обновление экранов
                SetGameplayFlag (PATHFINDING_FLAG | PATHFINDING_REQUEST_PLAYER_FLAG) ; разрешить поиск
                ; ResetFrameFlag RESTORE_CURSOR
                RET

                endif ; ~ _CORE_MODULE_UTILS_PATHFINDING_SEARCH_PATH_
