
                ifndef _CORE_MEMORY_PAGE_04_
                define _CORE_MEMORY_PAGE_04_

                MMU 3, 4
                ORG Page_4
                
                module MemoryPage_4
Start:
                RET
End:
                endmodule
SizePage_4:     EQU MemoryPage_4.End - MemoryPage_4.Start

                endif ; ~_CORE_MEMORY_PAGE_04_
