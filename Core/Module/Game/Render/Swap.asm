
                ifndef _MODULE_GAME_RENDER_SWAP_SCREEN_
                define _MODULE_GAME_RENDER_SWAP_SCREEN_
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

                JP Screen.Swap
 
                endif ; ~_MODULE_GAME_RENDER_SWAP_SCREEN_
