
                ifndef _CONST_TILEMAP_BUFFER_
                define _CONST_TILEMAP_BUFFER_
TilemapBuffer   EQU #BF00                                                       ; адрес буфера тайловой карты
TilemapBufSize  EQU 192                                                         ; размер тайлового буфера

; структура данных тайла
;
;      7    6    5    4    3    2    1    0
;   +----+----+----+----+----+----+----+----+
;   | WF | T2 | T1 | T0 | G3 | G2 | G1 | G0 |
;   +----+----+----+----+----+----+----+----+
;
;   WF      [7]     - флаг тумана войны
;   T2 - T0 [6..4]  - разновидность поверхности
;               000 - жидкая поверхность
;               001 - твёрдая поверхность
;               010 - высота/возвышенность
;               011 - 2х уровнева поверхность (2х проходный рендер)
;               100 - ...
;
;   G3 - G0 [3..0]  - тип графики (не для всех типов имеет смысл)
;
;   Все кроме старшего бита, являются ID тайла
;

TILE_ID_MASK    EQU %01111111

                endif ; ~_CONST_TILEMAP_BUFFER_