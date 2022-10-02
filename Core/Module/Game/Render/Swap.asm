
                ifndef _MODULE_GAME_RENDER_SWAP_SCREEN_
                define _MODULE_GAME_RENDER_SWAP_SCREEN_
; -----------------------------------------
; смена экранов 
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Swap:           ; set update all visible screen
                LD HL, RenderBuffer + 0xC0
                LD DE, #8383
                CALL SafeFill.b192
                
                ifdef _DEBUG
                CALL FPS_Counter.Render
                endif

                JP Screen.Swap
 
                endif ; ~_MODULE_GAME_RENDER_SWAP_SCREEN_
