
                ifndef _CORE_MEMORY_PAGE_00_
                define _CORE_MEMORY_PAGE_00_

                include "Page_00_Map.inc"

                MMU 3, 0
                ORG Page_0
                    
                module MemoryPage_0
Start:
                RET
End:
                endmodule
SizePage_0:     EQU MemoryPage_6.End - MemoryPage_6.Start

                endif ; ~_CORE_MEMORY_PAGE_00_
