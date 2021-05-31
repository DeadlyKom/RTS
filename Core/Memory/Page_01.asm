
                ifndef _CORE_MEMORY_PAGE_01_
                define _CORE_MEMORY_PAGE_01_

                MMU 3, 1
                ORG Page_1
                
                module MemoryPage_1
Start:
                ORG MapStructure

                FMap Tilemap, {64, 64}, {1, 1}, UnitArray


                ; align 256
Tilemap:        include "Map.asm"

UnitCounter:    DB #00

                ; порядок структур
                ; FUnitLocation
End:
                endmodule
SizePage_1:     EQU MemoryPage_1.End - MemoryPage_1.Start

                endif ; ~_CORE_MEMORY_PAGE_01_
