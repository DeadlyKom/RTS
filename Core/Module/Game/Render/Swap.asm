
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

                LD DE, SortBuffer
                CALL Functions.VisibleUnits                                     ; получение массив видимых юнитов (отсортерован по вертикали)
                LD A, D
                LD (DrawUnits.Array), A

                JP Screen.Swap
 
                endif ; ~_MODULE_GAME_RENDER_SWAP_SCREEN_
