
                ifndef _CORE_MEMORY_PAGE_02_
                define _CORE_MEMORY_PAGE_02_

                MMU 2, 2
                ORG Page_2

MemoryPage_2_Start:
                ; interrupt table 257 bytes (not move)
                dup 257
                DB HIGH InterruptVectorAddress
                edup

                ; include interrupt handler (not move)
                include "../Interrupt.asm"

                include "../Handler/Include.inc"
                include "../Display/MemCopy.asm"
                include "../Display/TileMap/Include.inc"

                ifdef ENABLE_MOUSE
                include "../Display/Cursor/Include.inc"
                endif

                include "../Display/BackgroundFill.asm"
                include "../Handler/Unit.asm"
                
                include "../Display/Metods/Include.inc"
                
MemoryPage_2_End:

SizePage_2:     EQU MemoryPage_2_End - MemoryPage_2_Start

                endif ; ~_CORE_MEMORY_PAGE_02_
