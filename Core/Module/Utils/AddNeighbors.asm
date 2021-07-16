
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
AddNeighbors:   ; ---------------------------------------------
                ; LEFT
                ; ---------------------------------------------
                
                ; X - 1, Y + 0
                DEC E
                JP M, .SkipLeft

                CALL Utils.Tilemap.GetAdrTilemap            ; HL - указывает на адрес тайла
                CALL Utils.Surface.GetProperty              ; A  - хранит свойство тайла

                LD C, A

                ; проверка что тайл проходимый
                AND SCF_MASK
                CP SCF_BLOCK
                JR Z, .SkipLeft                             ; тайл не проходим

                ; поправки проходимости (для получения конечной стоимости прохода)
                LD A, C
                RRA
                RRA
                AND %00001100
                LD C, A

                ; добавить в поле направление
                LD A, VECTOR_RIGHT
                CALL Utils.Pathfinding.SetVectorField

                ; посчитать стоимость прохода
                CALL Utils.Pathfinding.GetHeuristic         ; A - значение эвристики
                ADD A, C                                    ; A += стоимость прохода по поверхности
                
                ; добавить в очередь стоимость и позицию тайла
                CALL Utils.Pathfinding.AddToQueue
                RET C                                       ; выход, т.к. очередь переполнено

.SkipLeft       INC E

                ; ---------------------------------------------
                ; RIGHT
                ; ---------------------------------------------
                
                ; X + 1, Y + 0
                INC E
                LD A, (TilemapWidth_NEG)
                ADD A, E
                JP P, .SkipRight

                CALL Utils.Tilemap.GetAdrTilemap            ; HL - указывает на адрес тайла
                CALL Utils.Surface.GetProperty              ; A  - хранит свойство тайла

                LD C, A

                ; проверка что тайл проходимый
                AND SCF_MASK
                CP SCF_BLOCK
                JR Z, .SkipRight                            ; тайл не проходим

                ; поправки проходимости (для получения конечной стоимости прохода)
                LD A, C
                RRA
                RRA
                AND %00001100
                LD C, A

                ; добавить в поле направление
                LD A, VECTOR_LEFT
                CALL Utils.Pathfinding.SetVectorField

                ; посчитать стоимость прохода
                CALL Utils.Pathfinding.GetHeuristic         ; A - значение эвристики
                ADD A, C                                    ; A += стоимость прохода по поверхности
                
                ; добавить в очередь стоимость и позицию тайла
                CALL Utils.Pathfinding.AddToQueue
                RET C                                       ; выход, т.к. очередь переполнено

.SkipRight      DEC E

                ; ---------------------------------------------
                ; UP
                ; ---------------------------------------------
                
                ; X + 0, Y - 1
                DEC D
                JP M, .SkipUp

                CALL Utils.Tilemap.GetAdrTilemap            ; HL - указывает на адрес тайла
                CALL Utils.Surface.GetProperty              ; A  - хранит свойство тайла

                LD C, A

                ; проверка что тайл проходимый
                AND SCF_MASK
                CP SCF_BLOCK
                JR Z, .SkipUp                               ; тайл не проходим

                ; поправки проходимости (для получения конечной стоимости прохода)
                LD A, C
                RRA
                RRA
                AND %00001100
                LD C, A

                ; добавить в поле направление
                LD A, VECTOR_DOWN
                CALL Utils.Pathfinding.SetVectorField

                ; посчитать стоимость прохода
                CALL Utils.Pathfinding.GetHeuristic         ; A - значение эвристики
                ADD A, C                                    ; A += стоимость прохода по поверхности
                
                ; добавить в очередь стоимость и позицию тайла
                CALL Utils.Pathfinding.AddToQueue
                RET C                                       ; выход, т.к. очередь переполнено

.SkipUp         INC D

                ; ---------------------------------------------
                ; DOWN
                ; ---------------------------------------------
                
                ; X + 0, Y + 1
                INC D
                LD A, (TilemapHeight_NEG)
                ADD A, D
                JP P, .SkipDown

                CALL Utils.Tilemap.GetAdrTilemap            ; HL - указывает на адрес тайла
                CALL Utils.Surface.GetProperty              ; A  - хранит свойство тайла

                LD C, A

                ; проверка что тайл проходимый
                AND SCF_MASK
                CP SCF_BLOCK
                JR Z, .SkipDown                             ; тайл не проходим

                ; поправки проходимости (для получения конечной стоимости прохода)
                LD A, C
                RRA
                RRA
                AND %00001100
                LD C, A

                ; добавить в поле направление
                LD A, VECTOR_UP
                CALL Utils.Pathfinding.SetVectorField

                ; посчитать стоимость прохода
                CALL Utils.Pathfinding.GetHeuristic         ; A - значение эвристики
                ADD A, C                                    ; A += стоимость прохода по поверхности
                
                ; добавить в очередь стоимость и позицию тайла
                CALL Utils.Pathfinding.AddToQueue
                RET C                                       ; выход, т.к. очередь переполнено

.SkipDown       DEC D
                OR A

                RET

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_PATH_FINDING_ADD_NEIGHBORS_