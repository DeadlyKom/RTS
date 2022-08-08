
                ifndef _MODULE_TILEMAP_ANIMATION_TILE_SAMPLING_
                define _MODULE_TILEMAP_ANIMATION_TILE_SAMPLING_
; -----------------------------------------
; выборка тайла участка карты находящиеся в рендер буфере
; In:
; Out:
; Corrupt:
; Note:
;   код лежит в страничке карты
; -----------------------------------------
TileSampling:   ; рандомная выборка в пределах буфера
                CALL Math.Rand8
                LD D, A
                LD E, TilemapBufSize
                CALL Math.Div8x8

                ; адрес рандомной ячейки в рендер буфере
                LD H, HIGH RenderBuffer
                LD L, A

                ; проверка, что тайл обновлён
                LD A, (HL)
                ADD A, A
                RET C                                                           ; выход, если ячейка ранее не обработана

                INC H                                                           ; TilemapBuffer

                ; проверка, что тайл анимируемый
                CALL Surface.GetProperty


                RET

                display " - Tile Sampling : \t\t", /A, TileSampling, " = busy [ ", /D, $ - TileSampling, " bytes  ]"

                endif ; ~_MODULE_TILEMAP_ANIMATION_TILE_SAMPLING_