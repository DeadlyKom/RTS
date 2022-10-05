
                ifndef _CONST_UNIT_MEMORY_MAP_
                define _CONST_UNIT_MEMORY_MAP_

                module Size
                module Unit
Array:          EQU #1000                                                       ; максимально доступный размер для массива юнитов
UnitChank       EQU #0100                                                       ; размер массива чанков для юнитов
DynamicChank    EQU #0100                                                       ; размер массива чанков для динамических объектов

                endmodule
                endmodule

                module Adr
                module Unit

                ; страница 0
Array:          EQU Adr.Unit                                                    ; адрес массива юнитов                              (0)
UnitChank       EQU Array + Size.Unit.Array                                     ; адрес адрес массива чанков для юнитов             (1)
DynamicChank    EQU UnitChank + Size.Unit.UnitChank                             ; адрес массива чанков для динамических объектов    (2)

                endmodule
                endmodule

                endif ; ~_CONST_UNIT_MEMORY_MAP_
