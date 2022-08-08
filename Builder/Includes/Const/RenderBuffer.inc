
                ifndef _CONST_RENDER_BUFFER_
                define _CONST_RENDER_BUFFER_
RenderBuffer    EQU #BE00                                                       ; адрес буфера обновлений   [64] заняты буфером выбора и WayPoint'ами
RenderBufSize   EQU 192                                                         ; размер рендер буфера
RenderBufPage   EQU 0x06                                                        ; страница

; структура данных рендер буфера
;
;      7    6    5    4    3    2    1    0
;   +----+----+----+----+----+----+----+----+
;   | V  | A2 | A1 | A0 | .. | .. | .. | UP |
;   +----+----+----+----+----+----+----+----+
;
;   V     - [7]     - флаг необхимости обновления тайла
;   A2-A0 - [6..4]  - номер анимации тайла
;   UP      [0]     - флаг, сверху находится что либо (для отражения)
;
RENDER_TILE_BIT EQU 0x07                                                        ; флаг необхимости обновления тайла (0 - необновлять, 1 - необходимо обновить)
RENDER_INC_BIT  EQU 0x04                                                        ; константное значение инкремента анимации тайла

RENDER_TILE     EQU 1 << RENDER_TILE_BIT
RENDER_INC      EQU 1 << RENDER_INC_BIT
TILE_ANIM_MASK  EQU %01110000                                                   ; маска номера анимации тайла

                endif ; ~_CONST_RENDER_BUFFER_
