
                    ifndef _STRUCTURE_MAP_
                    define _STRUCTURE_MAP_

                    struct FMap
FileName            TEXT 8 , {"", 32}                                           ; имя карты на диске
Extension           DB 'M'                                                      ; расширение файла
Size                FMapSize 0, 0                                               ; размер карты
StartLocation       FLocation 0, 0                                              ; координаты центра экрана
SurfacePropertySize DB #00                                                      ; длина свойств тайлов в байтах
BehaviorSize        DW #0000                                                    ; длина поведения в байтах
AnimTUpTableSize    DW #0000                                                    ; длина таблицы анимации поворотов (вверх)
AnimTDownTableSize  DW #0000                                                    ; длина таблицы анимации поворотов (низа)
AnimMoveTableSize   DW #0000                                                    ; длина таблицы анимации перемещения
MapSize             DW #0000                                                    ; длина карты в байтах

; UnitsProperty       DW #0000                                                    ; адрес таблици характеристик юнитов (выровнен 256)

; MaxTotalUnits       DB #00                                                      ; максимальное общее количество юнитов
; MaxUnits            DB #00                                                      ; максимальное количество юнитов (игрока)
; MaxNeutralUnits     DB #00                                                      ; максимальное количество нейтральных юнитов
; MaxEnemyUnits       DB #00                                                      ; максимальное количество вражеских юнитов

                    ends

                    endif ; ~_STRUCTURE_MAP_