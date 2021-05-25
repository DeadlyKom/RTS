
                ifndef _CORE_MEMORY_PAGE_01_
                define _CORE_MEMORY_PAGE_01_

                MMU 3, 1
                ORG Page_1
                
                module MemoryPage_1
Start:
                ORG TileMap

                include "Page_01_Map.asm"

                ORG UnitArray
DraftUnitArray: FUnit 0, 0, 0, 1,  21, 1,  0, 0
                FUnit 0, 0, 0, 2,  32, 13,  0, 0
                FUnit 0, 0, 0, 3,  40, 1,  0, 0
                FUnit 0, 0, 0, 0,  0, 6,  0, 0
                FUnit 0, 0, 0, 0,  42, 6,  0, 0
                FUnit 0, 0, 0, 0,  15, 2,  0, 0
                FUnit 0, 0, 0, 0,  23, 18,  0, 0
                FUnit 0, 0, 0, 0,  18, 8,  0, 0
                FUnit 0, 0, 0, 0,  22, 6,  0, 0
End:
                endmodule
SizePage_1:     EQU MemoryPage_1.End - MemoryPage_1.Start

                endif ; ~_CORE_MEMORY_PAGE_01_
