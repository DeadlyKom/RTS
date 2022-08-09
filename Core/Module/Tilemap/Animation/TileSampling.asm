
                ifndef _MODULE_TILEMAP_ANIMATION_TILE_SAMPLING_
                define _MODULE_TILEMAP_ANIMATION_TILE_SAMPLING_
; -----------------------------------------
; выборка тайла участка карты находящиеся в рендер буфере
; In:
; Out:
;   A  - количество анимаций тайла
;   A' - смещение в буфере найденого тайла
;   флаг переполнения Carry сброшен при успешном поиске анимированного тайла
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
                EX AF, AF'                                                      ; сохранение смещения в буфере

                ; проверка, что тайл обновлён
                LD A, (HL)
                ADD A, A
                RET C                                                           ; выход, если ячейка ранее не обработана

                INC H                                                           ; TilemapBuffer

                ; проверка, что тайл анимируемый
                CALL Surface.GetProperty
                ADD A, A
                RET C                                                           ; выход, если тайл не анимируемый

                ; чтение дополнительных данных свойств
                SET 7, L
                LD A, (HL)
                AND %00000011
                
                RET

                display " - Tile Sampling : \t\t", /A, TileSampling, " = busy [ ", /D, $ - TileSampling, " bytes  ]"

                endif ; ~_MODULE_TILEMAP_ANIMATION_TILE_SAMPLING_