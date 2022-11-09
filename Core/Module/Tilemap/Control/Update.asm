
                ifndef _CORE_MODULE_TILEMAP_UPDATE_BUFFERS_
                define _CORE_MODULE_TILEMAP_UPDATE_BUFFERS_
; -----------------------------------------
; обновление карты, буферы тайловой карты и рендера 
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
UpdateTilemap   ; -----------------------------------------
                ; анимация тайлов
                ; -----------------------------------------
                LD HL, Tilemap.Countdown
                DEC (HL)
                CALL Z, AnimTile

                ; -----------------------------------------
                ; проверка готовности кадра
                ; -----------------------------------------
                CHECK_RENDER_FLAG FINISHED_BIT
                RET Z                                                           ; выход, если фрейм не готов
                RES_RENDER_FLAG FINISHED_BIT                                    ; обнуление флага FINISHED_BIT (вместо POP_RENDER_FLAG)

                ; -----------------------------------------
                ; проверка скроллирования карты
                ; -----------------------------------------
                LD A, (GameFlags.ScrollFlagsRef)
                OR A
                JR Z, .Shift                                                    ; переход, если скролл не произведён

                ; -----------------------------------------
                ; обновление всей карты
                ; -----------------------------------------
                ; копирование видимой части тайловой карты в буфер
                LD HL, (Tilemap.CachedAddress)
                CALL Memcpy.Buffer

                ; принудительное обновление всего экрана
                LD HL, RenderBuffer + 0xC0
                LD DE, #8383
                CALL SafeFill.b192

                ; очистка буфера анимации тайлов
                LD HL, AnimTile.Array
                LD DE, AnimTile.Array+1
                LD (HL), #FF
                rept ANIMATED_TILES
                LDI
                endr
                LD (HL), -ANIMATED_TILES

.Shift          ; -----------------------------------------
                ; сдвиг очереди отображения в буфере отображения
                ; -----------------------------------------
                ; JP ShiftRenderBuf

                display " - Update Tilemap Buffers: \t\t\t\t", /A, UpdateTilemap, " = busy [ ", /D, $ - UpdateTilemap, " bytes  ]"

                endif ; ~ _CORE_MODULE_TILEMAP_UPDATE_BUFFERS_
