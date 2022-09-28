
                ifndef _CORE_MODULE_GAME_INTERRUPT_
                define _CORE_MODULE_GAME_INTERRUPT_
; -----------------------------------------
; обработчик прерывания игры
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Interrupt:      
.Mouse          ; ToDo: вынести в отдельную обновлениея инпута
                CALL Mouse.UpdateCursor

.AnimTiles      ; ********** Animation Tiles **********
                LD HL, GameVar.TilemapCountdown
                DEC (HL)
                CALL Z, Functions.AnimTile

.SwapScreens    ; ********** Swap Screens **********
                POP_RENDER_FLAG FINISHED_BIT
                CALL NZ, Render.Swap

                ifdef _DEBUG
.Debug_FPS      ; ********** Swap Screens **********
                CALL FPS_Counter.Tick
                endif

                RET

                endif ; ~ _CORE_MODULE_GAME_INTERRUPT_
