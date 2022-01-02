
                    ifndef _STRUCTURE_MAP_
                    define _STRUCTURE_MAP_

                    struct FMap
Size                FMapSize 0, 0                                               ; размер карты
StartLocation       FLocation 0, 0                                              ; координаты центра экрана
BehaviorTable       DW #0000                                                    ; адрес таблицы поведения

; AnimTurnUpTable     DW #0000                                                    ; адрес таблицы анимации поворотов (вверх)
; AnimTurnDownTable   DW #0000                                                    ; адрес таблицы анимации поворотов (низа)
; AnimMoveTable       DW #0000                                                    ; адрес таблицы анимации перемещения

; UnitsProperty       DW #0000                                                    ; адрес таблици характеристик юнитов (выровнен 256)

; MaxTotalUnits       DB #00                                                      ; максимальное общее количество юнитов
; MaxUnits            DB #00                                                      ; максимальное количество юнитов (игрока)
; MaxNeutralUnits     DB #00                                                      ; максимальное количество нейтральных юнитов
; MaxEnemyUnits       DB #00                                                      ; максимальное количество вражеских юнитов

                    ends

                    endif ; ~_STRUCTURE_MAP_