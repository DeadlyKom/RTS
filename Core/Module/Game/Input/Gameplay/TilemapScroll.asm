
                ifndef _MODULE_GAME_INPUT_GAMEPLAY_TILEMAP_SCREOLL_
                define _MODULE_GAME_INPUT_GAMEPLAY_TILEMAP_SCREOLL_
; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
TilemapScroll:  ; -----------------------------------------
                ; проверки возможности скрола
                ; -----------------------------------------

                ; проверка завершения задержки
                LD HL, .TickCounter
                DEC (HL)
                RET P
                INC (HL)

                ; проверка готовности кадра
                ; т.к. скролл карты не возможен во время отрисовки
                CHECK_RENDER_FLAG_A FINISHED_BIT
                RET Z                                                           ; выход если фрейм не готов

.SetDelay       ; установка задержки для скрола
                LD A, (GameConfig.SpeedTilemapScroll)
                LD (HL), A

.Scroll         ; -----------------------------------------
                ; проверка скрола карты по границам экрана
                ; -----------------------------------------

                ; CheckTilemapFlag ACCELERATE_CURSOR_FLAG
                ; RET Z

                ; сохранить текущий адрес карты тайлов
                LD HL, (GameVar.TilemapCachedAdr)
                PUSH HL

                ; проверка нахожения курсора на границах экрана
                LD BC, Mouse.Position

                LD A, (BC)                                                      ; позиция корсора по горизонтали
                CP SCREEN_EDGE
                CALL C, Game.Tilemap.Move.Left

                LD A, (BC)
                CP SCREEN_PIXEL_X - SCREEN_EDGE
                CALL NC, Game.Tilemap.Move.Right

                INC BC

                LD A, (BC)                                                      ; позиция корсора по вертикали
                CP SCREEN_EDGE
                CALL C, Game.Tilemap.Move.Up

                LD A, (BC)
                CP SCREEN_PIXEL_Y - SCREEN_EDGE
                CALL NC, Game.Tilemap.Move.Down

                ; -----------------------------------------
                ; скролл тайловой карты
                ; -----------------------------------------

                ; сравнение текущего и предыдущего значений адреса
                LD HL, (GameVar.TilemapCachedAdr)
                POP DE
                OR A
                SBC HL, DE
                RET Z                                                           ; выход, если адрес не изменился

                ; копирование видимой части тайловой карты в буфер
                LD HL, (GameVar.TilemapCachedAdr)
                CALL Functions.MemcpyTilemap

                ; принудительное обновление всего экрана
                LD HL, RenderBuffer + 0xC0
                LD DE, #8383
                CALL SafeFill.b192
                RET
                ; JP Tilemap.TileUpdate

.TickCounter    DB #00

                endif ; ~_MODULE_GAME_INPUT_GAMEPLAY_TILEMAP_SCREOLL_
