
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
                XOR A
                DEC A
                LD (MousePositionFlag), A

                CALL Draw


.MainLoop       ;HALT
; .Loop           LD A, VK_ENTER
;                 CALL CheckKeyState
;                 JR NZ, .Loop

                LD A, (MousePositionFlag)
                OR A
                JR Z, .MainLoop
                XOR A
                LD (MousePositionFlag), A
                CALL DrawCursor

                JR .MainLoop

GameInitialize: CALL InitMouse
                CALL MemoryPage_2.InitInterrupt
                RET

                include "../../Input/Include.inc"
                include "../../Utils/Include.inc"
                include "../Display/Draw.asm"
                include "../Display/DrawCursor.asm"
End:
                endmodule
SizePage_5:     EQU MemoryPage_5.End - MemoryPage_5.Start

                endif ; ~_CORE_MEMORY_PAGE_05_
