
                ifndef _CORE_MODULE_PATHFINDING_ASTAR_EXTRACT_MIN_
                define _CORE_MODULE_PATHFINDING_ASTAR_EXTRACT_MIN_

; -----------------------------------------
;
; In:
; Out:
;   DE - tile position (D - y, E - x)
; Corrupt:
;   HL, DE, BC, AF, AF'
; Note:
; -----------------------------------------
ExtractMin:     ; FCoord Ret = OpenList[0]
                XOR A
                LD C, A
                ; CALL OpenList.GetElement
                LD L, A
                LD H, HIGH PathfindingOpenListBuffer
                LD E, (HL)
                INC H
                LD D, (HL)
                PUSH DE                                                         ; save first value

                ; GetMapData(Ret).Flags.bInOpenList = false;
                CALL GetTileInfo
                LD L, A
                LD H, HIGH PathfindingBuffer | FPFInfo.Flags
                RES PF_IN_OPEN_LIST_BIT, (HL)                                   ; HL - pointer to FPFInfo.Flags                     (0)

                ; OpenList[0] = OpenList.back();
                ; GetMapData(OpenList[0]).OpenListIndex = 0;
	            ; OpenList.pop_back();
                ; CALL OpenList.PopLastElement
                LD HL, AddToOpenList.OpenListIndex
                LD A, (HL)
                DEC (HL)
                LD B, A
                LD L, A
                LD H, HIGH PathfindingOpenListBuffer
                LD E, (HL)
                INC H
                LD D, (HL)

                EX AF, AF'                                                      ; A' = last index element
                LD L, C                                                         ; L = 0
                LD (HL), D
                DEC H
                LD (HL), E
                
                CALL GetTileInfo
                LD L, A
                LD H, HIGH PathfindingBuffer| FPFInfo.OpenListIdx
                LD (HL), C                                                      ; set 0 value

                ; if (OpenList.empty()) { return Ret; }
                EX AF, AF'
                OR A
                JP Z, .Exit

                ; BYTE Current = 0;
                ; BYTE OpenListSize = (BYTE)OpenList.size();
                ; FCoord Top = OpenList[Current];     // save root
                ; WORD Top_f = GetMapData(Top).f;

                ; ---------------------------------------------
                ; HL - pointer to GetMapData(OpenList[0])
                ; DE - OpenList[0]                          (Top)
                ; B  - count elements in OpenList           (OpenListSize)
                ; C  - 0                                    (Current)
                ; ---------------------------------------------

                PUSH DE                                                         ; save Top value

                ; DE = GetMapData(Top).f;                   (Top_f)
                LD H, HIGH PathfindingBuffer | FPFInfo.F_Cost                   ; HL - pointer to FPFInfo.F_Cost                    (8)
                LD E, (HL)
                INC H
                LD D, (HL)
                LD (.Top_f+1), DE
                
.While          ; while (Current < (OpenListSize >> 1))
                LD A, B
                SRL A
                SUB C
                JR C, .PreExit
                JR Z, .PreExit

                ; BYTE LeftChild = (Current << 1) + 1;
                LD A, C
                ADD A, A
                INC A
                LD E, A          

		        ; BYTE RightChild = LeftChild + 1;
                INC A
                LD D, A

                ; find smaller child

                ; if (RightChild < OpenListSize)
                SUB B
                JR NC, .NoRigthChild

                LD A, D
                EX AF, AF'                                                      ; save RightChild

                ; WORD Left_f = GetMapData(OpenList[LeftChild]).f;
                LD L, E
                LD H, HIGH PathfindingOpenListBuffer
                LD E, (HL)
                INC H
                LD D, (HL)
                CALL GetTileInfo
                LD L, A
                LD H, HIGH PathfindingBuffer | FPFInfo.F_Cost                   ; HL - pointer to FPFInfo.F_Cost                    (8)
                LD E, (HL)
                INC H
                LD D, (HL)
                PUSH DE                                                         ; save Left_f

                ; WORD Right_f = GetMapData(OpenList[RightChild]).f;
                EX AF, AF'                                                      ; restore RightChild
                LD L, A
                LD H, HIGH PathfindingOpenListBuffer
                LD E, (HL)
                INC H
                LD D, (HL)
                EX AF, AF'                                                      ; save RightChild
                CALL GetTileInfo
                LD L, A
                LD H, HIGH PathfindingBuffer | FPFInfo.F_Cost                   ; HL - pointer to FPFInfo.F_Cost                    (8)
                LD E, (HL)
                INC H
                LD D, (HL)

                POP HL                                                          ; restore Left_f

                ; ---------------------------------------------
                ; HL = Left_f
                ; DE = Right_f
                ; ---------------------------------------------

                ; if (Left_f < Right_f)
                SBC HL, DE
                JR NC, .LessRight_f                                             ; jump if Left_f >= Right_f

.LessLeft_f     ; Right_f > Left_f

				; SmallerChild_f = Left_f;
                ADD HL, DE

                ; SmallerChild = LeftChild;
                EX AF, AF'                                                      ; restore RightChild
                DEC A                                                           ; LeftChild = RightChild - 1
                
                ; ---------------------------------------------
                ; HL = Left_f                       (SmallerChild_f)
                ; A  = LeftChild                    (SmallerChild)
                ; ---------------------------------------------
                JP .Top_f

.LessRight_f    ; Left_f >= Right_f

				; SmallerChild_f = Right_f;
                EX DE, HL

                ; SmallerChild = RightChild;
                EX AF, AF'                                                      ; restore RightChild

                ; ---------------------------------------------
                ; HL = Right_f                      (SmallerChild_f)
                ; A  = RightChild                   (SmallerChild)
                ; ---------------------------------------------
                JP .Top_f

.NoRigthChild   ; there is only a left child

                ; ---------------------------------------------
                ; E = LeftChild
                ; ---------------------------------------------

			    ; SmallerChild_f = GetMapData(OpenList[LeftChild]).f;
                LD A, E
                ; CALL OpenList.GetElement
                LD L, E
                LD H, HIGH PathfindingOpenListBuffer
                LD E, (HL)
                INC H
                LD D, (HL)
                EX AF, AF'                                                      ; save LeftChild
                CALL GetTileInfo
                LD L, A
                LD H, HIGH PathfindingBuffer | FPFInfo.F_Cost                   ; HL - pointer to FPFInfo.F_Cost                    (8)
                LD A, (HL)
                INC H
                LD H, (HL)
                LD L, A

                ; SmallerChild = LeftChild;
                EX AF, AF'                                                      ; restort LeftChild

.Top_f          ; if (Top_f <= SmallerChild_f) { break; }
                LD DE, #0000
                ; ---------------------------------------------
                ; HL = SmallerChild_f
                ; DE = Top_f
                ; C  = Current
                ; A  = SmallerChild
                ; ---------------------------------------------
                OR A    ; не нужен ??? флаг С = 0
                SBC HL, DE
                JR NC, .PreExit                                                 ; jump if SmallerChild_f >=  Top_f

                ; shift child up
                ; OpenList[Current] = OpenList[SmallerChild];
                LD L, A
                LD H, HIGH PathfindingOpenListBuffer
                LD E, (HL)
                INC H
                LD D, (HL)
                EX AF, AF'                                                      ; save SmallerChild

                LD L, C
                ; OpenList[Current] = OpenList[SmallerChild];
                LD (HL), D
                DEC H
                LD (HL), E

                ; GetMapData(OpenList[Current]).OpenListIndex = Current;
                CALL GetTileInfo
                LD L, A
                LD H, HIGH PathfindingBuffer | FPFInfo.OpenListIdx
                LD (HL), C

                // go down one level in the tree
                ; Current = SmallerChild;
                EX AF, AF'                                                      ; restore SmallerChild
                LD C, A
                JP .While

.PreExit        POP DE                                                          ; restore Top value

                ; OpenList[Current] = Top;
                LD L, C
                LD H, HIGH PathfindingOpenListBuffer
                LD (HL), E
                INC H
                LD (HL), D

                ; GetMapData(Top).OpenListIndex = Current;
                CALL GetTileInfo
                LD L, A
                LD H, HIGH PathfindingBuffer | FPFInfo.OpenListIdx
                LD (HL), C

.Exit           POP DE                                                          ; restore first value
                ; return Ret;
                RET

                endif ; ~ _CORE_MODULE_PATHFINDING_ASTAR_EXTRACT_MIN_
