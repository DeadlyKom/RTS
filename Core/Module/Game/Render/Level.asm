
                ifndef _MODULE_GAME_RENDER_LEVEL_
                define _MODULE_GAME_RENDER_LEVEL_
; -----------------------------------------
; отображение игрового уровня
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Level:          SET_SCREEN_SHADOW

                CALL DrawTileRows
                CALL DrawUnits

                SET_RENDER_FLAG FINISHED_BIT                                    ; установка флага завершения отрисовки

                ifdef _DEBUG
                CALL FPS_Counter.Frame
                endif
                
                RET

                endif ; ~_MODULE_GAME_RENDER_LEVEL_
