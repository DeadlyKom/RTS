
                ifndef _CORE_MEMORY_PAGE_01_
                define _CORE_MEMORY_PAGE_01_

                MMU 3, 1
                ORG Page_1
                
                module MemoryPage_1
Start:
                RET
End:
                endmodule
SizePage_1:     EQU MemoryPage_1.End - MemoryPage_1.Start

                endif ; ~_CORE_MEMORY_PAGE_01_
