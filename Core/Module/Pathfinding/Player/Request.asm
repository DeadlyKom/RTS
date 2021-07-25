
                ifndef _CORE_MODULE_PATHFINDING_PLAYER_REQUEST_
                define _CORE_MODULE_PATHFINDING_PLAYER_REQUEST_

                module Player
Request:        ; ---------------------------------------------
                ; initialize
                ; ---------------------------------------------
                SetFrameFlag SWAP_SCREENS_FLAG                                          ; сбросить переключение экрана,
                                                                                        ; с последующим перерисованием первого экрана
                SetFrameFlag RENDER_FINISHED                                            ; запрещает обновление данных на экране (при скролле)
                ; включить страницу
                CALL Memory.SetPage1                       ; SeMemoryPage MemoryPage_Tilemap, PATHFINDING_PLAYER_ID
                ; очистка экрана #4000 (#FF)
                LD DE, #0000 ; Pathfinding.VECTOR_FIELD_FILL
                LD HL, #4000 + #1000
                CALL MEMSET.SafeFill_4096
                LD DE, #FFFF ; Pathfinding.VECTOR_FIELD_FILL
                LD HL, #5000 + #0800
                CALL MEMSET.SafeFill_2048

                ; ---------------------------------------------
                ; поиск производится от конечной точки к начальной
                ; ---------------------------------------------
                ; JR$
                ; ---------------------------------------------
                ; compute start point
                ; ---------------------------------------------
                CALL Utils.Units.GetSelected                                            ; точка старта
                LD (Utils.Pathfinding.GetHeuristic.Location), DE

                ; ---------------------------------------------
                ; compute end point
                ; ---------------------------------------------
                CALL Utils.Mouse.ConvertToTilemap
                LD A, Pathfinding.VECTOR_FIELD_END
                CALL Utils.Pathfinding.SetVectorField                                   ; установим конечную точку

                ; ---------------------------------------------
                ; добавить соседей текущего тайла
                ; ---------------------------------------------
.Loop           CALL Utils.Pathfinding.AddNeighbors
                JR C, .EndLoop                                                          ; выход если очередь переполнена

                ; ---------------------------------------------
                ; получить из очереди позицию тайла с лучший ценойы
                ; ---------------------------------------------
                CALL Utils.Pathfinding.GetBestCostInQueue                               ; вернуть позицию с наименьшей стоимость перемещения
                CALL Utils.Pathfinding.MarkVectorField                                  ; пометить ячейку

                ; проверка раннего выхода (достиг точки назначения)
                LD HL, (Utils.Pathfinding.GetHeuristic.Location)
                OR A
                SBC HL, DE
                JR NZ, .Loop

                ; JR $

                ; ---------------------------------------------
                ; построить путь из WP по векторному полю
                ; ---------------------------------------------
                CALL Utils.Pathfinding.BuildPath
                ; JR NC, $    ; не хватило место
                ; ---------------------------------------------
                ; 
                ; ---------------------------------------------
.EndLoop        
;                 LD IX, (UnitArrayRef)
;                 INC IXH                                                                 ; FUnitLocation     (2)
;                 INC IXH                                                                 ; FUnitTargets      (3)
                
;                 SET FUTF_VALID_WP_BIT, (IX + FUnitTargets.Data)
;                 SET FUTF_INSERT_BIT, (IX + FUnitTargets.Data)

; .Test           EQU $+1
;                 LD DE, #0000
;                 LD (IX + FUnitTargets.WayPoint.X), E
;                 LD (IX + FUnitTargets.WayPoint.Y), D

;                 DEC IXH                                                                 ; FUnitLocation     (2)
;                 DEC IXH                                                                 ; FUnitState        (1)

                ; ---------------------------------------------
                ; 
                ; ---------------------------------------------
                CALL Tilemap.ForceScreen                                                ; обновление экранов
                SetGameplayFlag (PATHFINDING_FLAG | PATHFINDING_REQUEST_PLAYER_FLAG)    ; разрешить поиск
                RET

                endmodule

                endif ; ~ _CORE_MODULE_PATHFINDING_PLAYER_REQUEST_