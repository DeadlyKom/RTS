
                ifndef _MODULE_GAME_LOOP_
                define _MODULE_GAME_LOOP_
; -----------------------------------------
; игровой цикл
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
GameLoop:       SET_SCREEN_SHADOW

.Loop           CHECK_RENDER_FLAG FINISHED_BIT
                CALL Z, Render
                JP .Loop

                endif ; ~_MODULE_GAME_LOOP_
