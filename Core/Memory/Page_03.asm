
                ifndef _CORE_MEMORY_PAGE_03_
                define _CORE_MEMORY_PAGE_03_

                MMU 3, 3
                ORG Page_3
                
                module MemoryPage_3
Start:
                inchob "../../AY/1.$c"      ; #C86E, #08AD (с проигрывателем)
                inchob "../../AY/2.$m"      ; #D11B, #06C9
                inchob "../../AY/3.$m"      ; #D7E4, #02CF - не хотит!
End:

                endmodule
Music_S         EQU MemoryPage_3.End - MemoryPage_3.Start
SizePage_3:     EQU Music_S

                endif ; ~_CORE_MEMORY_PAGE_03_
