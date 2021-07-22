
                    ifndef _CORE_HANDLER_INPUT_
                    define _CORE_HANDLER_INPUT_

                    module Input

                    include "../Structure/Input.inc"

Initialize:         CALL Mouse.Initialize
                    CALL NC, Game.HardwareRestriction.Mouse
                    RET

ScanKeyboard:       ; переключение инпута в зависимости от флага
                    LD HL, Handlers.GamePause.ScanKeyboard
                    LD DE, Handlers.Gameplay.ScanKeyboard
                    JumpToGameplayFlag SHOW_PAUSE_MENU_GAME_FLAG
                    RET
ScanMoveMap:        ; save the current address of the visible area of the tilemap
                    LD HL, (TilemapRef)
                    LD (.CompareAddress), HL
                    
                    CALL KeyboardMove

                    CheckHardwareFlag KEMPSTON_MOUSE_FLAG
                    CALL Z, MouseMoveEdge

                    CheckHardwareFlag KEMPSTON_JOY_BUTTON_3
                    CALL Z, MouseMoveEdge

                    ; comparison of current and previous address values
                    LD HL, (TilemapRef)
.CompareAddress     EQU $+1
                    LD DE, #0000                   
                    OR A
                    SBC HL, DE
                    CALL NZ, Tilemap.Prepare

                    RET

; перемещение, классическое
MouseMoveEdge:      LD BC, MousePositionRef
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
KeyboardCursor:     ; move with "SYMBOL SHIFT" key released
                    LD A, VK_SYMBOL_SHIFT
                    CALL Input.CheckKeyState
                    RET Z

                    ; move cursor left
                    LD A, VK_A
                    CALL Input.CheckKeyState
                    CALL Z, Mouse.MoveLeft

                    ; move cursor right
                    LD A, VK_D
                    CALL Input.CheckKeyState
                    CALL Z, Mouse.MoveRight

                    ; move cursor up
                    LD A, VK_W
                    CALL Input.CheckKeyState
                    CALL Z, Mouse.MoveUp

                    ; move cursor down
                    LD A, VK_S
                    CALL Input.CheckKeyState
                    CALL Z, Mouse.MoveDown

                    RET
KempstonJoyB3:      ; move cursor left
                    LD A, VK_KEMPSTON_LEFT
                    CALL Input.CheckKeyState
                    CALL Z, Mouse.MoveLeft

                    ; move cursor right
                    LD A, VK_KEMPSTON_RIGHT
                    CALL Input.CheckKeyState
                    CALL Z, Mouse.MoveRight

                    ; move cursor up
                    LD A, VK_KEMPSTON_UP
                    CALL Input.CheckKeyState
                    CALL Z, Mouse.MoveUp

                    ; move cursor down
                    LD A, VK_KEMPSTON_DOWN
                    CALL Input.CheckKeyState
                    CALL Z, Mouse.MoveDown

                    RET
ScanMouse:          CheckHardwareFlag KEMPSTON_MOUSE_FLAG
                    CALL Z, Mouse.UpdateStatesMouse
                    
                    CALL KeyboardCursor

                    CheckHardwareFlag KEMPSTON_JOY_BUTTON_3
                    CALL Z, KempstonJoyB3

                    ;----
                    ; LD HL, #6080
                    ; LD DE, (MousePositionRef)
                    ; CALL DrawLine
                    ;----

                    RET
KeyboardMove:       ; move with "SYMBOL SHIFT" key pressed
                    LD A, VK_SYMBOL_SHIFT
                    CALL Input.CheckKeyState
                    RET NZ

                    ; move map left
                    LD A, VK_A
                    CALL Input.CheckKeyState
                    CALL Z, Tilemap.MoveLeft

                    ; move map right
                    LD A, VK_D
                    CALL Input.CheckKeyState
                    CALL Z, Tilemap.MoveRight

                    ; move map up
                    LD A, VK_W
                    CALL Input.CheckKeyState
                    CALL Z, Tilemap.MoveUp

                    ; move map down
                    LD A, VK_S
                    CALL Input.CheckKeyState
                    CALL Z, Tilemap.MoveDown

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
JumpHandlerKey:     CALL Input.CheckKeyState
                    LD A, (HL)
                    JR NZ, .IsReleased
                    OR A
                    JR NZ, .NotProcessed
                    INC (HL)
                    EX DE, HL
                    JP (HL)                             ; pressed
.IsReleased         OR A
                    JR Z, .NotProcessed
                    DEC (HL)
                    EX DE, HL
                    JP (HL)                             ; released
.NotProcessed       SCF
                    RET

; -----------------------------------------
; VK_1 - VK_0
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
JumpHandlerNum:     LD HL, .KeyLastState
                    EXX
                    LD DE, .ArrayVKNum
                    LD B, .Num
.Loop               LD A, (DE)
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
.KeyLastState       DS 10, 0
.ArrayVKNum         DB VK_0, 0
                    DB VK_1, 1
                    DB VK_2, 2
                    DB VK_3, 3
                    DB VK_4, 4
                    DB VK_5, 5
                    DB VK_6, 6
                    DB VK_7, 7
                    DB VK_8, 8
                    DB VK_9, 9
.Num                EQU ($-.ArrayVKNum) / 2

; -----------------------------------------
; VK_CAPS_SHIFT - VK_SPACE
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
JumpHandlerCH_SP:   LD HL, .KeyLastState
                    EXX
                    LD DE, .ArrayVKNum
                    LD B, .Num
.Loop               LD A, (DE)
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
.KeyLastState       DS 10, 0
.ArrayVKNum         DB VK_CAPS_SHIFT, 0
                    DB VK_Z, 1
                    DB VK_X, 2
                    DB VK_C, 3
                    DB VK_V, 4
                    DB VK_B, 5
                    DB VK_N, 6
                    DB VK_M, 7
                    DB VK_SYMBOL_SHIFT, 8
                    DB VK_SPACE, 9
.Num                EQU ($-.ArrayVKNum) / 2

; -----------------------------------------
; VK_KEMPSTON_A - VK_KEMPSTON_START
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
JmpHandJoy:         LD HL, .KeyLastState
                    EXX
                    LD DE, .ArrayVKNum
                    LD B, .Num
.Loop               LD A, (DE)
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
.KeyLastState       DS 4, 0
.ArrayVKNum         DB VK_KEMPSTON_A, 1
                    DB VK_KEMPSTON_B, 2
                    DB VK_KEMPSTON_C, 3
                    DB VK_KEMPSTON_START, 4
.Num                EQU ($-.ArrayVKNum) / 2

; -----------------------------------------
; VK_LBUTTON - VK_RBUTTON
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
JmpHandMouse:       LD HL, .KeyLastState
                    EXX
                    LD DE, .ArrayVKNum
                    LD B, .Num
.Loop               LD A, (DE)
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
.KeyLastState       DS 2, 0
.ArrayVKNum         DB VK_LBUTTON, 1
                    DB VK_RBUTTON, 2
                    ; DB VK_MBUTTON, 3
.Num                EQU ($-.ArrayVKNum) / 2

                    endmodule

                    endif ; ~_CORE_HANDLER_INPUT_
