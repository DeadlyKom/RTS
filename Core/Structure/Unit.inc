
                ifndef _STRUCTURE_UNIT_
                define _STRUCTURE_UNIT_

                include "UnitType.inc"

                struct FUnit
Type            DB #00                                                          ; 1 byte (тип юнита)
State           DB #00                                                          ; 1 byte (состояния поведения)
Position        FLocation                                                       ; 2 bytes (позиция в тайлах)
Offset          FLocation                                                       ; 2 bytes (смещение относительно тайла)
Target          FLocation                                                       ; 2 bytes (позиция цели)
;
;      7    6    5    4    3    2    1    0
;   +----+----+----+----+----+----+----+----+
;   | WP | IX | IN | LP | NX | O2 | O1 | O0 |
;   +----+----+----+----+----+----+----+----+
;
;   WP - [7]     бит валидности указанного Way Point
;   IX - [6]     бит валидности данных об индексе
;   IN - [5]     бит вставки (если 1 WP хранит временный путь, увеличивать смещение не нужно)
;   LP - [4]     бит зацикленности
;   NX - [3]     бит длины последовательности более 8, последний индекс (отсчёт от 7 до 0) в цепочке указывает индекс следующей цепочки
;   O  - [2..0]  смещение (обратное от 7 до 0)
;
Data            DB #00                                                          ; данные последовательности
Idx             DB #00                                                          ; 1 byte (индекс в массиве Way Points)
Direction       DB #00                                                          ; 1 byte (направления)
Animation       DB #00                                                          ; 1 byte (номер анимации)
CounterDown     DB #00                                                          ; 1 byte (счётчика)
CounterUp       DB #00                                                          ; 1 byte (счётчика)
Delta           DB #00                                                          ; 1 byte (дельта)
Flags           DB #00                                                          ; 1 byte
Health          DB #00                                                          ; 1 byte (количество жизни)
Armor           DB #00                                                          ; 1 byte (количество брони)
Rank            DB #00                                                          ; 1 byte (ранг)
Killed          DB #00                                                          ; 1 byte (количество убитых)
BehaviorTree    FBehaviorTree                                                   ; 2 bytes (состояние дерева поведения)
                ends

UNIT_SIZE       EQU 32                                                          ; размер структуры юнита

                endif ; ~_STRUCTURE_UNIT_