
                ifndef _CORE_MEMORY_PAGE_00_
                define _CORE_MEMORY_PAGE_00_

                MMU 3, 0
                ORG Page_0
                
                module MemoryPage_0
Start:
                
TileSprites:    align 256
                DW Sprite1, Sprite2

Sprite1:        ; 1
                DW #0000, #FE7F, #0240, #0240, #0241, #0243, #0245, #0241
                DW #0000, #FE7F, #0240, #0240, #C247, #0241, #0241, #0241
Sprite2:        ; 2
                DW #0000, #FE7F, #0240, #0240, #8243, #4244, #4240, #8240
                DW #0000, #FE7F, #0240, #0240, #C247, #0244, #0242, #0241

                RET
End:
                endmodule
SizePage_0:     EQU MemoryPage_0.End - MemoryPage_0.Start

                endif ; ~_CORE_MEMORY_PAGE_00_
