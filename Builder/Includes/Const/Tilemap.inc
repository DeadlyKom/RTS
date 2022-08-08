
                ifndef _CONST_TILEMAP_
                define _CONST_TILEMAP_

                define TilemapSetPage SetPage1

                module Size
                module Tilemap
Map:            EQU #2000                                                       ; максимально доступный размер для карты
Surface         EQU 0x100                                                       ; размер свойств тайлов (128 свободно)
AdrTable        EQU #0100                                                       ; размер таблицы адресов тайлов

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
Surface         EQU Map + Size.Tilemap.Map                                      ; адрес свойств тайлов
AdrTable        EQU Surface + Size.Tilemap.Surface                              ; адрес таблицы адресов тайлов

SpriteTable:    EQU MemBank_03_                                                 ; адрес таблицы + спрайтов тайловой карты

                endmodule
                endmodule

                endif ; ~_CONST_TILEMAP_
