
                ifndef _MEMORY_OPERATIONS_INCLUDE_
                define _MEMORY_OPERATIONS_INCLUDE_

                module MEMCPY

                include "MemCopy.asm"
                ; include "MemCopyFastLDIR.asm"
                ; include "MemCopyPages.asm"
                include "Tilemap.asm"

                endmodule

                module MEMSET
                
                include "MemSet.asm"

                endmodule

                ; module Memory

                ; include "MemorySwitch.asm"
                
                ; endmodule

                endif ; ~_MEMORY_OPERATIONS_INCLUDE_