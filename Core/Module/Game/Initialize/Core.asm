
                ifndef _MODULE_GAME_INITIALIZE_CORE_
                define _MODULE_GAME_INITIALIZE_CORE_
; -----------------------------------------
; инициализация ядра
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Core:           ; -----------------------------------------
                ; инициализация видимой части карты
                ; -----------------------------------------
                ; копирование видимой части тайловой карты в буфер
                LD HL, (GameVar.TilemapCachedAdr)
                CALL Functions.MemcpyTilemap

                ; ; set update all visible screen
                LD HL, RenderBuffer + 0xC0
                LD DE, #8383
                CALL SafeFill.b192

                ; -----------------------------------------
                ; очистка экранов
                ; -----------------------------------------
                ; подготовка экрана 1
                CLS_4000
                ATTR_4000_IPB BLACK, WHITE, 0

                ; подготовка экрана 2
                SET_SCREEN_SHADOW
                CLS_C000
                ATTR_C000_IPB BLACK, WHITE, 0

                ; бордюр белого цвета
                BORDER WHITE
                
                ; -----------------------------------------
                ; инициализация обработчика прерываний
                ; -----------------------------------------
                SetUserHendler Game.Interrupt

                RET

                endif ; ~_MODULE_GAME_INITIALIZE_CORE_
