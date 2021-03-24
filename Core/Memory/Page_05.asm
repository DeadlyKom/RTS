
                ifndef _CORE_MEMORY_PAGE_05_
                define _CORE_MEMORY_PAGE_05_

                MMU 1, 5
                ORG Page_5
                
                module MemoryPage_5
Start:
CopyScreenCont:
.Offset         defl 364 * 16
                dup 68
                ; получение 16 байт
                LD SP, #4000 + .Offset
                POP HL
                POP DE
                POP BC
                POP AF
                EX AF, AF'
                POP AF
                EXX
                POP HL
                POP DE
                POP BC
                ; сохранение 16 байт
                LD SP, #C000 + .Offset
                PUSH BC
                PUSH DE
                PUSH HL
                EXX
                PUSH AF
                EX AF, AF'
                PUSH AF
                PUSH BC
                PUSH DE
                PUSH HL
.Offset = .Offset + 16
                edup
.ContainerSP    EQU $+1
                LD SP, #0000
                EI
                RET
GameEntry:      CALL GameInitialize

                LD HL, BufferCMD
                LD DE, MemoryPage_2.DisplayTileMap
                
                LD (HL), E
                INC HL
                LD (HL), D
                INC HL

                LD (HL), E
                INC HL
                LD (HL), D
                INC HL

                LD (HL), E
                INC HL
                LD (HL), D
                INC HL

                LD (HL), E
                INC HL
                LD (HL), D
                INC HL

                ; main loop
                HALT
                CALL PlayMusic               
                LD DE, #0000
.HandlerCMD     LD HL, (CounterTime)
                ADD HL, DE
                LD (CounterTime), HL
                LD BC, #FE00                            ; the frame time is modified in the interrupt
                ADD HL, BC
                JR C, .IsEnd
                ; execute block code
                LD HL, .HandlerCMD
                PUSH HL
                LD HL, (PointerCMD)
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                LD (PointerCMD), HL
                LD A, D
                OR E
                JR Z, .BufferIsEmpty
                ifdef _DEBUG_CHECK
                LD BC, -(SizeBufferCMD + BufferCMD)
                ADD HL, BC
                JR Z, .BufferIsEmpty
                endif
                EX DE, HL
                JP (HL)                                 ; block code must return delta time in DE

.IsEnd          ; some code to the end of the frame

                JR $

.BufferIsEmpty  ; copy from buffer screen to shadow screen

                JR $

SizeBufferCMD:  EQU 8 * 2
PointerCMD:     DW BufferCMD
CounterTime:    DW #0000
BufferCMD:      DS SizeBufferCMD, 0

GameInitialize: CALL MemoryPage_2.InitMouse
                CALL MemoryPage_2.InitInterrupt
                RET
PlayMusic:      RET

                align 256
TileMap:        DB #80, #81, #00, #01 : DS 60, #00
                DB #01, #80, #01, #00 : DS 60, #00
                DB #81, #81, #01, #00 : DS 60, #00
                DB #01, #81, #01, #01 : DS 60, #00
                DS 4096 - 256, #00
End:
                endmodule
SizePage_5:     EQU MemoryPage_5.End - MemoryPage_5.Start

                endif ; ~_CORE_MEMORY_PAGE_05_
