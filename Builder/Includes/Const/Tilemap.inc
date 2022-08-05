
                ifndef _CONST_TILEMAP_
                define _CONST_TILEMAP_

                define TilemapSetPage SetPage1

                module Size
                module Tilemap
Max:            EQU #2000                                                       ; максимально доступный размер для карты

                endmodule
                endmodule

                module Page
                module Tilemap
Map             EQU 0x01                                                        ; страница тайловой карты
Sprite          EQU 0x07                                                        ; страница спрайтов тайловой карты
                endmodule
                endmodule

                module Adr
                module Tilemap
Map:            EQU MemBank_03                                                  ; адрес тайловой карты
SpriteTable:    EQU MemBank_03_                                                 ; адрес таблицы + спрайтов тайловой карты

                endmodule
                endmodule


                endif ; ~_CONST_TILEMAP_
