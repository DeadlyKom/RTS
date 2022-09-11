
                ifndef _MODULE_GAME_RENDER_
                define _MODULE_GAME_RENDER_
; -----------------------------------------
; отображение 
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Render:         CALL DrawTileRows
                CALL Functions.ShiftRenderBuf

                SET_RENDER_FLAG FINISHED_BIT                                    ; установка флага завершения отрисовки
                
                RET

                endif ; ~_MODULE_GAME_RENDER_
