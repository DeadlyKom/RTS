
                ifndef _MODULE_GAME_LOOP_
                define _MODULE_GAME_LOOP_
; -----------------------------------------
; игровой цикл
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
GameLoop:       SHOW_BASE_SCREEN

.Loop           CHECK_RENDER_FLAG FINISHED_BIT
                CALL Z, Render.Level
                JP .Loop

                endif ; ~_MODULE_GAME_LOOP_
