
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
.AnimTiles      ; ******* Animation Tiles *******
                LD HL, Tilemap.Animation.Countdown
                DEC (HL)
                CALL Z, Functions.AnimTile

                RET

                endif ; ~ _CORE_MODULE_GAME_INTERRUPT_
