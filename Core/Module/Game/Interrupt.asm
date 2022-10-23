
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
.RestoreCursor  ;  ********** Restore Cursor **********
                CHECK_RENDER_FLAG RESTORE_CURSOR_BIT
                CALL NZ, Render.RestoreCursor

.Input          ; ************ Scan Input ************
                CALL Input.Gameplay.Scan

.AnimTiles      ; ********** Animation Tiles **********
                LD HL, GameVar.TilemapCountdown
                DEC (HL)
                CALL Z, Functions.AnimTile

.AnimFlying     ; ********** Animation Flying **********
                LD HL, GameVar.FlyingCountdown
                DEC (HL)
                CALL Z, Functions.MoveUnitsCurve

.SwapScreens    ; ************ Swap Screens ************
                POP_RENDER_FLAG FINISHED_BIT
                CALL NZ, Render.Swap

.DrawCursor     ; ************ Draw Cursor ************
                CALL Render.DrawCursor                                          ; ВАЖНО: отображение курсора всегда должен вызываться после функции SwapScreens
                                                                                ;        и в текущем видимом окне.

                ifdef _DEBUG
.Debug_FPS      ; ************** Draw FPS **************
                CALL FPS_Counter.Tick
                endif

                RET

                endif ; ~ _CORE_MODULE_GAME_INTERRUPT_
