
                ifndef _CORE_MODULE_PATHFINDING_ASTAR_GET_FOUND_PATH_
                define _CORE_MODULE_PATHFINDING_ASTAR_GET_FOUND_PATH_

; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
GetFoundPath:   ; FCoord CurrentCoord = BestCoord;
.BestCoord      EQU $+1
                LD DE, #0000

                ; FCoord NextCoord = GetMapData(CurrentCoord).ParentCoord;
                CALL GetTileInfo
                LD L, A
                LD H, HIGH PathfindingBuffer | FPFInfo.Flags

                ; BIT PF_IS_START_COORD_BIT, (HL)
                LD A, (HL)                                                      ; HL - pointer to FPFInfo.Flags                     (0)
                RRA
                JR C, .Exit

                INC H                                                           ; HL - pointer to FPFInfo.ParentCoord.X             (1)

                LD A, (HL)
                INC H
                LD H, (HL)
                LD L, A

                ; HL - NextCoord
                ; DE - CurrentCoord
            
                EX DE, HL

                ; Path.push_front(CurrentCoord);
                PUSH HL                                                         ; push CurrentCoord
                LD A, #02                                                       ; one coord in stack
                EX AF, AF'

                ; FCoord PrevDiff = CurrentCoord - NextCoord;
                OR A
                SBC HL, DE
                LD (.PrevDiff), HL

.While          ; FCoord NextCoord = GetMapData(CurrentCoord).ParentCoord;
                CALL GetTileInfo
                LD L, A
                LD H, HIGH PathfindingBuffer | FPFInfo.Flags

                ; BIT PF_IS_START_COORD_BIT, (HL)
                LD A, (HL)                                                      ; HL - pointer to FPFInfo.Flags                     (0)
                RRA
                JR C, .Exit

                INC H                                                           ; HL - pointer to FPFInfo.ParentCoord.X             (1)

                LD A, (HL)
                INC H
                LD H, (HL)
                LD L, A

                ; HL - NextCoord
                ; DE - CurrentCoord
            
                EX DE, HL
                LD (.CurrentCoord), HL                                          ; save CurrentCoord

                ; FCoord Diff = CurrentCoord - NextCoord;
                OR A
                SBC HL, DE
                PUSH HL

.PrevDiff       EQU $+1
                LD BC, #0000

                ; if (PrevDiff != Diff)
                OR A
                SBC HL, BC
                POP HL
                JR Z, .While

                ; PrevDiff = Diff;
                LD (.PrevDiff), HL

                ; Path.push_front(CurrentCoord);
.CurrentCoord   EQU $+1
                LD BC, #0000
                PUSH BC                                                         ; push CurrentCoord
                EX AF, AF'
                INC A
                EX AF, AF'
                JR .While

.Exit           ; создать цепочку waypoints
                ; JR$
                CALL Utils.WaypointsSequencer.Create
                JR C, $

                ; инициализация юнита
                LD HL, (UnitArrayRef)
                LD A, L
.UnitIdx        EQU $+1
                ADD A, #00
                LD L, A
                LD C, FUTF_VALID_IDX | FUTF_INSERT | FUTF_MASK_OFFSET
                CALL Utils.WaypointsSequencer.AddUnit.UnitAddressToHL


.NextWaypoint   EX AF, AF'
                DEC A
                RET Z
                EX AF, AF'

                POP DE

                ; добавим Waypoint
                CALL Utils.WaypointsSequencer.AddWaypoint
                JR C, .NextWaypoint

                EX AF, AF'
                DEC A
                ADD A, A
                LD L, A
                LD H, #00
                ADD HL, SP
                LD SP, HL
                RET

                endif ; ~ _CORE_MODULE_PATHFINDING_ASTAR_GET_FOUND_PATH_
