
                ifndef _CORE_MEMORY_PAGE_07_
                define _CORE_MEMORY_PAGE_07_

                MMU 3, 7
                ORG Page_7
                
                module MemoryPage_7
Start:
CopyScreen:     DI
                LD (MemoryPage_5.CopyScreenCont.ContainerSP), SP
.Offset         defl 0
                dup 364
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
                LD SP, #C010 + .Offset
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
                JP MemoryPage_5.CopyScreenCont
End:
                endmodule
SizePage_7:     EQU MemoryPage_7.End - MemoryPage_7.Start

                endif ; ~_CORE_MEMORY_PAGE_07_
