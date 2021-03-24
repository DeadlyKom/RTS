
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
