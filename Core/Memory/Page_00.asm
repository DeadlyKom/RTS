
                ifndef _CORE_MEMORY_PAGE_00_
                define _CORE_MEMORY_PAGE_00_

                include "Page_00_Map.inc"

                MMU 3, 0
                ORG UnitCodePtr

MemoryPage_0_Start:
                include "../Module/AI/Include.inc"
MemoryPage_0_End:

UnitCodeSize:   EQU MemoryPage_0_End - MemoryPage_0_Start
SizePage_0:     EQU Size + UnitCodeSize

                endif ; ~_CORE_MEMORY_PAGE_00_
