
                ifndef _CORE_MODULE_UTILS_PATHFINDING_ADD_TO_OPEN_LIST_
                define _CORE_MODULE_UTILS_PATHFINDING_ADD_TO_OPEN_LIST_

                module Pathfinding
; -----------------------------------------
; put on the open list if better
; In:
;   SP+0 - cost value G_Cost
;   SP+2 - cost value H_Cost
;   DE   - tile position (D - y, E - x)
;   BC   - perent tile position (B - y, C - x)
; Out:
; Corrupt:
; Note:
;   call this function only through a jump
; -----------------------------------------
AddToOpenList:  ;

                CALL GetTileInfo

                ; ---------------------------------------------
                ; HL - pointer to FPFInfo structure in buffer
                ; ---------------------------------------------

                ; if (FPFInfo.Flags.bInOpenList == true)
                BIT PF_IN_OPEN_LIST_BIT, (HL)                   ; HL - pointer to FPFInfo.Flags                     (0)
                JR NZ, .InOpenList                              ; jump if (FPFInfo.Flags.bInOpenList == true)

                ; FPFInfo.Flags.bInOpenList = true
                SET PF_IN_OPEN_LIST_BIT, (HL)                   ; HL - pointer to FPFInfo.Flags                     (0)

                INC H                                           ; HL - pointer to FPFInfo.ParentCoord.X             (1)

                ; FPFInfo.ParentCoord - BufferStart
                LD A, C
.BufferStartX   EQU $+1
                SUB #00                                         ; const value BufferStart.X
                LD (HL), A
                INC H                                           ; HL - pointer to FPFInfo.ParentCoord.Y             (2)
                
                LD A, B
.BufferStartY   EQU $+1
                SUB #00                                         ; const value BufferStart.Y
                LD (HL), A
                INC H                                           ; HL - pointer to FPFInfo.OpenListIdx               (3)

                ; OpenList.push_back(DE)
                CALL $

                ; FPFInfo.OpenListIdx = (OpenList.size() - 1)
                LD (HL), A
                INC H                                           ; HL - pointer to FPFInfo.G_Cost                    (4)

                POP BC                                          ; BC = [SP+0]
                LD (HL), C
                INC H                                           ; HL - pointer to FPFInfo.G_Cost+1                  (5)
                LD (HL), B
                INC H                                           ; HL - pointer to FPFInfo.H_Cost                    (6)

                POP DE                                          ; DE = [SP+4]
                LD (HL), E
                INC H                                           ; HL - pointer to FPFInfo.H_Cost+1                  (7)
                LD (HL), D
                INC H                                           ; HL - pointer to FPFInfo.F_Cost                    (8)

                ; F_Cost = G_Cost + H_Cost
                EX DE, HL
                ADD HL, BC
                EX DE, HL
                
                LD (HL), E
                INC H                                           ; HL - pointer to FPFInfo.F_Cost+1                  (9)
                LD (HL), D

                ; TrickleUp(FPFInfo.OpenListIdx);
                CALL $                                          ; A = FPFInfo.OpenListIdx

                RET
                
.InOpenList     ; already on openlist

                ; HL + FPFInfo.F_Cost
                LD H, HIGH PathfindingBuffer | FPFInfo.F_Cost   ; LD A, H : ADD A, FPFInfo.F_Cost : LD H, A
                EX DE, HL                                       ; DE - pointer to FPFInfo.F_Cost                    (8)

                ; F_Cost = G _Cost + H_Cost
                POP HL                                          ; HL = G_Cost       [SP+0]
                POP BC                                          ; BC = H_Cost       [SP+4]
                ADD HL, BC                                      ; HL = F_Cost

                EX DE, HL                                       ; HL - pointer to FPFInfo.F_Cost                    (8)
                LD C, (HL)
                INC H                                           ; HL - pointer to FPFInfo.F_Cost+1                  (9)
                LD B, (HL)
                EX DE, HL                                       ; DE - pointer to FPFInfo.F_Cost+1                  (9)

                ; ---------------------------------------------
                ; HL = F_Cost (G _Cost + H_Cost)
                ; DE = pointer to FPFInfo.F_Cost+1                                                                  (9)
                ; BC = FPFInfo.F_Cost
                ; ---------------------------------------------

                ; F_Cost >= FPFInfo.F_Cost
                SBC HL, BC                                      ; F_Cost - FPFInfo.F_Cost
                RET NC                                          ; return if F_Cost >= FPFInfo.F_Cost
                                                                ; new cost is worse, don't change anything


                // new item is better => replace
                ; Data.g = g;
                ; Data.h = h;
                ; Data.f = f;
                ; Data.ParentCoord =  ParentCoord - BufferStart;
                ; TrickleUp(Data.OpenListIndex);
                
                RET

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_PATHFINDING_ADD_TO_OPEN_LIST_