
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

                    ; keyboard handling
                    CALL Handlers.Input.ScanKeyboard

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

                    ifdef SHOW_DEBUG
                    LD A, #00
                    CALL Console.At
                    LD HL, Handlers.Input.KeyStack
                    LD B, (HL)
                    INC HL
                    CALL Console.Logb
                    LD A, #02
                    CALL Console.At
                    LD B, (HL)
                    INC HL
                    CALL Console.Logb
                    INC HL
                    INC HL

                    LD A, #05
                    CALL Console.At
                    LD B, (HL)
                    INC HL
                    CALL Console.Logb
                    LD A, #07
                    CALL Console.At
                    LD B, (HL)
                    INC HL
                    CALL Console.Logb
                    INC HL
                    INC HL

                    LD A, #0A
                    CALL Console.At
                    LD B, (HL)
                    INC HL
                    CALL Console.Logb
                    LD A, #0C
                    CALL Console.At
                    LD B, (HL)
                    INC HL
                    CALL Console.Logb
                    INC HL
                    INC HL

                    LD A, #0F
                    CALL Console.At
                    LD B, (HL)
                    INC HL
                    CALL Console.Logb
                    LD A, #11
                    CALL Console.At
                    LD B, (HL)
                    INC HL
                    CALL Console.Logb
                    INC HL
                    INC HL

                    LD A, #14
                    CALL Console.At
                    LD B, (HL)
                    INC HL
                    CALL Console.Logb
                    LD A, #16
                    CALL Console.At
                    LD B, (HL)
                    INC HL
                    CALL Console.Logb
                    INC HL
                    INC HL
                    endif

                    ; FPS
                    ifdef SHOW_FPS
	                CALL FPS_Counter.IntTick
                    CALL FPS_Counter.Render_FPS
	                endif

                    ; swap screens if it's ready
                    LD A, (CoreStateRef)
                    INC A
                    JR NZ, .SkipSwapScreens
                    SwapScreens
                    XOR A
                    LD (CoreStateRef), A

                    ; FPS
                    ifdef SHOW_FPS
                    CALL FPS_Counter.FrameRendered
                    endif

                    ; handling key states in a circular buffer
                    CALL Handlers.Input.KeyStates

                    ; JP NZ, $+15
                    ; ; calculate frame per second
                    ; LD A, #CE
                    ; LD (HL), A
                    ; LD HL, FPS_Counter
                    ; LD A, (HL)
                    ; INC HL
                    ; LD (HL), A
                    ; DEC HL
                    ; XOR A
                    ; LD (HL), A

                    

                    ;
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
                    ; keyboard handling
                    ; LD HL, MemoryPage_5.Flags
                    ; LD A, (HL)
                    ; RLA
                    ; JR C, .SkipInput
                    ; LD HL, InterruptCounter
                    ; LD A, (HL)
                    ; LD HL, MemoryPage_5.Flags
                    ; OR (HL)
                    ; RRA
                    ; JR C, .NextKey4
                    ;

                    ; LD HL, FPS_Counter
                    ; INC (HL)

                    ; keyboard handling
                    ; LD A, (InterruptCounter)
                    ; RRA
                    ; JR C, .SkipKeyboardInput
                    ;
                    ; LD HL, (TilemapRef)
                    ; PUSH HL
                    
                    ; LD A, VK_A
                    ; CALL Keyboard.CheckKeyState_
                    ; CALL Z, Tilemap.MoveLeft
                    ; LD A, VK_D
                    ; CALL Keyboard.CheckKeyState_
                    ; CALL Z, Tilemap.MoveRight
                    ; LD A, VK_W
                    ; CALL Keyboard.CheckKeyState_
                    ; CALL Z, Tilemap.MoveUp
                    ; LD A, VK_S
                    ; CALL Keyboard.CheckKeyState_
                    ; CALL Z, Tilemap.MoveDown
                    ; ; ; ------ Test unit ------
                    ; ; LD A, VK_H
                    ; ; CALL CheckKeyState
                    ; ; CALL Z, MemoryPage_5.Unit_Right
                    ; ; LD A, VK_F
                    ; ; CALL CheckKeyState
                    ; ; CALL Z, MemoryPage_5.Unit_Left
                    ; ; LD A, VK_T
                    ; ; CALL CheckKeyState
                    ; ; CALL Z, MemoryPage_5.Unit_Up
                    ; ; LD A, VK_G
                    ; ; CALL CheckKeyState
                    ; ; CALL Z, MemoryPage_5.Unit_Down
                    ; ; ; ~~~~~~ Test unit ~~~~~~
                    ; ;
                    ; LD HL, (TilemapRef)
                    ; POP DE                    
                    ; OR A
                    ; SBC HL, DE
                    ; CALL NZ, Tilemap.Prepare
.SkipKeyboardInput
.SkipSwapScreens
                    ; play music
                    ifdef ENABLE_MUSIC
                    CALL Game.PlayMusic
                    endif

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
