
                    ifndef _CORE_HANDLER_GAME_PAUSE_
                    define _CORE_HANDLER_GAME_PAUSE_

                    module GamePause
ScanKeyboard:       LD DE, InputMode_0_9
                    CALL Handlers.Input.JumpHandlerNum
                
                    RET

                    ; ***** InputMode_0_9 *****
InputMode_0_9:      JR NZ, .Processing              ; skip released
.NotProcessing      SCF
                    RET

.Processing         EX AF, AF'
                    CP 0                            ; key 0
                    JP Z, MenuGamePause
                    CP 1                            ; key 1 (Kempston mouse)
                    JP Z, ToggleKemMouse
                    CP 2                            ; key 2 (Kempston joystick)
                    JP Z, ToggleKemJoystick
                    CP 3                            ; key 3 (уменьшить скорость курсора)
                    JP Z, DecCursorSpeed
                    CP 4                            ; key 4 (увеличить скорость курсора)
                    JP Z, IncCursorSpeed
                    JR .NotProcessing
MenuGamePause:      CALL Hide
                    ; exit, processed
                    OR A
                    RET
ToggleKemMouse:     SwapHardwareFlag KEMPSTON_MOUSE_FLAG
                    CALL Console.SwitchScreen       ; switch screen log
                    CALL DrawGamePause
                    ; exit, processed
                    OR A
                    RET
ToggleKemJoystick:  SwapHardwareFlag KEMPSTON_JOY_BUTTON_3
                    CALL Console.SwitchScreen       ; switch screen log
                    CALL DrawGamePause
                    ; exit, processed
                    OR A
                    RET
DecCursorSpeed:     LD HL, MinCursorSpeedRef
                    DEC (HL)
                    CALL Mouse.InitAcceleration
                    CALL Console.SwitchScreen       ; switch screen log
                    CALL DrawGamePause
                    ; exit, processed
                    OR A
                    RET
IncCursorSpeed:     LD HL, MinCursorSpeedRef
                    INC (HL)
                    CALL Mouse.InitAcceleration
                    CALL Console.SwitchScreen       ; switch screen log
                    CALL DrawGamePause
                    ; exit, processed
                    OR A
                    RET
Show:               ResetGameplayFlag SHOW_PAUSE_MENU_GAME_FLAG         ; пауза меню отображается
                    SetGameplayFlag ACTIVATE_PAUSE_MENU_GAME_FLAG       ; сброс запроса активации отобразить меню 
                    GetCurrentScreen
                    LD A, MemoryPage_ShadowScreen
                    JR Z, $+4
                    LD A, MemoryPage_MainScreen
                    LD (Hide.Screen), A
                    SeMemoryPage_A GAME_PAUSE_MENU_ID
                    CALL FadeoutScreen
                    CALL Console.ShadowScreen       ; switch screen log
                    CALL DrawGamePause
                    SwapScreens
                    RET
Hide:               CALL Tilemap.ForceScreen
.Screen             EQU $+1
                    LD A, #00
                    SeMemoryPage_A GAME_PAUSE_MENU_ID
                    ; SwapScreens
                    ;
                    LD HL, #C000 + #1800 + #0300
                    LD DE, #3838
                    CALL MEMSET.SafeFill_768
                    ;
                    SetGameplayFlag SHOW_PAUSE_MENU_GAME_FLAG           ; выключение
                    RET

FadeoutScreen:      LD HL, #C000
                    LD DE, #AA55
                    LD BC, #0018

.Loop               LD A, D
                    LD D, E
                    LD E, A
                
.LoopRow            LD A, (HL)
                    AND E
                    LD (HL), A
                    INC HL
                    DJNZ .LoopRow

                    DEC C
                    JR NZ, .Loop

                    RET
DrawGamePause:      LD A, #46
                    LD (Console.Color), A
                    
                    ; rempston mouse
                    LD BC, #00C0 + 6
                    CALL Console.At2
                    LD BC, KemMouse_T
                    CALL Console.Log
                    ; ----------
                    CheckHardwareFlag KEMPSTON_MOUSE_FLAG
                    LD A, #2B
                    JR Z, $+4
                    LD A, #2D
                    CALL Console.LogChar

                    ; rempston joystick
                    LD BC, #00E0 + 6
                    CALL Console.At2
                    LD BC, KemJoystick_T
                    CALL Console.Log
                    ; ----------
                    CheckHardwareFlag KEMPSTON_JOY_BUTTON_3
                    LD A, #2B
                    JR Z, $+4
                    LD A, #2D
                    CALL Console.LogChar

                    ; cursor speed
                    LD BC, #0100 + 6
                    CALL Console.At2
                    LD BC, CursorSpeed_T
                    CALL Console.Log
                    ; ----------
                    LD A, (Mouse.Speed)
                    LD B, A
                    CALL Console.Logb

                    ; resume game
                    LD BC, #0120 + 6
                    CALL Console.At2
                    LD BC, ResumeGame_T
                    CALL Console.Log

                    LD A, #47
                    LD (Console.Color), A
                    RET

KemMouse_T          BYTE " 1. Kempston Mouse \0"
KemJoystick_T       BYTE " 2. Kempston Joystick \0"
CursorSpeed_T       BYTE " 3/4 Cursor Speed \0"
ResumeGame_T        BYTE " 0. Resume \0"

                    endmodule

                    endif ; ~_CORE_HANDLER_GAME_PAUSE_
