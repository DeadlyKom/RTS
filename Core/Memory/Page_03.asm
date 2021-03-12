
                ifndef _CORE_MEMORY_PAGE_03_
                define _CORE_MEMORY_PAGE_03_

                MMU 3, 3
                ORG Page_3
                
                module MemoryPage_3
Start:
                RET
End:
                endmodule
SizePage_3:     EQU MemoryPage_3.End - MemoryPage_3.Start

                endif ; ~_CORE_MEMORY_PAGE_03_
