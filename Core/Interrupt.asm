
                    ifndef _CORE_INTERRUPT_
                    define _CORE_INTERRUPT_

                    module Interrupt
InterruptStackSize  EQU 64 * 2                                      ; not change
InterruptStack:     DS InterruptStackSize, 0                        ; not change
Handler:            ; ********** HANDLER IM 2 *********
                    EX (SP), HL
                    LD (.ReturnAddress), HL
                    POP HL                                          ; restore HL value
                    LD (.Container_SP), SP                          ; save original SP pointer
.RestoreRegister    EQU $
                    NOP                                             ; restore corrupted bytes below SP (PUSH HL/DE/BC)
                    LD SP, InterruptStack + InterruptStackSize      ; use custom stack for IM2

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
                    LD HL, Internal_AICounter                           ; внутрений счётчик (период между обновлениями кластеров юнитов)
                    DEC (HL)
                    JP NZ, .AI_TickCounter_End                          ; счётчик не обнулён (ожидаем)
                    INC (HL)                                            ; увеличим счётчик (возможно ещё подождать 1 фрейм)
                    EX DE, HL
                    
                    ; проверка, возможности перехода к следующему кластеру юнитов
                    LD HL, UnitClusterRef
                    LD A, (HL)
                    INC HL
                    CP (HL)
                    JP Z, .AI_TickCounter_End                           ; обработка текущего кластера юнитов не завершена (подождём следующий фрейм)

                    ; обработка текущего кластера, заверщена
                    LD A, AI_UpdateFrequency
                    LD (DE), A                                          ; обновим счётчик
                    DEC HL
                    INC (HL)                                            ; перейдём к обработке следующего кластера
.AI_TickCounter_End ; ~ AI TICK COUNTER

.Mouse              ; ************* MOUSE *************
                    ifdef ENABLE_MOUSE
                    ; mouse handling
                    CALL Handlers.Input.ScanMouse

                    ; restore background cursor
                    CheckFrameFlag RESTORE_CURSOR
                    CALL NZ, Cursor.Restore

                    endif
                    ; ~ MOUSE

                    ; show debug border
                    ifdef SHOW_DEBUG_BORDER_INTERRUPT
                    BEGIN_DEBUG_BORDER_COL INTERRUPT_COLOR
                    endif

.Keyboard           ; ****** SCAN KEYBOARD KEYS *******
                    ; keyboard handling
                    CALL Handlers.Input.ScanKeyboard
                    ; ~ SCAN KEYBOARD KEYS

.DebugInfo          ; ****** SWITCH DEBUG SCREENS *****
                    ; swith screens
                    ifdef ENABLE_TOGGLE_SCREENS_DEBUG
                    GetCurrentScreen
                    LD A, #C0
                    JR Z, $+4
                    LD A, #40
                    LD (Console.NoflicConsoleScreenAddr), A
                    endif
                    ; ~ SWITCH DEBUG SCREENS

.FPS_Counter        ; ************** FPS **************
                    ifdef SHOW_FPS
                    SeMemoryPage MemoryPage_ShadowScreen, RENDER_FPS_ID
	                CALL FPS_Counter.IntTick
                    CALL FPS_Counter.Render_FPS
	                endif
                    ; ~ FPS

.MousePositionInfo  ; *** DRAW DEBUG MOUSE POSITION ***
                    ifdef SHOW_MOUSE_POSITION
                    ; show mouse position
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
                    ; ~ DRAW DEBUG MOUSE POSITION

.OffsetTilemap      ; ****** DRAW OFFSET TILEMAP *****
                    ifdef SHOW_OFFSET_TILEMAP
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
                    ; ~ DRAW OFFSET TILEMAP

.NumVisibleUnits    ; ******* DRAW VISIBLE UNITS ******
                    ifdef SHOW_VISIBLE_UNITS
                    LD BC, #02A0 + 6
                    CALL Console.At2
                    LD HL, Unit.VisibleUnits
                    LD B, (HL)
                    CALL Console.Logb
                    endif
                    ; ~ DRAW VISIBLE UNITS

.SwapScreens        ; ********* SWAP SCREENS **********
                    ; swap screens if it's ready
                    CheckFrameFlag SWAP_SCREENS_FLAG
                    JP Z, .SkipSwapScreens
                    ; ~ SWAP SCREENS

.Render             ; ************ RENDER *************
                    
                    SwapScreens

                    ; FPS
                    ifdef SHOW_FPS
                    CALL FPS_Counter.FrameRendered
                    endif

                    ResetFrameFlag SWAP_SCREENS_FLAG

                    SetFrameFlag ALLOW_MOVE_TILEMAP

                    ; ~ RENDER

.SkipSwapScreens    ; ---------------------------------
.MoveTilemap        ; ********* MOVE TILEMAP **********
                    CheckFrameFlag ALLOW_MOVE_TILEMAP
                    CALL NZ, Handlers.Input.ScanMoveMap
                    ; ~ MOVE TILEMAP

.TimeOfDay          ; ********* TIME OF DAY **********
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
                    ; ~ TIME OF DAY

.DrawCursor         ; ********** DRAW CURSOR **********
                    ifdef ENABLE_MOUSE
                    SeMemoryPage MemoryPage_ShadowScreen, RENDER_CURSOT_ID
                    GetCurrentScreen
                    LD A, #40
                    JR Z, $+4
                    LD A, #C0
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
                    SeMemoryPage_A INT_RESTORE_PAGE_ID
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
AI_TickCounterPtr   EQU $+1
Internal_AICounter: DB AI_UpdateFrequency

                    endmodule

                    endif ; ~_CORE_INTERRUPT_
