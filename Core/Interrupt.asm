
                    ifndef _CORE_INTERRUPT_
                    define _CORE_INTERRUPT_

InterruptStackSize  EQU 24 * 2
InitInterrupt:      ;DI
                    ;
                    LD HL, InterruptHandler
                    LD (InterruptVectorAddressFrame), HL
                    ;
                    LD A, HIGH InterruptVectorAddress
                    LD I, A
                    IM 2

                    EI
                    HALT
                    RET
InterruptHandler:   ; preservation registers
                    LD (.Container_SP), SP
                    LD SP, InterruptStack + InterruptStackSize
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
                    ; interrupt counter increment
                    LD HL, InterruptCounter
                    INC (HL)
                    JP NZ, $+15
                    ; calculate frame per second
                    LD A, #CE
                    LD (HL), A
                    LD HL, FPS_Counter
                    LD A, (HL)
                    INC HL
                    LD (HL), A
                    DEC HL
                    XOR A
                    LD (HL), A 
                    ; play music
                    LD A, (MemoryPagePtr)
                    LD (.RestoreMemoryPage), A
                    CALL MemoryPage_5.PlayMusic
                    ;
                    LD HL, (TimeOfDay)
                    DEC HL
                    LD (TimeOfDay), HL
                    LD A, H
                    OR L
                    JR NZ, .SkipTimeOfDay
                    ;
                    LD HL, TimeOfDayChangeRate
                    LD (TimeOfDay), HL
                    CALL MemoryPage_2.BackgroundFill
.SkipTimeOfDay
                    ;
.RestoreMemoryPage  EQU $+1
                    LD A, #00
                    SeMemoryPage_A
                    ; mouse handling
                    CALL MemoryPage_2.UpdateStatesMouse
                    ; keyboard handling
                    LD HL, MemoryPage_5.Flags
                    LD A, (HL)
                    RLA
                    JR C, .SkipInput
                    ; LD HL, InterruptCounter
                    ; LD A, (HL)
                    ; LD HL, MemoryPage_5.Flags
                    ; OR (HL)
                    ; RRA
                    ; JR C, .NextKey4
                    ;
                    LD HL, FPS_Counter
                    INC (HL)
                    ;
                    LD HL, (MemoryPage_5.TileMapPtr)
                    PUSH HL
                    ;
                    LD A, VK_A
                    CALL CheckKeyState
                    CALL Z, MemoryPage_2.Tilemap_Left
                    LD A, VK_D
                    CALL CheckKeyState
                    CALL Z, MemoryPage_2.Tilemap_Right
                    LD A, VK_W
                    CALL CheckKeyState
                    CALL Z, MemoryPage_2.Tilemap_Up
                    LD A, VK_S
                    CALL CheckKeyState
                    CALL Z, MemoryPage_2.Tilemap_Down
                    ; ------ Test unit ------
                    LD A, VK_H
                    CALL CheckKeyState
                    CALL Z, MemoryPage_5.Unit_Right
                    LD A, VK_F
                    CALL CheckKeyState
                    CALL Z, MemoryPage_5.Unit_Left
                    LD A, VK_T
                    CALL CheckKeyState
                    CALL Z, MemoryPage_5.Unit_Up
                    LD A, VK_G
                    CALL CheckKeyState
                    CALL Z, MemoryPage_5.Unit_Down
                    ; ~~~~~~ Test unit ~~~~~~
                    ;
                    LD HL, (MemoryPage_5.TileMapPtr)
                    POP DE                    
                    OR A
                    SBC HL, DE
                    JR Z, $+8
                    LD HL, (MemoryPage_5.TileMapPtr)
                    CALL MemoryPage_2.PrepareTilemap
.SkipInput          
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
                    RET
InterruptCounter:	DB #CE
FPS_Counter:        DB #00
FPS:                DB #00
TimeOfDay:          DW TimeOfDayChangeRate
InterruptStack:     DS InterruptStackSize, 0

                    endif ; ~_CORE_INTERRUPT_
