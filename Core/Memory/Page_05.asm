
                ifndef _CORE_MEMORY_PAGE_05_
                define _CORE_MEMORY_PAGE_05_

                MMU 1, 5
                ORG Page_5
MemoryPage_5_Start:

                include "Tables/ShiftTable.inc"
                include "Tables/ScreenAddressRowsTable.inc"
                include "Tables/DrawMetods.inc"
                include "../../Sprites/Table.inc"
                
                include "../../Core/Game/Include.inc"

                ifdef SHOW_DEBUG
                include "../../Utils/Console.asm"
                endif

                ifdef SHOW_FPS
	            include "../../Utils/FPS_Counter.asm"
                endif
        
MemoryPage_5_End:
SizePage_5:     EQU MemoryPage_5_End - MemoryPage_5_Start

                endif ; ~_CORE_MEMORY_PAGE_05_
