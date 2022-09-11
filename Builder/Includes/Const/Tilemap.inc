
                ifndef _CONST_TILEMAP_
                define _CONST_TILEMAP_

                define TilemapSetPage SetPage1

                module Size
                module Tilemap
Map:            EQU #2000                                                       ; максимально доступный размер для карты
Surface         EQU 0x100                                                       ; размер свойств тайлов (128+128)
AdrTable        EQU #0100                                                       ; размер таблицы адресов тайлов
BypassFOW       EQU #0300                                                       ; размер таблицы обхода FOW

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

                ; страница 1
Map:            EQU MemBank_03                                                  ; адрес тайловой карты                      (0)
Surface         EQU Map + Size.Tilemap.Map                                      ; адрес свойств тайлов                      (1)
AdrTable        EQU Surface + Size.Tilemap.Surface                              ; адрес таблицы адресов тайлов              (2)

                ; страница 7
BypassFOW       EQU MemBank_03_                                                 ; адрес таблицы обхода FOW                  (0)
SpriteTable:    EQU BypassFOW + Size.Tilemap.BypassFOW                          ; адрес таблицы + спрайтов тайловой карты   (1)

                endmodule
                endmodule

                endif ; ~_CONST_TILEMAP_
