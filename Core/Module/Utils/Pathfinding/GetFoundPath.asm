
                ifndef _CORE_MODULE_UTILS_PATHFINDING_GET_FOUND_PATH_
                define _CORE_MODULE_UTILS_PATHFINDING_GET_FOUND_PATH_

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
                CALL Utils.WaypointsSequencer.Create
                JR C, $

                ; инициализация юнита
                LD HL, (UnitArrayRef)
                LD A, L
                LD C, FUTF_VALID_IDX | FUTF_INSERT | FUTF_MASK_OFFSET
                CALL Utils.WaypointsSequencer.AddUnit


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



;                 EX AF, AF'
; .NextWaypoint   EX AF, AF'
;                 POP DE
;                 ; добавим Waypoint
;                 CALL Utils.WaypointsSequencer.AddWaypoint
;                 JR NC, .SequencerFull

;                 EX AF, AF'
;                 INC A
;                 JR NZ, .NextWaypoint

;                 RET

; .SequencerFull  EX AF, AF'
;                 LD H, #FF
;                 INC A
;                 ADD A, A
;                 LD L, A
;                 ADD HL, SP
;                 LD SP, HL
;                 RET










;                 ; JR$
;                 ; создать цепочку waypoints
;                 CALL Utils.WaypointsSequencer.Create
;                 JR C, $

;                 ; инициализация юнита
;                 LD HL, (UnitArrayRef)
;                 LD A, L
;                 LD C, FUTF_VALID_IDX | FUTF_INSERT | FUTF_MASK_OFFSET
;                 CALL Utils.WaypointsSequencer.AddUnit

;                 ; FCoord CurrentCoord = BestCoord;
; .BestCoord      EQU $+1
;                 LD DE, #0000

;                 LD B, #FF

; .While          ; FCoord NextCoord = GetMapData(CurrentCoord).ParentCoord;
;                 CALL GetTileInfo
;                 LD L, A
;                 LD H, HIGH PathfindingBuffer | FPFInfo.Flags

;                 ; BIT PF_IS_START_COORD_BIT, (HL)
;                 LD A, (HL)                                                      ; HL - pointer to FPFInfo.Flags                     (0)
;                 RRA
;                 JR C, .Build

;                 PUSH DE                                                         ; запомним позицию
;                 DEC B                                                           ; + одна точка в буфере (стеке)

;                 INC H                                                           ; HL - pointer to FPFInfo.ParentCoord.X             (1)

;                 LD E, (HL)
;                 INC H
;                 LD D, (HL)
;                 ; CALL Utils.WaypointsSequencer.AddWaypoint                       ; ранний выход (добавим последний Waypoint)
;                 JR .While

; .Build          ;
;                 INC B
;                 JP Z, Utils.WaypointsSequencer.AddWaypoint                      ; ранний выход (добавим последний Waypoint)

;                 LD A, B

; .Loop           EX AF, AF'

;                 ;
;                 ; EX DE, HL 
;                 ; POP DE
                
;                 POP HL
;                 EX DE, HL
;                 PUSH DE

;                 OR A
;                 SBC HL, DE

; .Direction      EQU $+1
;                 LD BC, #0000
;                 LD (.Direction), HL
;                 OR A
;                 SBC HL, BC
;                 JR Z, $+5
; .Position       EQU $+1
;                 LD DE, #0302
;                 CALL NZ, Utils.WaypointsSequencer.AddWaypoint                   ; добавим Waypoint
;                 POP DE
;                 LD (.Position), DE

;                 EX AF, AF'
;                 INC A
;                 JP Z, Utils.WaypointsSequencer.AddWaypoint                      ; ранний выход (добавим последний Waypoint)
;                 JR .Loop

                endif ; ~ _CORE_MODULE_UTILS_PATHFINDING_GET_FOUND_PATH_
