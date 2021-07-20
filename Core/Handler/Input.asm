
                ifndef _CORE_HANDLER_INPUT_
                define _CORE_HANDLER_INPUT_

                module Input

                include "../Structure/Input.inc"

Initialize:     ;
                CALL Mouse.Initialize
                CALL NC, Game.HardwareRestriction.Mouse
                RET

ScanKeyboard:   ; select
                ; LD A, VK_LBUTTON
                ; CALL CheckKeyState
                ; CALL Z, Tilemap.ResetFog
                LD DE, InputMouseMode
                CALL JmpHandMouse

                
                LD DE, InputJoyMode
                CALL JmpHandJoy
                
                ; ; options
                ; LD A, VK_RBUTTON
                ; CALL CheckKeyState
                ; CALL Z, .SetVK

                LD DE, InputMode_0_9
                CALL JumpHandlerNum

                SetInputFlag ACCELERATE_CURSOR_FLAG

                LD A, VK_KEMPSTON_C
                CALL Input.CheckKeyState
                JR NZ, .SkipAccelerate
                ResetInputFlag ACCELERATE_CURSOR_FLAG
.SkipAccelerate
                LD HL, Mouse.AccelerateCursor
                LD DE, Mouse.DecelerateCursor
                JumpToFlag ACCELERATE_CURSOR_FLAG

                RET

ScanMoveMap:    ; save the current address of the visible area of the tilemap
                LD HL, (TilemapRef)
                LD (.CompareAddress), HL
                
                CALL KeyboardMove

                CheckHardwareFlag KEMPSTON_MOUSE_FLAG
                CALL Z, MouseMoveEdge

                CheckHardwareFlag KEMPSTON_JOY_BUTTON_3
                CALL Z, MouseMoveEdge

                ; comparison of current and previous address values
                LD HL, (TilemapRef)
.CompareAddress EQU $+1
                LD DE, #0000                   
                OR A
                SBC HL, DE
                CALL NZ, Tilemap.Prepare

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

KempstonJoyB3:  ; move cursor left
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
ScanMouse:      CheckHardwareFlag KEMPSTON_MOUSE_FLAG
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

KeyboardMove:   ; move with "SYMBOL SHIFT" key pressed
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

InputMode_0_9:  JR NZ, .Processing              ; skip released
.NotProcessing  SCF
                RET

.Processing     EX AF, AF'
                CP 01                           ; key 1
                JP Z, ToggleCollision
                CP 02                           ; key 2
                JP Z, GamePause
                CP 08                           ; key 8
                JP Z, ToggleSyncAI
                CP 09                           ; key 9
                JP Z, IncreaseAIFreq
                CP 00                           ; key 0
                JP Z, DecreaseAIFreq
                JR .NotProcessing
InputMouseMode: JR NZ, .Processing              ; skip released
.NotProcessing  SCF
                RET

.Processing     EX AF, AF'
                CP 01                           ; key VK_LBUTTON
                JP Z, Pathfinding
                ; CP 02                           ; key VK_RBUTTON
                ; JP Z, $
                ; CP 03                           ; key VK_MBUTTON
                ; JP Z, $

                JR .NotProcessing
InputJoyMode:   JR NZ, .Processing              ; skip released
.NotProcessing  SCF
                RET

.Processing     EX AF, AF'
                CP 01                           ; key VK_KEMPSTON_A
                JP Z, Pathfinding
                ; CP 02                           ; key VK_KEMPSTON_B
                CP 04                           ; key VK_KEMPSTON_START
                JP Z, GamePause

                JR .NotProcessing
Pathfinding:    CheckGameplayFlag PATHFINDING_FLAG              ; проверим что идёт процесс поиска пути
                JR Z, InputMouseMode.NotProcessing              ; указать что инпут необработан, если идёт поиск пути 
                ResetGameplayFlag (PATHFINDING_QUERY_FLAG | PATHFINDING_REQUEST_PLAYER_FLAG)
                ; exit, processed
                OR A
                RET
ToggleCollision: SwapDebugFlag DISPLAY_COLLISION_FLAG
                CALL Tilemap.Prepare
                ; exit, processed
                OR A
                RET
ToggleSyncAI:   SwapAIFlag AI_SYNC_UPDATE_FLAG
                ; exit, processed
                OR A
                RET
IncreaseAIFreq: LD HL, AI_UpdateFrequencyRef
                LD A, AI_MIN_UPDATE_FREQ
                CP (HL)
                RET Z
                DEC (HL)
                ; exit, processed
                OR A
                RET
DecreaseAIFreq: LD HL, AI_UpdateFrequencyRef
                LD A, AI_MAX_UPDATE_FREQ
                CP (HL)
                RET Z
                INC (HL)
                ; exit, processed
                OR A
                RET
GamePause:      SwapAIFlag GAME_PAUSE_FLAG
                ; exit, processed
                OR A
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
JumpHandlerKey: CALL Input.CheckKeyState
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
JmpHandJoy:     LD HL, .KeyLastState
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
.KeyLastState   DS 4, 0
.ArrayVKNum     DB VK_KEMPSTON_A, 1
                DB VK_KEMPSTON_B, 2
                DB VK_KEMPSTON_C, 3
                DB VK_KEMPSTON_START, 4
.Num            EQU ($-.ArrayVKNum) / 2

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
JmpHandMouse:   LD HL, .KeyLastState
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
.KeyLastState   DS 2, 0
.ArrayVKNum     DB VK_LBUTTON, 1
                DB VK_RBUTTON, 2
                ; DB VK_MBUTTON, 3
.Num            EQU ($-.ArrayVKNum) / 2

                endmodule

                endif ; ~_CORE_HANDLER_INPUT_
