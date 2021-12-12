
                ifndef _CORE_MODULE_UTILS_PATHFINDING_TRICKLE_UP_
                define _CORE_MODULE_UTILS_PATHFINDING_TRICKLE_UP_

; -----------------------------------------
; 
; In:
;   A  - index of element
; Out:
; Corrupt:
;   HL, DE, BC, AF, AF'
; Note:
; -----------------------------------------
TrickleUp:      ; FCoord Bottom = OpenList[OpenListIndex]
                ; CALL OpenList.GetElement                                        ; DE = OpenList[A]
                LD L, A
                LD H, HIGH PathfindingOpenListBuffer
                LD E, (HL)
                INC H
                LD D, (HL)

.DE             PUSH DE
                EX AF, AF'                                                      ; save OpenListIndex

                ; WORD New_f = GetMapData(Bottom).f
                CALL GetTileInfo
                LD L, A
                LD H, HIGH PathfindingBuffer | FPFInfo.F_Cost
                LD C, (HL)
                INC H
                LD B, (HL)

                EX AF, AF'                                                      ; restore OpenListIndex
.While
                ; BYTE Current = OpenListIndex; && Current = Parent;
                LD (.CurrentIndex), A
                LD D, A

                ; BYTE Parent = (OpenListIndex - 1) >> 1;
                SUB #01
                SRL A ;RRA
                LD E, A

                ; ---------------------------------------------
                ; while (Current != 0 && GetMapData(OpenList[Parent]).f > New_f)
                ; ---------------------------------------------

                ; Current != 0
                LD A, D
                OR A
                JR Z, .Exit      

                ; DE = OpenList[Parent]
                LD A, E
                LD (.ParentIndex), A
                ; CALL OpenList.GetElement                                        ; DE = OpenList[A]
                LD L, A
                LD H, HIGH PathfindingOpenListBuffer
                LD E, (HL)
                INC H
                LD D, (HL)

                ; HL = GetMapData(OpenList[Parent]).f
                CALL GetTileInfo
                PUSH BC
                LD L, A
                LD H, HIGH PathfindingBuffer | FPFInfo.F_Cost
                LD C, (HL)
                INC H
                LD B, (HL)
                POP HL

                ; GetMapData(OpenList[Parent]).f > New_f
                SBC HL, BC
                JR NC, .Exit
                
                ; ---------------------------------------------
                ; copy parent to position of current
                ; ---------------------------------------------

		        ; OpenList[Current] = OpenList[Parent];
.CurrentIndex   EQU $+1
                LD A, #00
                ; CALL OpenList.SetElement
                LD L, A
                LD H, HIGH PathfindingOpenListBuffer
                LD (HL), E
                INC H
                LD (HL), D
                EX AF, AF'                                                      ; save current index

                ; GetMapData(OpenList[Current]).OpenListIndex = Current;
                CALL GetTileInfo
                LD L, A
                LD H, HIGH PathfindingBuffer | FPFInfo.OpenListIdx
                EX AF, AF'                                                      ; restore current index
                LD (HL), A

                ; ---------------------------------------------
                ; go up one level in the tree
                ; ---------------------------------------------

                ; Current = Parent;
.ParentIndex    EQU $+1
                LD A, #00

		        ; Parent = (Parent - 1) >> 1;
                JR .While

.Exit           ; OpenList[Current] = Bottom;
                POP DE
                LD A, (.CurrentIndex)
                ; CALL OpenList.SetElement
                LD L, A
                LD H, HIGH PathfindingOpenListBuffer
                LD (HL), E
                INC H
                LD (HL), D
                EX AF, AF'                                                      ; save Current

                ; GetMapData(OpenList[Current]).OpenListIndex = Current;
                CALL GetTileInfo
                LD L, A
                LD H, HIGH PathfindingBuffer | FPFInfo.OpenListIdx
                EX AF, AF'                                                      ; restore Current
                LD (HL), A

                RET

                endif ; ~ _CORE_MODULE_UTILS_PATHFINDING_TRICKLE_UP_
