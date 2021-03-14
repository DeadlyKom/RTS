
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
                CALL MemoryPage_2.DisplayTileMap
                JR $
GameInitialize: CALL MemoryPage_2.InitMouse
                CALL MemoryPage_2.InitInterrupt
                RET
                align 256
TileMap:        DB #00, #01, #00, #01 : DS 60, 0
                DB #01, #00, #01, #00 : DS 60, 0
                DB #01, #01, #01, #00 : DS 60, 0
                DB #01, #01, #01, #01 : DS 60, 0
                DS 4096 - 256, 0
End:
                endmodule
SizePage_5:     EQU MemoryPage_5.End - MemoryPage_5.Start

                endif ; ~_CORE_MEMORY_PAGE_05_
