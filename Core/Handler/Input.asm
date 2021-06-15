
                ifndef _CORE_HANDLER_INPUT_
                define _CORE_HANDLER_INPUT_

                module Input

KeyStackSize    EQU 5

                include "../Structure/Input.inc"

Initialize:     ;
                CALL Mouse.Initialize
                CALL NC, Game.HardwareRestriction.Mouse
                RET

ScanKeyboard:   ; select
                ; LD A, VK_LBUTTON
                ; CALL CheckKeyState
                ; CALL Z, Tilemap.ResetFog

                ; ; options
                ; LD A, VK_RBUTTON
                ; CALL CheckKeyState
                ; CALL Z, .SetVK

                LD DE, InputMode_0_9
                CALL JumpHandlerNum

                RET

ScanMoveMap:    ; save the current address of the visible area of the tilemap
                LD HL, (TilemapRef)
                LD (.CompareAddress), HL
                
                CALL KeyboardMove
                CheckHardwareFlag KEMPSTON_MOUSE
                CALL NZ, MouseMoveEdge

                ; comparison of current and previous address values
                LD HL, (TilemapRef)
.CompareAddress EQU $+1
                LD DE, #0000                   
                OR A
                SBC HL, DE
                CALL NZ, Tilemap.Prepare
                ; CALL Game.Test

                RET

; перемещение, классическое
MouseMoveEdge:  LD BC, MousePositionRef
                LD A, (BC)
                CP #04
                CALL C, Tilemap.MoveLeft
                LD A, (BC)
                CP #FC
                CALL NC, Tilemap.MoveRight
                INC BC
                LD A, (BC)
                CP #04
                CALL C, Tilemap.MoveUp
                LD A, (BC)
                CP #BC
                CALL NC, Tilemap.MoveDown
                RET

KeyboardCursor: ; move with "SYMBOL SHIFT" key released
                LD A, VK_SYMBOL_SHIFT
                CALL CheckKeyState
                RET Z

                ; move map left
                LD A, VK_A
                CALL CheckKeyState
                CALL Z, Mouse.MoveLeft

                ; move map right
                LD A, VK_D
                CALL CheckKeyState
                CALL Z, Mouse.MoveRight

                ; move map up
                LD A, VK_W
                CALL CheckKeyState
                CALL Z, Mouse.MoveUp

                ; move map down
                LD A, VK_S
                CALL CheckKeyState
                CALL Z, Mouse.MoveDown

                RET
ScanMouse:      CheckHardwareFlag KEMPSTON_MOUSE
                CALL NZ, Mouse.UpdateStatesMouse
                CALL KeyboardCursor

                ;----
                ; LD HL, #6080
                ; LD DE, (MousePositionRef)
                ; CALL DrawLine
                ;----

                RET

KeyboardMove:   ; move with "SYMBOL SHIFT" key pressed
                LD A, VK_SYMBOL_SHIFT
                CALL CheckKeyState
                RET NZ

                ; move map left
                LD A, VK_A
                CALL CheckKeyState
                CALL Z, Tilemap.MoveLeft

                ; move map right
                LD A, VK_D
                CALL CheckKeyState
                CALL Z, Tilemap.MoveRight

                ; move map up
                LD A, VK_W
                CALL CheckKeyState
                CALL Z, Tilemap.MoveUp

                ; move map down
                LD A, VK_S
                CALL CheckKeyState
                CALL Z, Tilemap.MoveDown

                RET

InputMode_0_9:  JR Z, .Processing               ; skip released
.NotProcessing  SCF
                RET

.Processing     EX AF, AF'
                CP 01                           ; key 1
                JR NZ, .NotProcessing
                SwapDebugFlag DISPLAY_COLLISION_FLAG
                CALL Tilemap.Prepare
                ; exit, processed
                OR A
                RET

CheckKeyState:  PUSH HL
                LD HL, .RET
                LD (.VK), A
                OR A
                JP M, Mouse.CheckKeyState
                JP P, Keyboard.CheckKeyState
.VK             EQU $+1
.RET            LD A, #00
                POP HL
                RET

; -----------------------------------------
; In :
;   A  - virtual code
;   BC - virtual code modifier keys (two)
;   HL - address key last state
;   DE - address key handlerKey
; Out :
;   if the specified key is pressed/released jump yo handler
;   if flag Z is reset, the button is released, otherwise it is pressed
; Corrupt :
;   HL, DE, BC, AF, AF'
; -----------------------------------------
JumpHandlerKey: CALL CheckKeyState
                LD A, (HL)
                JR NZ, .IsReleased
                OR A
                JR NZ, .NotProcessed
                INC (HL)
                EX DE, HL
                JP (HL)                             ; pressed
.IsReleased     OR A
                JR Z, .NotProcessed
                DEC (HL)
                EX DE, HL
                JP (HL)                             ; released
.NotProcessed   SCF
                RET

; -----------------------------------------
; In :
;   DE - address key handlerKey
; Out :
;   if the specified key is pressed/released jump yo handler
;   if flag Z is reset, the button is released, otherwise it is pressed
;   if the handler is processing should return a reset Carry flag
;   C - value
; Corrupt :
;   HL, DE, BC, AF, AF'
; -----------------------------------------
JumpHandlerNum: LD HL, .KeyLastState
                EXX
                LD DE, .ArrayVKNum
                LD B, .Num
.Loop           LD A, (DE)
                INC DE
                EX AF, AF'
                LD A, (DE)
                INC DE
                EXX
                LD C, A
                EX AF, AF'
                PUSH HL
                PUSH DE
                CALL JumpHandlerKey
                POP DE
                POP HL
                RET NC
                INC HL
                EXX
                DJNZ .Loop
                RET
.KeyLastState   DS 10, 0
.ArrayVKNum     DB VK_0, 0
                DB VK_1, 1
                DB VK_2, 2
                DB VK_3, 3
                DB VK_4, 4
                DB VK_5, 5
                DB VK_6, 6
                DB VK_7, 7
                DB VK_8, 8
                DB VK_9, 9
.Num            EQU ($-.ArrayVKNum) / 2

                endmodule

                endif ; ~_CORE_HANDLER_INPUT_
