
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

.AnimTiles      ; ********** Animation Tiles **********
                LD HL, GameVar.TilemapCountdown
                DEC (HL)
                CALL Z, Functions.AnimTile

.AnimFlying     ; ********** Animation Flying **********
                LD HL, GameVar.FlyingCountdown
                DEC (HL)
                CALL Z, Functions.MoveUnitsCurve

                ifdef _DEBUG
.Debug_FPS      ; ************** Draw FPS **************
                CALL FPS_Counter.Tick
                endif

                RES_RENDER_FLAG FINISHED_BIT                                    ; обнуление флага FINISHED_BIT (вместо POP_RENDER_FLAG)

                RET

                endif ; ~ _CORE_MODULE_GAME_INTERRUPT_
