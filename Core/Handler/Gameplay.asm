
                    ifndef _CORE_HANDLER_GAMEPLAY_
                    define _CORE_HANDLER_GAMEPLAY_

                    module Gameplay
ScanKeyboard:       CheckHardwareFlag KEMPSTON_MOUSE_FLAG
                    JR NZ, .SkipInputMouse
                    LD DE, InputMouseMode
                    CALL Handlers.Input.JmpHandMouse

.SkipInputMouse     ; ---------------------------------

                    CheckHardwareFlag KEMPSTON_JOY_BUTTON_3
                    JR NZ, .SkipInputJoy
                    LD DE, InputJoyMode
                    CALL Handlers.Input.JmpHandJoy

                    SetInputFlag ACCELERATE_CURSOR_FLAG

                    LD A, VK_KEMPSTON_C
                    CALL Input.CheckKeyState
                    JR NZ, .SkipAccelerate
                    ResetInputFlag ACCELERATE_CURSOR_FLAG
.SkipAccelerate
                    LD HL, Mouse.AccelerateCursor
                    LD DE, Mouse.DecelerateCursor
                    JumpToInputFlag ACCELERATE_CURSOR_FLAG

.SkipInputJoy       ; ---------------------------------

                    LD DE, InputMode_0_9
                    CALL Handlers.Input.JumpHandlerNum

                    LD DE, InputMode_CH_SP
                    CALL Handlers.Input.JumpHandlerCH_SP

                    RET

                    ; ***** InputMouseMode *****
InputMouseMode:     JR NZ, .Processing              ; skip released
.NotProcessing      SCF
                    RET

.Processing         EX AF, AF'
                    CP 01                           ; key VK_LBUTTON
                    JP Z, Pathfinding
                    ; CP 02                           ; key VK_RBUTTON
                    ; JP Z, $
                    ; CP 03                           ; key VK_MBUTTON
                    ; JP Z, $
                    JR .NotProcessing

                    ; ***** InputJoyMode *****
InputJoyMode:       JR NZ, .Processing              ; skip released
.NotProcessing      SCF
                    RET

.Processing         EX AF, AF'
                    CP 01                           ; key VK_KEMPSTON_A
                    JP Z, Pathfinding
                    ; CP 02                           ; key VK_KEMPSTON_B
                    CP 04                           ; key VK_KEMPSTON_START
                    JP Z, MenuGamePause
                    JR .NotProcessing
Pathfinding:        CheckGameplayFlag PATHFINDING_FLAG              ; проверим что идёт процесс поиска пути
                    JR Z, InputMouseMode.NotProcessing              ; указать что инпут необработан, если идёт поиск пути 
                    ResetGameplayFlag (PATHFINDING_QUERY_FLAG | PATHFINDING_REQUEST_PLAYER_FLAG)
                    ; exit, processed
                    OR A
                    RET

                    ; ***** InputMode_0_9 *****
InputMode_0_9:      JR NZ, .Processing              ; skip released
.NotProcessing      SCF
                    RET

.Processing         EX AF, AF'
                    CP 01                           ; key 1
                    JP Z, ToggleCollision
                    CP 02                           ; key 2
                    JP Z, AIPause
                    CP 03                           ; key 3
                    JP Z, MenuGamePause
                    CP 08                           ; key 8
                    JP Z, ToggleSyncAI
                    CP 09                           ; key 9
                    JP Z, IncreaseAIFreq
                    CP 00                           ; key 0
                    JP Z, DecreaseAIFreq
                    JR .NotProcessing
ToggleCollision:    SwapDebugFlag DISPLAY_COLLISION_FLAG
                    CALL Tilemap.Prepare
                    ; exit, processed
                    OR A
                    RET
ToggleSyncAI:       SwapAIFlag AI_SYNC_UPDATE_FLAG
                    ; exit, processed
                    OR A
                    RET
IncreaseAIFreq:     LD HL, AI_UpdateFrequencyRef
                    LD A, AI_MIN_UPDATE_FREQ
                    CP (HL)
                    RET Z
                    DEC (HL)
                    ; exit, processed
                    OR A
                    RET
DecreaseAIFreq:     LD HL, AI_UpdateFrequencyRef
                    LD A, AI_MAX_UPDATE_FREQ
                    CP (HL)
                    RET Z
                    INC (HL)
                    ; exit, processed
                    OR A
                    RET
AIPause:            SwapAIFlag GAME_PAUSE_FLAG
                    ; exit, processed
                    OR A
                    RET

MenuGamePause:      ResetGameplayFlag ACTIVATE_PAUSE_MENU_GAME_FLAG     ; активация меню паузы игры
                    ; exit, processed
                    OR A
                    RET

                    ; **** InputMode_CH_SP *****
InputMode_CH_SP:    JR NZ, .Processing              ; skip released
.NotProcessing      SCF
                    RET

.Processing         EX AF, AF'
                    CP 09                           ; VK_SPACE
                    JP Z, Pathfinding
                    JR .NotProcessing

                    endmodule

                    endif ; ~_CORE_HANDLER_GAMEPLAY_
