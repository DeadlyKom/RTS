
                ifndef _CORE_MODULE_UTILS_PATHFINDING_STEP_
                define _CORE_MODULE_UTILS_PATHFINDING_STEP_

; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Step:           ;
                CALL OpenList.IsEmpty
                JP Z, GetFoundPath

                ; FCoord CurrentCoord = ExtractMin();
                CALL ExtractMin

                ; TileData& Data = GetMapData(CurrentCoord);
                CALL GetTileInfo
                LD (.Next + 1), A
                LD L, A
                LD H, HIGH PathfindingBuffer | FPFInfo.H_Cost                   ; HL - pointer to FPFInfo.H_Cost                    (6,7)
                LD A, (HL)
                INC H
                LD H, (HL)
                LD L, A

                ; if (Data.h < LeastHeuristic)       
.LeastHeuristic EQU $+1
                LD BC, #0000
                OR A    ; ???
                SBC HL, BC
                JR NC, .Less_H_Cost

                ; LeastHeuristic = Data.h;
                ADC HL, BC
                LD (.LeastHeuristic), HL
                
                ; BestCoord = CurrentCoord;
                LD (.BestCoord), DE

.Less_H_Cost    ; if (CurrentCoord == End)
.BestCoord      EQU $+1
                LD HL, #0000
                LD BC, (GetHeuristics.EndLocation)
                OR A
                SBC HL, BC
                JP Z, GetFoundPath                                              ; destination found

                ; push a node for each direction we could go

                ; ---------------------------------------------
                ; DE - CurrentCoord (D = Y, E = X)
                ; ---------------------------------------------
                ;
                ;       +---+---+---+
                ;       | 2 | 3 | 4 |
                ;       +---+---+---+
                ;       | 1 | * | 5 |
                ;       +---+---+---+
                ;       | 0 | 7 | 6 |
                ;       +---+---+---+
                ;
                ; ---------------------------------------------
       
                ; left edge check
                DEC E                                                           ; X = X - 1
                JP M, .Skip012                                                  ; if X < 0 then skip LeftDown, Left, LeftUp

                ; ---------------------------------------------
                ; Left                                      (1)
                ; ---------------------------------------------
                CALL .CanPass
   
                ; up edge check
                DEC D                                                           ; Y = Y - 1
                JP M, .Skip234                                                  ; if Y < 0 then skip LeftUp, Up, RightUp

                ; ---------------------------------------------
                ; LeftUp                                    (2)
                ; ---------------------------------------------
                CALL .CanPass

                ; ---------------------------------------------
                ; Up                                        (3)
                ; ---------------------------------------------
                INC E                                                           ; X = X + 1
                CALL .CanPass

                ; right edge check
                INC E                                                           ; X = X + 1
                LD A, E
.NegWidthTM_A   EQU $+1                                                         ; negative tilemap width
                ADD A, #00
                JP P, .Skip456                                                  ; if X > 'tilemap width' then skip RightUp, Right, RightDown

                ; ---------------------------------------------
                ; RightUp                                   (4)
                ; ---------------------------------------------
                CALL .CanPass

                ; ---------------------------------------------
                ; Right                                     (5)
                ; ---------------------------------------------
                INC D                                                           ; Y = Y + 1
                CALL .CanPass

                ; down edge check
                INC D                                                           ; Y = Y + 1
                LD A, D
.NegHeightTM_A  EQU $+1                                                         ; negative tilemap height
                ADD A, #00
                RET P                                                           ; if Y > 'tilemap height' then skip RightDown, Down, LeftDown

                ; ---------------------------------------------
                ; RightDown                                 (6)
                ; ---------------------------------------------
                CALL .CanPass

                ; ---------------------------------------------
                ; Down                                      (7)
                ; ---------------------------------------------
                DEC E                                                           ; X = X - 1
                CALL .CanPass

                ; ---------------------------------------------
                ; LeftDown                                  (0)
                ; ---------------------------------------------
                DEC E                                                           ; X = X - 1
                CALL .CanPass

.Next           ; Data.Flags.bClosed = true;
                LD HL, PathfindingBuffer | FPFInfo.Flags                        ; HL - pointer to FPFInfo.Flags                     (0)            
                SET PF_CLOSED_BIT, (HL)

                JP Step

.Skip012        ; skip LeftDown (0), Left (1), LeftUp (2)

                INC E                                                           ; X = X + 1

                ; up edge check
                DEC D                                                           ; Y = Y - 1
                JP M, .Skip01234                                                ; if Y < 0 then skip Up, RightUp and LeftDown, Left, LeftUp

                ; ---------------------------------------------
                ; Up                                        (3)
                ; ---------------------------------------------
                CALL .CanPass

                ; ---------------------------------------------
                ; RightUp                                   (4)
                ; ---------------------------------------------
                INC E                                                           ; X = X + 1
                CALL .CanPass

                ; ---------------------------------------------
                ; Right                                     (5)
                ; ---------------------------------------------
                INC D                                                           ; Y = Y + 1
                CALL .CanPass

                ; down edge check
                INC D                                                           ; Y = Y + 1
                LD A, D
.NegHeightTM_B  EQU $+1                                                         ; negative tilemap height
                ADD A, #00
                RET P                                                           ; if Y > 'tilemap height' then skip RightDown, Down

                ; ---------------------------------------------
                ; RightDown                                 (6)
                ; ---------------------------------------------
                INC D                                                           ; Y = Y + 1
                CALL .CanPass

                ; ---------------------------------------------
                ; Down                                      (7)
                ; ---------------------------------------------
                DEC E                                                           ; X = X - 1
                CALL .CanPass

                JP .Next

.Skip01234      ; skip Up (3), RightUp (4) and LeftDown (0), Left (1), LeftUp (2)

                INC D                                                           ; Y = Y + 1

                 ; ---------------------------------------------
                ; Right                                     (5)
                ; ---------------------------------------------
                INC E                                                           ; X = X + 1
                CALL .CanPass

                ; ---------------------------------------------
                ; RightDown                                 (6)
                ; ---------------------------------------------
                INC D                                                           ; Y = Y + 1
                CALL .CanPass

                ; ---------------------------------------------
                ; Down                                      (7)
                ; ---------------------------------------------
                DEC E                                                           ; X = X - 1
                CALL .CanPass

                JP .Next

.Skip234        ; skip LeftUp (2), Up (3), RightUp (4)
                ; left edge and up edge was checked

                INC D                                                           ; Y = Y + 1

                ; right edge check
                INC E                                                           ; X = X + 1
                LD A, E
.NegWidthTM_B   EQU $+1                                                         ; negative tilemap width
                ADD A, #00
                JP P, .Skip23456                                                ; if X > 'tilemap width' then skip Right, RightDown and LeftUp, Up, RightUp

                ; ---------------------------------------------
                ; Right                                     (5)
                ; ---------------------------------------------
                CALL .CanPass

                ; ---------------------------------------------
                ; RightDown                                 (6)
                ; ---------------------------------------------
                INC D                                                           ; Y = Y + 1
                CALL .CanPass

                ; ---------------------------------------------
                ; Down                                      (7)
                ; ---------------------------------------------
                DEC E                                                           ; X = X - 1
                CALL .CanPass

                ; ---------------------------------------------
                ; LeftDown                                  (0)
                ; ---------------------------------------------
                DEC E                                                           ; X = X - 1
                CALL .CanPass

                JP .Next

.Skip23456      ; skip Right (5), RightDown (6) and LeftUp (2), Up (3), RightUp (4)

                DEC E                                                           ; X = X - 1

                ; ---------------------------------------------
                ; Down                                      (7)
                ; ---------------------------------------------
                INC D                                                           ; Y = Y + 1
                CALL .CanPass

                ; ---------------------------------------------
                ; LeftDown                                  (0)
                ; ---------------------------------------------
                DEC E                                                           ; X = X - 1
                CALL .CanPass
                JP .Next

.Skip456        ; skip RightUp (4), Right (5), RightDown (6) and 
                ; left edge, up edge and right edge was checked

                DEC E                                                           ; X = X - 1

                ; down edge check
                INC D                                                           ; Y = Y + 1
                LD A, D
.NegHeightTM_C  EQU $+1                                                         ; negative tilemap height
                ADD A, #00
                RET P                                                           ; if Y > 'tilemap height' then skip Down, LeftDown

                ; ---------------------------------------------
                ; Down                                      (7)
                ; ---------------------------------------------
                CALL .CanPass

                ; ---------------------------------------------
                ; LeftDown                                  (0)
                ; ---------------------------------------------
                DEC E                                                           ; X = X - 1
                CALL .CanPass
                JP .Next

.CanPass        RET

                endif ; ~ _CORE_MODULE_UTILS_PATHFINDING_STEP_
