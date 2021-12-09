
                ifndef _CORE_MODULE_UTILS_PATHFINDING_STEP_
                define _CORE_MODULE_UTILS_PATHFINDING_STEP_

; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Step:           ; ---------------------------------------------
                ; CALL OpenList.IsEmpty
                ; ---------------------------------------------
                LD A, (AddToOpenList.OpenListIndex)
                CP #FF
                ; ---------------------------------------------
                ; ~CALL OpenList.IsEmpty
                ; ---------------------------------------------
                JP Z, GetFoundPath

                ; FCoord CurrentCoord = ExtractMin();
                CALL ExtractMin

                ; TileData& Data = GetMapData(CurrentCoord);
                CALL GetTileInfo
                LD (.Next + 1), A
                LD (.Data_L2), A
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
                ADD HL, BC
                LD (.LeastHeuristic), HL
                
                ; BestCoord = CurrentCoord;
                LD (.BestCoord), DE

.Less_H_Cost    ; if (CurrentCoord == End)
                LD HL, (GetHeuristics.EndLocation)
                LD A, D
                CP H
                JR NZ, $+7
                LD A, E
                CP L
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

.CanPass        ;

                ; if (Position.x < BufferStart.x || Position.x > BufferEnd.x)
                ; if (Position.y < BufferStart.y || Position.y > BufferEnd.y)
.BufferStart    EQU $+1
                LD HL, #0000
.BufferEnd      EQU $+1
                LD BC, #0000

                ; Position.x < BufferStart.x
                LD A, E
                SUB L
                RET C

                ; Position.x > BufferEnd.x
                LD A, C
                SUB E
                RET C

                ; Position.y < BufferStart.y
                LD A, D
                SUB H
                RET C
                
                ; Position.y > BufferEnd.y
                LD A, B
                SUB D
                RET C
                
                CALL Utils.Tilemap.GetAddressTilemap                            ; HL - pointer to the tile address
                CALL Utils.Surface.GetProperty                                  ; A  - tile property

                ; ---------------------------------------------
                ; tile property
                ; ---------------------------------------------
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   |  D | -- | D1 | D0 | C3 | C2 | C1 | C0 |
                ;   +----+----+----+----+----+----+----+----+
                ;
                ;   D        - destructible
                ;   D [0..1] - deceleration ratio
                ;   C [0..3] - collision flags
                ; ---------------------------------------------

                LD H, A

                ; tile passability check
                AND SCF_MASK
                CP SCF_BLOCK
                RET Z                                                           ; tile is not passable

                ; if (!GetMapData(NextCoord).Flags.bClosed)
                CALL GetTileInfo
                LD L, A
                LD H, HIGH PathfindingBuffer | FPFInfo.Flags                    ; HL - pointer to FPFInfo.Flags                     (0)
                BIT PF_CLOSED_BIT, (HL)
                RET NZ                                                          ; return if (GetMapData(NextCoord).Flags.bClosed == true)

                PUSH DE                                                         ; save tile coord (NextCoord)

                LD HL, .Exit
                PUSH HL

                CALL GetHeuristics
                PUSH HL                                                         ; SP+2 - cost value H_Cost

                ; Cost_45 = 7
                ; Cost_90 = 5

.BestCoord      EQU $+1
                LD BC, #0000
                LD A, D
                CP B
                JR NZ, .LinerMovement
                LD A, E
                CP C
                JR NZ, .LinerMovement

                ; add diagonal movement Cost_45 = 7
                LD A, H
                LD H, #10
                LD L, #07 * 1
                OR A
                JR Z, .Calc_H_Cost
                LD L, #07 * 2
                SUB H
                JR Z, .Calc_H_Cost
                LD L, #07 * 3
                SUB H
                JR Z, .Calc_H_Cost
                LD L, #07 * 4
                JR .Calc_H_Cost

.LinerMovement  ; add linear movement Cost_90 = 5
                LD A, H
                LD H, #10
                LD L, #05 * 1
                OR A
                JR Z, .Calc_H_Cost
                LD L, #05 * 2
                SUB H
                JR Z, .Calc_H_Cost
                LD L, #05 * 3
                SUB H
                JR Z, .Calc_H_Cost
                LD L, #05 * 4

.Calc_H_Cost    ; G_Cost = Data.g + Cost * GetCost(NextCoord);
                LD A, L
.Data_L2        EQU $+1
                LD L, #00
                LD H, HIGH PathfindingBuffer | FPFInfo.G_Cost                   ; HL - pointer to FPFInfo.G_Cost                    (4,5)
                
                ADD A, (HL)
                INC H
                LD H, (HL)
                LD L, A
                JR NC, $+3
                INC H

                PUSH HL                                                         ; SP+0 - cost value G_Cost

                ; ---------------------------------------------
                ;   SP+0 - cost value G_Cost
                ;   SP+2 - cost value H_Cost
                ;   DE   - tile position (D - y, E - x)
                ;   BC   - perent tile position (B - y, C - x)
                ; ---------------------------------------------
                JP AddToOpenList

.Exit           POP DE                                                          ; restore tile coord (NextCoord)
                RET

                endif ; ~ _CORE_MODULE_UTILS_PATHFINDING_STEP_
