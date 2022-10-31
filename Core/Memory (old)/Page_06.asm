
                ifndef _CORE_MEMORY_PAGE_06_
                define _CORE_MEMORY_PAGE_06_

                MMU 3, 6
                ORG Page_6
                
                module MemoryPage_6
Start:
                RET
End:
                endmodule
SizePage_6:     EQU MemoryPage_6.End - MemoryPage_6.Start

                endif ; ~_CORE_MEMORY_PAGE_06_
