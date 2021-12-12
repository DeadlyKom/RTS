
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

.While          ; FCoord NextCoord = GetMapData(CurrentCoord).ParentCoord;
                CALL GetTileInfo
                LD L, A
                LD H, HIGH PathfindingBuffer | FPFInfo.Flags

                ; BIT PF_IS_START_COORD_BIT, (HL)
                LD A, (HL)                                                      ; HL - pointer to FPFInfo.Flags                     (0)
                RRA
                RET C

                INC H                                                           ; HL - pointer to FPFInfo.ParentCoord.X             (1)

                LD E, (HL)
                INC H
                LD D, (HL)
                JR .While

                RET

                endif ; ~ _CORE_MODULE_UTILS_PATHFINDING_GET_FOUND_PATH_
