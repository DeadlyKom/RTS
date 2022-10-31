
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
.DrawCursor     ; ************ Draw Cursor ************
                CALL Render.DrawCursor

.SwapScreens    ; ************ Swap Screens ************
                CHECK_RENDER_FLAG FINISHED_BIT
                CALL NZ, Render.Swap

.Input          ; ************ Scan Input ************
                CALL Input.Gameplay.Scan

.Tilemap        ; ************** Tilemap **************
                CALL Functions.UpdateTilemap                                    ; обнуление флага FINISHED_BIT (вместо POP_RENDER_FLAG)

.AnimFlying     ; ********** Animation Flying **********
                LD HL, Game.FlyingCountdown
                DEC (HL)
                CALL Z, Functions.MoveUnitsCurve

                ifdef _DEBUG
.Debug_FPS      ; ************** Draw FPS **************
                CALL FPS_Counter.Tick
                endif

                RET

                endif ; ~ _CORE_MODULE_GAME_INTERRUPT_
