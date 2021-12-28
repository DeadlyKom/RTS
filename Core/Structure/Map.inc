
                    ifndef _STRUCTURE_MAP_
                    define _STRUCTURE_MAP_

                    struct FMap
; Address             DW #0000                                                    ; адрес тайловой карты
ID                  DW #CCCC                                                    ; идентификатор начала структуры
AddressTable        DW #0000                                                    ; адрес таблицы (выровнен 256)
Size                FMapSize 0, 0                                               ; размер карты
StartLocation       FLocation 0, 0                                              ; координаты начала
WaypointArray       DW #0000                                                    ; адрес массива точек пути
BehaviorTable       DW #0000                                                    ; адрес таблицы поведения
AnimTurnUpTable     DW #0000                                                    ; адрес таблицы анимации поворотов (вверх)
AnimTurnDownTable   DW #0000                                                    ; адрес таблицы анимации поворотов (низа)
AnimMoveTable       DW #0000                                                    ; адрес таблицы анимации перемещения
UnitsArray          DW #0000                                                    ; адрес массива юнитов (выровнен 256)
UnitsProperty       DW #0000                                                    ; адрес таблици характеристик юнитов (выровнен 256)
SurfaceProperty     DW #0000                                                    ; адрес таблици характеристик тайлов (выровнен 256)
MaxTotalUnits       DB #00                                                      ; максимальное общее количество юнитов
MaxUnits            DB #00                                                      ; максимальное количество юнитов (игрока)
MaxNeutralUnits     DB #00                                                      ; максимальное количество нейтральных юнитов
MaxEnemyUnits       DB #00                                                      ; максимальное количество вражеских юнитов

                    ends

                    endif ; ~_STRUCTURE_MAP_