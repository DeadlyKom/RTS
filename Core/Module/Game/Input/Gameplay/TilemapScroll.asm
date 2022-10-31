
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
                ; проверки возможности скролла
                ; -----------------------------------------

                ; проверка завершения задержки
                LD HL, .TickCounter
                DEC (HL)
                RET P
                INC (HL)

                ; проверка готовности кадра
                ; т.к. скроллл карты не возможен во время отрисовки
                CHECK_RENDER_FLAG_A FINISHED_BIT
                RET Z                                                           ; выход если фрейм не готов

.SetDelay       ; установка задержки для скролла
                LD A, (GameConfig.SpeedTilemapScroll)
                LD (HL), A

.Scroll         ; -----------------------------------------
                ; проверка скролла карты по границам экрана
                ; -----------------------------------------

                ; CheckTilemapFlag ACCELERATE_CURSOR_FLAG
                ; RET Z

                ; сброс флагов скролла
                XOR A
                LD (GameFlags.ScrollFlagsRef), A

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

                RET

.TickCounter    DB #00

                endif ; ~_MODULE_GAME_INPUT_GAMEPLAY_TILEMAP_SCREOLL_
