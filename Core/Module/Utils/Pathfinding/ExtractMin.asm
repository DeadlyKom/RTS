
                ifndef _CORE_MODULE_UTILS_PATHFINDING_EXTRACT_MIN_
                define _CORE_MODULE_UTILS_PATHFINDING_EXTRACT_MIN_

; -----------------------------------------
;
; In:
; Out:
;   DE - tile position (D - y, E - x)
; Corrupt:
;   HL, C, AF, AF'
; Note:
; -----------------------------------------
ExtractMin:     ; FCoord Ret = OpenList[0]
                XOR A
                LD C, A
                CALL OpenList.GetElement
                PUSH DE                                                         ; save first value

                ; GetMapData(Ret).Flags.bInOpenList = false;
                CALL GetTileInfo
                LD L, A
                LD H, HIGH PathfindingBuffer | FPFInfo.Flags
                RES PF_IN_OPEN_LIST_BIT, (HL)                                   ; HL - pointer to FPFInfo.Flags                     (0)

                ; OpenList[0] = OpenList.back();
                ; GetMapData(OpenList[0]).OpenListIndex = 0;
	            ; OpenList.pop_back();
                CALL OpenList.PopLastElement
                EX AF, AF'                                                      ; A' = last index element
                LD L, C                                                         ; L = 0
                LD (HL), E
                INC H
                LD (HL), D
                
                CALL GetTileInfo
                LD L, A
                LD H, HIGH PathfindingBuffer
                LD (HL), C                                                      ; set 0 value

                ; if (OpenList.empty()) { return Ret; }
                EX AF, AF'
                OR A
                JR Z, .Exit

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
                
                ; while (Current < (OpenListSize >> 1))
                LD A, B
                SRL A
                SUB C
                JR C, .PreExit
                JR Z, .PreExit

                PUSH DE                                                         ; save Top_f

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

                ; WORD Left_f = GetMapData(OpenList[LeftChild]).f;
                ; WORD Right_f = GetMapData(OpenList[RightChild]).f;

                ; if (Left_f < Right_f)

.NoRigthChild   ;
                POP DE                                                          ; restore Top_f

.PreExit        POP DE                                                          ; restore Top value

.Exit           POP DE                                                          ; restore first value
                RET

                endif ; ~ _CORE_MODULE_UTILS_PATHFINDING_EXTRACT_MIN_
