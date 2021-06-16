
                ifndef _STRUCTURE_MAP_
                define _STRUCTURE_MAP_

                struct FMap
Address         DW #0000                        ; адрес тайловой карты
Size            FMapSize 0, 0                   ; размер карты
StartLocation   FLocation 0, 0                  ; координаты начала
BehaviorTable   DW #0000                        ; адрес таблицы поведения
UnitsArray      DW #0000                        ; адрес массива юнитов (выровнен 256)
MaxTotalUnits   DB #00                          ; максимальное общее количество юнитов
MaxUnits        DB #00                          ; максимальное количество юнитов (игрока)
MaxNeutralUnits DB #00                          ; максимальное количество нейтральных юнитов
MaxEnemyUnits   DB #00                          ; максимальное количество вражеских юнитов
UnitsTable      DW #0000                        ; адрес таблици характеристик юнитов
TileTable       DW #0000                        ; адрес таблици характеристик тайлов

                ends

                endif ; ~_STRUCTURE_MAP_