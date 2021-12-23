
                    ifndef _CORE_HANDLER_GAMEPLAY_
                    define _CORE_HANDLER_GAMEPLAY_

                    module Gameplay
ScanKeyboard:       SetTilemapFlag ACCELERATE_CURSOR_FLAG
                    
                    ; ; обновим положение начала рамки, если не начат выбор рамкой
                    ; CheckInputFlag SELECTION_RECT_FLAG
                    ; JR Z, $+8
                    ; LD HL, (CursorPositionRef)
                    ; LD (DrawRectangle.Start), HL

                    ; ; сбросим выбор рамкой
                    ; SetInputFlag SELECTION_RECT_FLAG

                    ; ---------------------------------

                    CheckHardwareFlag KEMPSTON_MOUSE_FLAG
                    JR NZ, .SkipInputMouse
                    
                    ; выбор рамкой
                    LD A, VK_LBUTTON
                    CALL Input.CheckKeyState
                    JR NZ, .SkipSelRectMouse
                    ResetInputFlag SELECTION_RECT_FLAG

.SkipSelRectMouse   ; обработка нажатий
                    LD DE, InputMouseMode
                    CALL Handlers.Input.JmpHandMouse

.SkipInputMouse     ; ---------------------------------

                    CheckHardwareFlag KEMPSTON_JOY_BUTTON_3
                    JR NZ, .SkipInputJoy

                    ; выбор рамкой
                    LD A, VK_KEMPSTON_A
                    CALL Input.CheckKeyState
                    JR NZ, .SkipSelRectJoy
                    ResetInputFlag SELECTION_RECT_FLAG

.SkipSelRectJoy     ; обработка нажатий
                    LD DE, InputJoyMode
                    CALL Handlers.Input.JmpHandJoy

                    LD A, VK_KEMPSTON_C
                    CALL Input.CheckKeyState
                    JR NZ, .SkipAccelerateJoy
                    ResetTilemapFlag ACCELERATE_CURSOR_FLAG
.SkipAccelerateJoy

.SkipInputJoy       ; ---------------------------------

                    LD DE, InputMode_0_9
                    CALL Handlers.Input.JumpHandlerNum

                    LD DE, InputMode_CH_SP
                    CALL Handlers.Input.JumpHandlerCH_SP

                    LD A, VK_SYMBOL_SHIFT
                    CALL Input.CheckKeyState
                    JR NZ, .SkipAccelerateKey
                    ResetTilemapFlag ACCELERATE_CURSOR_FLAG

.SkipAccelerateKey  ; ---------------------------------

                    RET

                    ; ***** InputMouseMode *****
InputMouseMode:     JR NZ, .Processing              ; skip released
                    EX AF, AF'
                    CP 01                           ; released key VK_LBUTTON
                    JP Z, ReleasSelecting
.NotProcessing      SCF
                    RET

.Processing         EX AF, AF'
                    CP 01                           ; key VK_LBUTTON
                    JP Z, PressSelecting
                    CP 02                           ; key VK_RBUTTON
                    JP Z, Pathfinding
                    ; CP 03                           ; key VK_MBUTTON
                    ; JP Z, $
                    JR .NotProcessing

                    ; ***** InputJoyMode *****
InputJoyMode:       JR NZ, .Processing              ; skip released
.NotProcessing      SCF
                    RET

.Processing         EX AF, AF'
                    ; CP 01                           ; key VK_KEMPSTON_A
                    ; JP Z, Pathfinding
                    CP 02                           ; key VK_KEMPSTON_B
                    JP Z, Pathfinding
                    ; CP 03                           ; key VK_KEMPSTON_С
                    ; JP Z, $
                    CP 04                           ; key VK_KEMPSTON_START
                    JP Z, MenuGamePause
                    JR .NotProcessing

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

MenuGamePause:      ResetGameplayFlag ACTIVATE_PAUSE_MENU_GAME_FLAG             ; активация меню паузы игры
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

                    ; **** ****
Pathfinding:        CheckInputFlag SELECTION_RECT_FLAG                          ; проверим что не происходит выбор рамкой
                    JP Z, InputMouseMode.NotProcessing                          ; указать что инпут необработан, если идёт поиск пути 
                    CheckGameplayFlag PATHFINDING_FLAG                          ; проверим что идёт процесс поиска пути
                    JP Z, InputMouseMode.NotProcessing                          ; указать что инпут необработан, если идёт поиск пути 
                    ResetGameplayFlag (PATHFINDING_QUERY_FLAG | PATHFINDING_REQUEST_PLAYER_FLAG)
                    ; exit, processed
                    OR A
                    RET

PressSelecting:     LD HL, (CursorPositionRef)
                    LD (DrawRectangle.Start), HL
                    ; exit, processed
                    OR A
                    RET
ReleasSelecting:    CALL Unit.ScanRectSelect
                    ; сбросим выбор рамкой
                    SetInputFlag SELECTION_RECT_FLAG
                    ; exit, processed
                    OR A
                    RET

                    endmodule

                    endif ; ~_CORE_HANDLER_GAMEPLAY_
