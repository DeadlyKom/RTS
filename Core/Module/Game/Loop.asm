
                ifndef _MODULE_GAME_LOOP_
                define _MODULE_GAME_LOOP_
; -----------------------------------------
; игровой цикл
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
GameLoop:       
.Loop           CALL DrawTileRows
                JP .Loop

                endif ; ~_MODULE_GAME_LOOP_
