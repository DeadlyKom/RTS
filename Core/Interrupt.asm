
                    ifndef _CORE_INTERRUPT_
                    define _CORE_INTERRUPT_

InterruptStackSize  EQU 16 * 2
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
                    ; keyboard handling

                    ; mouse handling
                    CALL MemoryPage_2.UpdateStatesMouse
                    ;
                    LD HL, MemoryPage_5.Flags
                    LD A, (HL)
                    RLA
                    JR C, .NextKey4
                    ;
                    LD A, VK_A
                    CALL CheckKeyState
                    JR NZ, .NextKey1
                    LD HL, (MemoryPage_5.TileMapPtr)
                    LD A, L
                    AND %00111111
                    JR Z, .NextKey1
                    DEC L
                    LD (MemoryPage_5.TileMapPtr), HL
.NextKey1           LD A, VK_D
                    CALL CheckKeyState
                    JR NZ, .NextKey2
                    LD HL, (MemoryPage_5.TileMapPtr)
                    LD A, L
                    AND %00111111
                    ADD A, #D0
                    JR C, .NextKey2
                    INC L
                    LD (MemoryPage_5.TileMapPtr), HL
.NextKey2           LD A, VK_W
                    CALL CheckKeyState
                    JR NZ, .NextKey3
                    LD HL, (MemoryPage_5.TileMapPtr)  
                    LD A, H
                    LD E, L
                    RL E
                    RLA
                    RL E
                    RLA
                    AND %00111111
                    JR Z, .NextKey3
                    LD DE, #FFC0
                    ADD HL, DE
                    LD (MemoryPage_5.TileMapPtr), HL
.NextKey3           LD A, VK_S
                    CALL CheckKeyState
                    JR NZ, .NextKey4
                    LD HL, (MemoryPage_5.TileMapPtr)  
                    LD A, H
                    LD E, L
                    RL E
                    RLA
                    RL E
                    RLA
                    AND %00111111
                    ADD A, #CC
                    JR C, .NextKey4
                    LD DE, #0040
                    ADD HL, DE
                    LD (MemoryPage_5.TileMapPtr), HL
.NextKey4
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
InterruptCounter:	DB	#00
InterruptStack:     DS InterruptStackSize, 0

                    endif ; ~_CORE_INTERRUPT_
