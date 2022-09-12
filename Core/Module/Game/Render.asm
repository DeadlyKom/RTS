
                ifndef _MODULE_GAME_RENDER_
                define _MODULE_GAME_RENDER_

                module Render
; -----------------------------------------
; отображение игрового уровня 
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Level:          SET_SCREEN_SHADOW

                CALL DrawTileRows
                CALL Functions.ShiftRenderBuf

                SET_RENDER_FLAG FINISHED_BIT                                    ; установка флага завершения отрисовки

                ifdef _DEBUG
                CALL FPS_Counter.Frame
                endif
                
                RET

; -----------------------------------------
; смена экранов 
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Swap:           ifdef _DEBUG
                CALL FPS_Counter.Render
                endif

                JP SwapScreens

                endmodule

                endif ; ~_MODULE_GAME_RENDER_
