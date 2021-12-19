
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
                include "../MemoryOperation/Include.inc"
                include "../Draw/TileMap/Include.inc"

                include "../Module/Include.inc"

                ifdef ENABLE_MOUSE
                include "../Draw/Cursor/Include.inc"
                endif

                include "../Draw/BackgroundFill.asm"
                
                include "../Draw/Metods/Include.inc"
                include "../Draw/Metods/ByRestore/Include.inc"

                include "../Draw/Sprite/Include.inc"
                include "../Module/UI/Include.inc"
                
MemoryPage_2_End:

SizePage_2:     EQU MemoryPage_2_End - MemoryPage_2_Start

                endif ; ~_CORE_MEMORY_PAGE_02_
