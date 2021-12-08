
                ifndef _CORE_MODULE_UTILS_PATHFINDING_ADD_TO_OPEN_LIST_
                define _CORE_MODULE_UTILS_PATHFINDING_ADD_TO_OPEN_LIST_

; -----------------------------------------
; put on the open list if better
; In:
;   SP+0 - cost value G_Cost
;   SP+2 - cost value H_Cost
;   DE   - tile position (D - y, E - x)
;   BC   - perent tile position (B - y, C - x)
; Out:
; Corrupt:
;   HL, DE, BC, AF, HL', DE', BC', SP+4
; Note:
; -----------------------------------------
AddToOpenList:  ; set return address
                ; POP HL
                ; LD (.JumpTrickleUp+1), HL

                CALL GetTileInfo
                LD L, A
                LD H, HIGH PathfindingBuffer

                ; ---------------------------------------------
                ; HL - pointer to FPFInfo structure in buffer
                ; ---------------------------------------------

                ; if (FPFInfo.Flags.bInOpenList == true)
                BIT PF_IN_OPEN_LIST_BIT, (HL)                                   ; HL - pointer to FPFInfo.Flags                     (0)
                JR NZ, .InOpenList                                              ; jump if (FPFInfo.Flags.bInOpenList == true)

                ; FPFInfo.Flags.bInOpenList = true
                SET PF_IN_OPEN_LIST_BIT, (HL)                                   ; HL - pointer to FPFInfo.Flags                     (0)

                INC H                                                           ; HL - pointer to FPFInfo.ParentCoord.X             (1)

                ; set FPFInfo.ParentCoord
                CALL .SetParentCoord

                ; OpenList.push_back(DE)

                ; ---------------------------------------------
                ; CALL OpenList.AddElement
                ; ---------------------------------------------
                PUSH HL

                ; move to next element
                LD HL, .OpenListIndex
                INC (HL)

                ; set coordinate value to current index
.OpenListIndex  EQU $+1
                LD HL, PathfindingOpenListBuffer
                LD (HL), E
                INC H
                LD (HL), D
                LD A, L

                POP HL
                ; ---------------------------------------------
                ; ~CALL OpenList.AddElement
                ; ---------------------------------------------

                ; FPFInfo.OpenListIdx = (OpenList.size() - 1)
                LD (HL), A
                INC H                                                           ; HL - pointer to FPFInfo.G_Cost                    (4)

                POP BC                                                          ; BC = [SP+0]
                LD (HL), C
                INC H                                                           ; HL - pointer to FPFInfo.G_Cost+1                  (5)
                LD (HL), B
                INC H                                                           ; HL - pointer to FPFInfo.H_Cost                    (6)

                POP DE                                                          ; DE = [SP+4]
                LD (HL), E
                INC H                                                           ; HL - pointer to FPFInfo.H_Cost+1                  (7)
                LD (HL), D
                INC H                                                           ; HL - pointer to FPFInfo.F_Cost                    (8)

                ; F_Cost = G_Cost + H_Cost
                EX DE, HL
                ADD HL, BC
                EX DE, HL
                
                LD (HL), E
                INC H                                                           ; HL - pointer to FPFInfo.F_Cost+1                  (9)
                LD (HL), D

                ; TrickleUp(FPFInfo.OpenListIdx);
                ; JR .JumpTrickleUp                                               ; A = FPFInfo.OpenListIdx
                RET
                
.InOpenList     ; already on openlist
                LD A, L    ;!!!!!!!!!!!!!!!                                                     ; save low byte of pointer to structure

                EXX
                LD L, A                                                         ; restore low byte of pointer to structure
                LD H, HIGH PathfindingBuffer | FPFInfo.F_Cost                   ; HL - pointer to FPFInfo.F_Cost                    (8)

                ; get value F_Cost by pointer to structure
                LD E, (HL)
                INC H                                                           ; HL - pointer to FPFInfo.F_Cost+1                  (9)
                LD D, (HL)

                ; F_Cost = G _Cost + H_Cost
                POP HL                                                          ; HL = G_Cost       [SP+0]
                POP BC                                                          ; BC = H_Cost       [SP+4]
                ADD HL, BC                                                      ; HL = F_Cost

                ; ---------------------------------------------
                ; HL = F_Cost (G _Cost + H_Cost)
                ; DE = FPFInfo.F_Cost
                ; BC = H_Cost
                ; ---------------------------------------------

                ; F_Cost >= FPFInfo.F_Cost
                SBC HL, DE                                                      ; F_Cost - FPFInfo.F_Cost
                EXX ; ??
                RET NC                                                          ; return if F_Cost >= FPFInfo.F_Cost
                                                                                ; new cost is worse, don't change anything
                ; new item is better => replace
                EXX ; ??
                ADD HL, DE                                                      ; HL = F_Cost
                EX DE, HL
                LD L, A
                LD H, HIGH PathfindingBuffer | FPFInfo.F_Cost+1                 ; HL - pointer to FPFInfo.F_Cost+1                  (9)

                ; FPFInfo.F_Cost = F_Cost
                LD (HL), D
                DEC H                                                           ; HL - pointer to FPFInfo.F_Cost                    (8)
                LD (HL), E
                DEC H                                                           ; HL - pointer to FPFInfo.H_Cost+1                  (7)

                ; FPFInfo.H_Cost = H_Cost
                LD (HL), B
                DEC H                                                           ; HL - pointer to FPFInfo.H_Cost                    (6)
                LD (HL), C
                DEC H                                                           ; HL - pointer to FPFInfo.G_Cost+1                  (5)

                ; calculate value G_Cost
                EX DE, HL
                OR A ; ??
                SBC HL, BC                                                      ; HL = G_Cost
                EX DE, HL

                ; FPFInfo.G_Cost = G_Cost
                LD (HL), D
                DEC H                                                           ; HL - pointer to FPFInfo.G_Cost                    (4)
                LD (HL), E
                DEC H                                                           ; HL - pointer to FPFInfo.OpenListIdx               (3)

                EXX

                ; calculate and set FPFInfo.ParentCoord
                LD H, HIGH PathfindingBuffer | FPFInfo.ParentCoord
                CALL .SetParentCoord                                            ; HL - pointer to FPFInfo.OpenListIdx               (3)

                ; get value FPFInfo.OpenListIdx
                LD A, (HL)                                                      ; A = FPFInfo.OpenListIdx
                
; .JumpTrickleUp  ; TrickleUp(FPFInfo.OpenListIdx);
;                 LD HL, #0000
;                 PUSH HL
                JP TrickleUp                                                    ; A = FPFInfo.OpenListIdx

.SetParentCoord ; ---------------------------------------------
                ; HL - pointer to FPFInfo.ParentCoord.X                                                             (1)
                ; BC - perent tile position (B - y, C - x)
                ; ---------------------------------------------

                ; FPFInfo.ParentCoord.X - BufferStart.X
                LD A, C
.BufferStartX   EQU $+1
                SUB #00                                                         ; const value BufferStart.X
                LD (HL), A
                INC H                                                           ; HL - pointer to FPFInfo.ParentCoord.Y             (2)
                
                ; FPFInfo.ParentCoord.Y - BufferStart.Y
                LD A, B
.BufferStartY   EQU $+1
                SUB #00                                                         ; const value BufferStart.Y
                LD (HL), A
                INC H                                                           ; HL - pointer to FPFInfo.OpenListIdx               (3)
                RET

                endif ; ~ _CORE_MODULE_UTILS_PATHFINDING_ADD_TO_OPEN_LIST_
