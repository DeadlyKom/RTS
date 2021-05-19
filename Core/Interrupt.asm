
                    ifndef _CORE_INTERRUPT_
                    define _CORE_INTERRUPT_

                    module Interrupt
InterruptStackSize  EQU 64 * 2                                      ; not change
InterruptStack:     DS InterruptStackSize, 0                        ; not change
Handler:            ;
                    EX (SP), HL
                    LD (.ReturnAddress), HL
                    POP HL                                          ; restore HL value
                    LD (.Container_SP), SP                          ; save original SP pointer
.RestoreRegister    EQU $
                    NOP                                             ; restore corrupted bytes below SP (PUSH HL/DE/BC)
                    LD SP, InterruptStack + InterruptStackSize      ; use custom stack for IM2

                    ; preservation registers
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

                    ; save current memory page
                    LD A, (MemoryPagePtr)
                    LD (.RestoreMemoryPage), A

                    ; interrupt counter increment
                    LD HL, InterruptCounter
                    INC (HL)

                    ;
                    LD A, (HL)
                    RRA
                    JR Z, .NotScanKeys
                    SetFrameFlag SCAN_KEYS_FLAG
.NotScanKeys
                    ; mouse handling
                    CALL Handlers.Input.ScanMouse

                    ; swith
                    ifdef ENABLE_TOGGLE_SCREENS_DEBUG
                    GetCurrentScreen
                    LD A, #C0
                    JR Z, $+4
                    LD A, #40
                    LD (Console.NoflicConsoleScreenAddr), A
                    endif

                    ; FPS
                    ifdef SHOW_FPS
	                CALL FPS_Counter.IntTick
                    CALL FPS_Counter.Render_FPS
	                endif

                    ; ----- ----- ----- DRAW DEBUG INFO ----- ----- -----
                    ; show mouse position
                    ifdef SHOW_DEBUG_MOUSE_POSITION
                    LD BC, #02E0 + 0
                    CALL Console.At2
                    LD HL, MousePositionRef
                    LD B, (HL)
                    CALL Console.Logb
                    LD BC, #02E0 + 3
                    CALL Console.At2
                    INC HL
                    LD B, (HL)
                    CALL Console.Logb
                    endif
                    ; ~~~~~ ~~~~~ ~~~~~ DRAW DEBUG INFO ~~~~~ ~~~~~ ~~~~~

                    ; swap screens if it's ready
                    CheckFrameFlag RENDERED_FLAG
                    JR Z, .SkipSwapScreens

                    ResetFrameFlag RENDERED_FLAG

                    SwapScreens

                    ; FPS
                    ifdef SHOW_FPS
                    CALL FPS_Counter.FrameRendered
                    endif

                    SetFrameFlag RENDER_ALL_FLAGS

                    ; keyboard handling
                    CheckFrameFlag SCAN_KEYS_FLAG
                    CALL NZ, Handlers.Input.ScanKeyboard

                    GetCurrentScreen
                    LD A, #40
                    JR Z, $+4
                    LD A, #C0
                    LD (.CursorScreen), A

                    ; LD HL, (TimeOfDay)
                    ; DEC HL
                    ; LD (TimeOfDay), HL
                    ; LD A, H
                    ; OR L
                    ; JR NZ, .SkipTimeOfDay
                    ;
                    ; LD HL, TimeOfDayChangeRate
                    ; LD (TimeOfDay), HL
                    ; CALL MemoryPage_2.BackgroundFill
; .SkipTimeOfDay
                    ;

                    ; mouse handling
                    ; CALL MemoryPage_2.UpdateStatesMouse
                    JR .S
.SkipSwapScreens
                    GetCurrentScreen
                    LD A, #40
                    JR Z, $+4
                    LD A, #C0
                    LD (.CursorScreen), A
                    
.S    
                    ; ----- ----- ----- PLAY MUSIC ----- ----- -----
                    ; play music
                    ifdef ENABLE_MUSIC
                    CALL Game.PlayMusic
                    endif
                    ; ~~~~~ ~~~~~ ~~~~~ PLAY MUSIC ~~~~~ ~~~~~ ~~~~~
.CursorScreen       EQU $+1
                    LD A, #00
                    CALL Cursor.Draw
.ExitIntertupt      ;
.RestoreMemoryPage  EQU $+1
                    LD A, #00
                    SeMemoryPage_A

                    ; restore all registers
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
.Container_SP       EQU $+1
                    LD SP, #0000
                    EI
.ReturnAddress      EQU $+1
                    JP #0000

Initialize:         ;
                    LD A, HIGH InterruptVectorAddress - 1
                    LD I, A
                    IM 2

                    EI
                    HALT
                    RET
InterruptCounter:	DB #CE
TimeOfDay:          DW TimeOfDayChangeRate

                    endmodule

                    endif ; ~_CORE_INTERRUPT_
