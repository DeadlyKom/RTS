
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


                SET_PAGE_UNIT                                                   ; включить страницу работы с юнитами

                LD IX, #C000
                UNIT_IsMove (IX + FUnit.State)
                JR Z, .L3                                                           ; выход, если шаттл не движется

; .L1             EQU $+1
;                 LD A, #01
;                 DEC A
;                 JR NZ, .L2
                
                CALL Math.BezierCurve
                INC (IX + FUnit.Animation)
                JR NZ, .L3
                UNIT_ResMoveTo (IX + FUnit.State)
.L3

;                 LD A, #01
; .L2             LD (.L1), A

                JP Screen.Swap
 
                endif ; ~_MODULE_GAME_RENDER_SWAP_SCREEN_
