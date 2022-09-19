
                    ifndef _CORE_MODULE_UTILS_BUILD_PATH_VECTOR_FIELD_
                    define _CORE_MODULE_UTILS_BUILD_PATH_VECTOR_FIELD_

                    module Pathfinding
; -----------------------------------------
; построить путь из WayPoint по векторного поля
; In:
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
BuildPath:          ; создать цепочку waypoints
                    CALL Utils.WaypointsSequencer.Create
                    DEBUG_BREAK_POINT_C

                    ; инициализация юнита
                    LD HL, UnitArrayPtr
                    LD A, L
                    LD C, FUTF_VALID_IDX | FUTF_INSERT | FUTF_MASK_OFFSET
                    CALL Utils.WaypointsSequencer.AddUnit

                    ; инициализация эвристики
                    LD DE, (Utils.Pathfinding.GetHeuristic.Location)

                    ; инициализация первого направления
                    CALL GetVectorField_DE
                    AND %00001110
                    LD B, A
                    LD HL, .FirstRET
                    JR .NextCell

.FirstRET           ; проверка раннего выходы
.ContainerLocation  EQU $+1
.Loop               LD HL, #0000
                    OR A
                    SBC HL, DE
                    JP Z, Utils.WaypointsSequencer.AddWaypoint                  ; ранний выход (добавим последний Waypoint)
                    ; получение текущее направление
                    CALL GetVectorField_DE
                    AND %00001110
                    CP B
                    JR Z, .NextCell
                    LD (.Previous), A
                    ;
                    CALL Utils.WaypointsSequencer.AddWaypoint
                    JR NC, .Fail

.Previous           EQU $+1
                    LD A, #00
                    LD B, A

.NextCell           LD HL, .Loop
                    AND %00001110
                    ADD A, A
                    LD (.Jump), A
.Jump               EQU $+1
                    JR $
                    DEC D
                    JP (HL)
                    DB #00, #00
                    ; 1 (up-right)
                    DEC D
                    INC E
                    JP (HL)
                    DB #00
                    ; 2 (right)
                    INC E
                    JP (HL)
                    DB #00, #00
                    ; 3 (down-right)
                    INC D
                    INC E
                    JP (HL)
                    DB #00
                    ; 4 (down)
                    INC D
                    JP (HL)
                    DB #00, #00
                    ; 5 (down-left)
                    INC D
                    DEC E
                    JP (HL)
                    DB #00
                    ; 6 (left)
                    DEC E
                    JP (HL)
                    DB #00, #00
                    ; 7 (up-left)
                    DEC D
                    DEC E
                    JP (HL)
                    ; DB #00
.Fail               RET

                    endmodule

                    endif ; ~ _CORE_MODULE_UTILS_BUILD_PATH_VECTOR_FIELD_