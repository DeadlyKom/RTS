
                    ifndef _CORE_MODULE_UTILS_PATH_FINDING_ADD_NEIGHBORS_
                    define _CORE_MODULE_UTILS_PATH_FINDING_ADD_NEIGHBORS_

                    module Pathfinding
; -----------------------------------------
; добавить соседей текущему тайлу
; In:
;   DE - позиция тайла (D - y, E - x)
; Out:
; Corrupt:
;   HL, BC, AF, AF'
; Note:
;   requires included memory page
; -----------------------------------------
AddNeighbors:       ; ---------------------------------------------
                    ; LEFT
                    ; ---------------------------------------------
                    
                    ; [X - 1], Y + 0
                    DEC E
                    JP M, .SkipLeft

                    LD A, VECTOR_RIGHT
                    EX AF, AF'
                    CALL .Check
                    RET C                                       ; выход, т.к. очередь переполнено

.SkipLeft           INC E
                    ; ---------------------------------------------
                    ; LEFT_UP
                    ; ---------------------------------------------
                    
                    ; [X - 1], [Y - 1]
                    DEC E
                    JP M, .SkipLeftUp
                    DEC D
                    JP M, .SkipLeftUp_Y

                    LD A, VECTOR_RIGHT_DOWN
                    EX AF, AF'
                    CALL .Check
                    RET C                                       ; выход, т.к. очередь переполнено

.SkipLeftUp_Y       INC D
.SkipLeftUp         INC E
                    ; ---------------------------------------------
                    ; UP
                    ; ---------------------------------------------
                    
                    ; X + 0, [Y - 1]
                    DEC D
                    JP M, .SkipUp

                    LD A, VECTOR_DOWN
                    EX AF, AF'
                    CALL .Check
                    RET C

.SkipUp             INC D
                    ; ---------------------------------------------
                    ; RIGHT_UP
                    ; ---------------------------------------------
                    
                    ; [X + 1], [Y - 1]
                    INC E
                    LD A, (TilemapWidth_NEG)
                    ADD A, E
                    JP P, .SkipRightUp
                    DEC D
                    JP M, .SkipRightUp_Y

                    LD A, VECTOR_LEFT_DOWN
                    EX AF, AF'
                    CALL .Check
                    RET C                                       ; выход, т.к. очередь переполнено

.SkipRightUp_Y      INC D
.SkipRightUp        DEC E
                    ; ---------------------------------------------
                    ; RIGHT
                    ; ---------------------------------------------
                    
                    ; [X + 1], Y + 0
                    INC E
                    LD A, (TilemapWidth_NEG)
                    ADD A, E
                    JP P, .SkipRight

                    LD A, VECTOR_LEFT
                    EX AF, AF'
                    CALL .Check
                    RET C                                       ; выход, т.к. очередь переполнено
                
.SkipRight          DEC E
                    ; ---------------------------------------------
                    ; RIGHT_DOWN
                    ; ---------------------------------------------
                    
                    ; [X + 1], [Y + 1]
                    INC E
                    LD A, (TilemapWidth_NEG)
                    ADD A, E
                    JP P, .SkipRightDown
                    INC D
                    LD A, (TilemapHeight_NEG)
                    ADD A, D
                    JP P, .SkipRightDown_Y

                    LD A, VECTOR_LEFT_UP
                    EX AF, AF'
                    CALL .Check
                    RET C                                       ; выход, т.к. очередь переполнено

.SkipRightDown_Y    DEC D
.SkipRightDown      DEC E
                    ; ---------------------------------------------
                    ; DOWN
                    ; ---------------------------------------------
                    
                    ; X + 0, [Y + 1]
                    INC D
                    LD A, (TilemapHeight_NEG)
                    ADD A, D
                    JP P, .SkipDown

                    LD A, VECTOR_UP
                    EX AF, AF'
                    CALL .Check
                    RET C                                       ; выход, т.к. очередь переполнено

.SkipDown           DEC D
                    ; ---------------------------------------------
                    ; LEFT_DOWN
                    ; ---------------------------------------------
                    
                    ; [X - 1], Y + 1
                    DEC E
                    JP M, .SkipLeftDown
                    INC D
                    LD A, (TilemapHeight_NEG)
                    ADD A, D
                    JP P, .SkipLeftDown_Y

                    LD A, VECTOR_RIGHT_UP
                    EX AF, AF'
                    CALL .Check
                    RET C                                       ; выход, т.к. очередь переполнено

.SkipLeftDown_Y     DEC D               
.SkipLeftDown       INC E

                    OR A
                    RET

.Check              CALL Utils.Tilemap.GetAddressTilemap        ; HL - указывает на адрес тайла
                    CALL Utils.Pathfinding.GetVectorField
                    RRA
                    JR C, .Skip                                 ; если это пройденый тайл, нельзя перезатерать
                    CALL Utils.Surface.GetProperty              ; A  - хранит свойство тайла
                    LD C, A

                    ; проверка что тайл проходимый
                    AND SCF_MASK
                    CP SCF_BLOCK
                    JR Z, .Skip                                 ; тайл не проходим

                    ; поправки проходимости (для получения конечной стоимости прохода)
                    LD A, C
                    RRA
                    RRA
                    AND %00001100
                    LD C, A

                    EX AF, AF'
                    BIT 1, A
                    LD B, #00
                    JR Z, $+4
                    LD B, #02
                    EX AF, AF'

                    ; добавить в поле направление
                    CALL Utils.Pathfinding.SetVectorField       ; в A' - номер вектора

                    ; посчитать стоимость прохода
                    CALL Utils.Pathfinding.GetHeuristic         ; A - значение эвристики
                    ADD A, C                                    ; A += стоимость прохода по поверхности
                    ADD A, B
                    
                    ; добавить в очередь стоимость и позицию тайла
                    CALL Utils.Pathfinding.AddToQueue
                    RET

.Skip               OR A
                    RET

                    endmodule

                    endif ; ~ _CORE_MODULE_UTILS_PATH_FINDING_ADD_NEIGHBORS_