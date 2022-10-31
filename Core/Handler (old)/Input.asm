
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
                    
                    SetTilemapFlag CURSOR_EDGES_FLAGS                           ; очистка флагов граней такловой карты

                    CheckTilemapFlag ACCELERATE_CURSOR_FLAG
                    JR NZ, .SkipMove
                    
                    CheckHardwareFlag KEMPSTON_JOY_BUTTON_3
                    CALL Z, KempstonJoy3BMove

                    CALL KeyboardMove

.SkipMove           CALL CursorMoveEdge
                    CheckFrameFlag FORCE_FOW_FLAG
                    JR NZ, .L2
                    SetFrameFlag FORCE_FOW_FLAG
                    CALL  Tilemap.Prepare
                    RET
.L2
                    ; comparison of current and previous address values
                    LD HL, (TilemapRef)
.CompareAddress     EQU $+1
                    LD DE, #0000
                    OR A
                    SBC HL, DE
                    CALL NZ, Tilemap.Prepare

                    RET
KeyboardMove:       ; move map left
                    LD A, (VirtualKeyLeftRef)
                    CALL Input.CheckKeyState
                    CALL Z, Tilemap.MoveLeft

                    ; move map right
                    LD A, (VirtualKeyRightRef)
                    CALL Input.CheckKeyState
                    CALL Z, Tilemap.MoveRight

                    ; move map up
                    LD A, (VirtualKeyUpRef)
                    CALL Input.CheckKeyState
                    CALL Z, Tilemap.MoveUp

                    ; move map down
                    LD A, (VirtualKeyDownRef)
                    CALL Input.CheckKeyState
                    CALL Z, Tilemap.MoveDown

                    RET
KempstonJoy3BMove:  ; move map left
                    LD A, VK_KEMPSTON_LEFT
                    CALL Input.CheckKeyState
                    CALL Z, Tilemap.MoveLeft

                    ; move map right
                    LD A, VK_KEMPSTON_RIGHT
                    CALL Input.CheckKeyState
                    CALL Z, Tilemap.MoveRight

                    ; move map up
                    LD A, VK_KEMPSTON_UP
                    CALL Input.CheckKeyState
                    CALL Z, Tilemap.MoveUp

                    ; move map down
                    LD A, VK_KEMPSTON_DOWN
                    CALL Input.CheckKeyState
                    CALL Z, Tilemap.MoveDown

                    RET

; перемещение, классическое
CursorMoveEdge:     CheckTilemapFlag ACCELERATE_CURSOR_FLAG
                    RET Z
                    LD BC, CursorPositionRef
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
ScanCursor:         CheckHardwareFlag KEMPSTON_MOUSE_FLAG
                    CALL Z, Mouse.UpdateStatesMouse

                    CheckHardwareFlag KEMPSTON_JOY_BUTTON_3
                    CALL Z, KempstonJoy3B

                    CALL KeyboardCursor

                    RET
KempstonJoy3B:      ; move cursor left
                    LD A, VK_KEMPSTON_LEFT
                    CALL Input.CheckKeyState
                    JR NZ, .ReleasedLeft

                    CheckTilemapFlag ACCELERATE_CURSOR_FLAG
                    CALL NZ, Input.Cursor.MoveLeft
                    CheckTilemapFlag CURSOR_LEFT_EDGE_FLAG
                    CALL Z, Input.Cursor.MoveLeft

.ReleasedLeft       ; move cursor right
                    LD A, VK_KEMPSTON_RIGHT
                    CALL Input.CheckKeyState
                    JR NZ, .ReleasedRight

                    CheckTilemapFlag ACCELERATE_CURSOR_FLAG
                    CALL NZ, Input.Cursor.MoveRight
                    CheckTilemapFlag CURSOR_RIGHT_EDGE_FLAG
                    CALL Z, Input.Cursor.MoveRight

.ReleasedRight      ; move cursor up
                    LD A, VK_KEMPSTON_UP
                    CALL Input.CheckKeyState
                    JR NZ, .ReleasedUp

                    CheckTilemapFlag ACCELERATE_CURSOR_FLAG
                    CALL NZ, Input.Cursor.MoveUp
                    CheckTilemapFlag CURSOR_UP_EDGE_FLAG
                    CALL Z, Input.Cursor.MoveUp

.ReleasedUp         ; move cursor down
                    LD A, VK_KEMPSTON_DOWN
                    CALL Input.CheckKeyState
                    JR NZ, .ReleasedDown

                    CheckTilemapFlag ACCELERATE_CURSOR_FLAG
                    CALL NZ, Input.Cursor.MoveDown
                    CheckTilemapFlag CURSOR_DOWN_EDGE_FLAG
                    CALL Z, Input.Cursor.MoveDown

.ReleasedDown       RET

KeyboardCursor:     ; move cursor left
                    LD A, (VirtualKeyLeftRef)
                    CALL Input.CheckKeyState
                    JR NZ, .ReleasedLeft

                    CheckTilemapFlag ACCELERATE_CURSOR_FLAG
                    CALL NZ, Input.Cursor.MoveLeft
                    CheckTilemapFlag CURSOR_LEFT_EDGE_FLAG
                    CALL Z, Input.Cursor.MoveLeft

.ReleasedLeft       ; move cursor right
                    LD A, (VirtualKeyRightRef)
                    CALL Input.CheckKeyState
                    JR NZ, .ReleasedRight

                    CheckTilemapFlag ACCELERATE_CURSOR_FLAG
                    CALL NZ, Input.Cursor.MoveRight
                    CheckTilemapFlag CURSOR_RIGHT_EDGE_FLAG
                    CALL Z, Input.Cursor.MoveRight

.ReleasedRight      ; move cursor up
                    LD A, (VirtualKeyUpRef)
                    CALL Input.CheckKeyState
                    JR NZ, .ReleasedUp

                    CheckTilemapFlag ACCELERATE_CURSOR_FLAG
                    CALL NZ, Input.Cursor.MoveUp
                    CheckTilemapFlag CURSOR_UP_EDGE_FLAG
                    CALL Z, Input.Cursor.MoveUp

.ReleasedUp         ; move cursor down
                    LD A, (VirtualKeyDownRef)
                    CALL Input.CheckKeyState
                    JR NZ, .ReleasedDown

                    CheckTilemapFlag ACCELERATE_CURSOR_FLAG
                    CALL NZ, Input.Cursor.MoveDown
                    CheckTilemapFlag CURSOR_DOWN_EDGE_FLAG
                    CALL Z, Input.Cursor.MoveDown

.ReleasedDown       RET

; -----------------------------------------
; In :
;   A  - virtual code
;   ~~BC - virtual code modifier keys (two) ????~~
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
; jump to hendler keys
; In :
;   HL  - address key last state
;   DE' - address array VK
;   B'  - count array keys VK
; Out :
;   if the specified key is pressed/released jump yo handler
;   if flag Z is reset, the button is released, otherwise it is pressed
;   if the handler is processing should return a reset Carry flag
;   C - value
; Corrupt :
;   HL, DE, BC, AF, AF'
; -----------------------------------------
JumpHandlerKeys:    ;
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
                    JP JumpHandlerKeys
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
                    JP JumpHandlerKeys
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
                    JP JumpHandlerKeys
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
                    JP JumpHandlerKeys
.KeyLastState       DS 2, 0
.ArrayVKNum         DB VK_LBUTTON, 1
                    DB VK_RBUTTON, 2
                    ; DB VK_MBUTTON, 3
.Num                EQU ($-.ArrayVKNum) / 2


; Test:               ; JR$


;                     ; LD HL, .KeyTimeCounter
;                     ; LD DE, .ArrayPointers
;                     CALL Input.CheckKeyState    ;   флаг Z сброшен, если кнопка нажата
;                     LD A, (HL)
;                     JR NZ, .IsReleased

;                     ; нажатие кнопки
;                     OR A
;                     JR Z, .NotProcessed    ; выход т.к. производился вызов длиного нажатия
;                     DEC (HL)
;                     JR NZ, .NotProcessed    ; выход т.к. производится отсчёт времения длиного нажатия

;                     ; время истекло, считаем что произошло длиное нажатие
; .JumpLong           INC DE
;                     INC DE

; .JumpDE             EX DE, HL
;                     LD A, (HL)
;                     INC HL
;                     LD H, (HL)
;                     LD L, A
;                     JP (HL)                 ; long pressed

; .IsReleased         INC HL
;                     CP (HL)
;                     JR Z, .NotProcessed ; 
;                     ; установим дефолтное значение счётчика (запретим обработку длиного нажатия)
;                     LD C, (HL)
;                     DEC HL
;                     LD (HL), C

;                     OR A
;                     JR NZ, .JumpDE          ; short released

;                     ; long released
;                     INC DE
;                     INC DE

;                     JR .JumpLong

;                     ; EX DE, HL
;                     ; JP (HL)                             ; released
; .NotProcessed       SCF
;                     RET

; ; .KeyTimeCounter     DB #10
; ; .KeyTimerDefault    DB #10
; ; .ArrayPointers      DW #0000 ; short released
; ;                     DW #0000 ; long pressed
; ;                     DW #0000 ; long released

                    endmodule

                    endif ; ~_CORE_HANDLER_INPUT_
