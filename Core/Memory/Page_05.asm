
                ifndef _CORE_MEMORY_PAGE_05_
                define _CORE_MEMORY_PAGE_05_

                MMU 1, 5
                ORG Page_5
MemoryPage_5_Start:

                include "../../Core/Game/Include.inc"
ArrayUnits      FUnit 0, 0, 0, 1,  8, 6,  0, 0
                FUnit 0, 0, 0, 1,  21, 1,  0, 0
                FUnit 0, 0, 0, 2,  32, 13,  0, 0
                FUnit 0, 0, 0, 3,  40, 1,  0, 0
                FUnit 0, 0, 0, 0,  0, 6,  0, 0
                FUnit 0, 0, 0, 0,  42, 6,  0, 0
                FUnit 0, 0, 0, 0,  15, 2,  0, 0
                FUnit 0, 0, 0, 0,  23, 18,  0, 0
                FUnit 0, 0, 0, 0,  18, 8,  0, 0
                FUnit 0, 0, 0, 0,  22, 6,  0, 0
CountUnits      DB #0A

TableSprites:   DW TableSprites_Infantry
TableSprites_Infantry:
                ; FSprite 24, 0, 24, 8, 0, MemoryPage_TilemapSprite, MemoryPage_0.Sprite_Bot_0     ; 0
                FSprite 16,     0,      8,      0,      0, MemoryPage_Sprites_0, MemoryPage_0.SolderA_Move_0_0     ; напровление 0, индекс анимации 0
                FSprite 16,     0,      16,     8,      0, MemoryPage_Sprites_0, MemoryPage_0.SolderA_Move_0_1     ; напровление 0, индекс анимации 1
                FSprite 16,     0,      16,     8,      0, MemoryPage_Sprites_0, MemoryPage_0.SolderA_Move_0_1     ; напровление 0, индекс анимации 1
                FSprite 16,     0,      8,      0,      0, MemoryPage_Sprites_0, MemoryPage_0.SolderA_Move_0_2     ; напровление 0, индекс анимации 2
                FSprite 16,     0,      8,      0,      0, MemoryPage_Sprites_0, MemoryPage_0.SolderA_Move_0_3     ; напровление 0, индекс анимации 3
                FSprite 16,     0,      8,      0,      0, MemoryPage_Sprites_0, MemoryPage_0.SolderA_Move_0_3     ; напровление 0, индекс анимации 3

                include "../Display/ShiftTable.inc"
                include "../Display/ScreenAddressRowsTable.inc"
MemoryPage_5_End:
SizePage_5:     EQU MemoryPage_5_End - MemoryPage_5_Start

                endif ; ~_CORE_MEMORY_PAGE_05_
