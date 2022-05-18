
                ifndef _CORE_MODULE_LOADER_SAVER_
                define _CORE_MODULE_LOADER_SAVER_
; -----------------------------------------
; заставка
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Saver:          ; бордюр чёрного цвета
                BORDER BLACK

                ; подготовка экрана
                CLS_4000
                ATTR_4000_IP WHITE, BLACK

                ; отрисовка надпись Loading
                LD HL, .LoadingSprAttr
                LD DE, SharedBuffer
                CALL Decompressor.Forward
                DrawSpriteATTR SharedBuffer, 2, 20, 8, 2

                ; отображение прогресса
                LD HL, .ProgressSprAttr
                LD DE, SharedBuffer
                CALL Decompressor.Forward
                DrawSpriteATTR SharedBuffer, 1, 22, 10, 1

                JR$
                RET
                
.LoadingSprAttr incbin "../../../Sprites/Menu/Loader/Compressed/Loading.ar.spr"
.ProgressSprAttr incbin "../../../Sprites/Menu/Loader/Compressed/Progress.ar.spr"

                endif ; ~ _CORE_MODULE_LOADER_SAVER_
