
                    ifndef _CORE_INTERRUPT_
                    define _CORE_INTERRUPT_

                    module Interrupt
InterruptStackSize  EQU 64 * 2                                                  ; not change
InterruptStack:     DS InterruptStackSize, 0                                    ; not change
InterruptStackTop   EQU InterruptStack + InterruptStackSize
Handler:            ; ********** HANDLER IM 2 *********
                    EX (SP), HL
                    LD (.ReturnAddress), HL
                    POP HL                                                      ; restore HL value
                    LD (.Container_SP), SP                                      ; save original SP pointer
.RestoreRegister    EQU $
                    NOP                                                         ; restore corrupted bytes below SP (PUSH HL/DE/BC)
                    LD SP, InterruptStackTop                                    ; use custom stack for IM2

.SaveRegs           ; ********* SAVE REGISTERS ********
                    PUSH HL
                    PUSH DE
                    PUSH BC
                    PUSH IX
                    PUSH IY
                    PUSH AF
                    EX AF, AF'
                    PUSH AF
                    EXX
                    PUSH HL
                    PUSH DE
                    PUSH BC
                    ; ~ SAVE REGISTERS

.SaveMemPage        ; ******** SAVE MEMORY PAGE *******
                    LD A, (MemoryPageRef)
                    LD (.RestoreMemPage + 1), A
                    ; ~ SAVE MEMORY PAGE

.TickCounter        ; ********** TICK COUNTER *********
.TickCounterPtr     EQU $+1
                    LD HL, #0000
                    INC HL
                    LD (TickCounterRef), HL
                    ; ~ TICK COUNTER

.AI_TickCounter     ; ******** AI TICK COUNTER *********
                    CheckAIFlag AI_UPDATE_FLAG
                    CALL NZ, Jump.AI.Tick
                    ; ~ AI TICK COUNTER

.Cursor             ; ************* CURSOR *************
                    ; cursor handling
                    CALL Handlers.Input.ScanCursor

                    ; restore background cursor
                    CheckFrameFlag RESTORE_CURSOR
                    CALL Z, Cursor.Restore

.SkipRestoreCursor  ; ~ CURSOR

                    ; show debug border
                    ifdef SHOW_DEBUG_BORDER_INTERRUPT
                    BEGIN_DEBUG_BORDER_COL INTERRUPT_COLOR
                    endif

.DebugInfo          ; ****** SWITCH DEBUG SCREENS *****
                    ; swith screens
                    ; ifdef ENABLE_TOGGLE_SCREENS_DEBUG
                    ; GetCurrentScreen
                    ; LD A, #C0
                    ; JR Z, $+4
                    ; LD A, #40
                    ; LD (Console.DrawChar.ConsoleScreen), A
                    ; endif
                    ; ~ SWITCH DEBUG SCREENS

.FPS_Counter        ; ************** FPS **************
                    ifdef SHOW_FPS
                    CheckGameplayFlag PATHFINDING_FLAG
                    JR Z, .SkipShowFPS
                    CALL Memory.InvScrPageToC000
	                CALL FPS_Counter.IntTick
                    CALL FPS_Counter.Render_FPS
	                endif
                    ; ~ FPS
.SkipShowFPS        ; ---------------------------------
.AI_Frequency       ; ********** AI FREQUENCY *********
                    ifdef SHOW_AI_FREQUENCY
                    CheckGameplayFlag PATHFINDING_FLAG
                    JR Z, .SkipShowAIFreq
                    LD A, #1A
                    CALL Console.At

                    ; show pause
                    CheckAIFlag GAME_PAUSE_FLAG
                    LD A, #47
                    JR Z, $+4
                    LD A, #50
                    CALL Console.LogChar

                    ; show AI frequency
                    LD A, (AI_UpdateFrequencyRef)
                    LD B, A
                    CALL Console.Logb

                    ; show AI sync update to frame
                    CheckAIFlag AI_SYNC_UPDATE_FLAG
                    LD A, #2B
                    JR Z, $+4
                    LD A, #2D
                    CALL Console.LogChar

	                endif
                    ; ~ AI FREQUENCY
.SkipShowAIFreq     ; ---------------------------------
.MousePositionInfo  ; *** DRAW DEBUG MOUSE POSITION ***
                    ifdef SHOW_MOUSE_POSITION
                    CheckGameplayFlag PATHFINDING_FLAG
                    JR Z, .SkipShowMousePos
                    ; show mouse position
                    LD BC, #02E0 + 0
                    CALL Console.At2
                    LD HL, CursorPositionRef
                    LD B, (HL)
                    CALL Console.Logb
                    LD BC, #02E0 + 3
                    CALL Console.At2
                    INC HL
                    LD B, (HL)
                    CALL Console.Logb
                    LD BC, #02E0 + 6
                    CALL Console.At2
                    LD BC, #FADF
                    IN B, (C)
                    CALL Console.Logb
                    endif
.SkipShowMousePos   ; ~ DRAW DEBUG MOUSE POSITION
.OffsetTilemap      ; ****** DRAW OFFSET TILEMAP *****
                    ifdef SHOW_OFFSET_TILEMAP
                    CheckGameplayFlag PATHFINDING_FLAG
                    JR Z, .SkipShowOffsetTM
                    LD BC, #02A0 + 0
                    CALL Console.At2
                    LD HL, TilemapOffsetRef
                    LD B, (HL)
                    CALL Console.Logb
                    LD BC, #02A0 + 3
                    CALL Console.At2
                    INC HL
                    LD B, (HL)
                    CALL Console.Logb
                    endif
.SkipShowOffsetTM   ; ~ DRAW OFFSET TILEMAP
.NumVisibleUnits    ; ******* DRAW VISIBLE UNITS ******
                    ifdef SHOW_VISIBLE_UNITS
                    CheckGameplayFlag PATHFINDING_FLAG
                    JR Z, .SkipShowVisibleUnt
                    LD BC, #02A0 + 6
                    CALL Console.At2
                    LD HL, Unit.VisibleUnits
                    LD B, (HL)
                    CALL Console.Logb
                    endif
                    ; ~ DRAW VISIBLE UNITS

.SkipShowVisibleUnt ; ---------------------------------
.SwapScreens        ; ********* SWAP SCREENS **********
                    ; swap screens if it's ready
                    CheckFrameFlag SWAP_SCREENS_FLAG
                    JP NZ, .SkipSwapScreens
                    ; ~ SWAP SCREENS

.Render             ; ************ RENDER *************
                    
                    SwapScreens

.PathfindingQuery   ; ******* PATHFINDING QUERY *******
                    AND %00001000
                    JR Z, .RequestRejected
                    CheckGameplayFlag PATHFINDING_QUERY_FLAG
                    JR NZ, .RequestRejected
                    ; SetFrameFlag DELAY_RENDER_FLAG
                    SetGameplayFlag PATHFINDING_QUERY_FLAG
                    ResetGameplayFlag PATHFINDING_FLAG
                    ; ~ PATHFINDING QUERY

.RequestRejected    ; ---------------------------------

                    ; FPS
                    ifdef SHOW_FPS
                    CALL FPS_Counter.FrameRendered
                    endif

                    SetFrameFlag SWAP_SCREENS_FLAG
                    ResetFrameFlag RENDER_FINISHED
                    ; ~ RENDER

.SkipSwapScreens    ; ---------------------------------
.Keyboard           ; ****** SCAN KEYBOARD KEYS *******
                    ; keyboard handling
                    CALL Handlers.Input.ScanKeyboard
                    ; ~ SCAN KEYBOARD KEYS

.RenderFinished     ; ******* RENDER FINISHED *********
                    CheckFrameFlag RENDER_FINISHED
                    JR NZ, .SkipRenderFinished
                    ; ~ RENDER FINISHED

.MoveTilemap        ; ********* MOVE TILEMAP **********
                    CheckInputFlag SELECTION_RECT_FLAG
                    CALL NZ, Handlers.Input.ScanMoveMap                         ; перемещение разрешено, если не вкл режим выбора рамкой
                    ; ~ MOVE TILEMAP
 
.PauseMenuGame      ; ******* PAUSE MENU GAME ********
                    CheckGameplayFlag ACTIVATE_PAUSE_MENU_GAME_FLAG
                    CALL Z, Handlers.GamePause.Show

.SkipRenderFinished ; ---------------------------------
.TimeOfDay          ; ********* TIME OF DAY **********
                    ifdef ENABLE_TIME_OF_DAY

                    CheckGameplayFlag SHOW_PAUSE_MENU_GAME_FLAG                 ; пропустим если активирована пауза игры
                    JR Z, .SkipTimeOfDay

                    LD HL, (TimeOfDay)
                    DEC HL
                    LD (TimeOfDay), HL
                    LD A, H
                    OR L
                    JR NZ, .SkipTimeOfDay
                    
                    LD HL, TimeOfDayChangeRate
                    LD (TimeOfDay), HL
                    CALL NextDay
.SkipTimeOfDay      
                    endif
                    ; ~ TIME OF DAY

.DrawCursor         ; ********** DRAW CURSOR **********
                    ifdef ENABLE_MOUSE
                    CALL Memory.SetPage7
                    GetCurrentScreen
                    LD A, #80
                    JR Z, $+4
                    LD A, #00
                    CALL Cursor.Draw
                    endif
                    ; ~ DRAW CURSOR
                    
.Music              ; *********** PLAY MUSIC **********
                    ; play music
                    ifdef ENABLE_MUSIC
                    CALL Game.PlayMusic
                    endif
                    ; ~ PLAY MUSIC

.RestoreMemPage     ; ****** RESTORE MEMORY PAGE ******
                    LD A, #00
                    CALL Memory.SetPage
                    ; ~ RESTORE MEMORY PAGE

.RestoreReg         ; ******** RESTORE REGISTERS ******
                    POP BC
                    POP DE
                    POP HL
                    EXX
                    POP AF
                    EX AF, AF'
                    POP AF
                    POP IY
                    POP IX
                    POP BC
                    POP DE
                    POP HL
                    ; ~ RESTORE REGISTERS

.Container_SP       EQU $+1
                    LD SP, #0000
                    EI
.ReturnAddress      EQU $+1
                    JP #0000
                    ; ~ HANDLER IM 2

Initialize:         ; **** INITIALIZE HANDLER IM 2 ****
                    LD A, HIGH InterruptVectorAddress - 1
                    LD I, A
                    IM 2

                    EI
                    HALT
                    RET
                    ; ~ INITIALIZE HANDLER IM 2
TimeOfDay:          DW TimeOfDayChangeRate

                    endmodule

                    endif ; ~_CORE_INTERRUPT_
