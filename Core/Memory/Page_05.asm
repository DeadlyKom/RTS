
                ifndef _CORE_MEMORY_PAGE_05_
                define _CORE_MEMORY_PAGE_05_

                MMU 1, 5
                ORG Page_5
MemoryPage_5_Start:

                include "Tables/ShiftTable.inc"
                include "Tables/ScreenAddressRowsTable.inc"
                include "Tables/DrawMetods.inc"
                
                include "../../Core/Game/Include.inc"

                ifdef SHOW_DEBUG
                include "../../Utils/Console.asm"
                endif

                ifdef SHOW_FPS
	            include "../../Utils/FPS_Counter.asm"
                endif
TableSprites:   DW TableSprites_Infantry
TableSprites_Infantry:
                ; FSprite 24, 0, 24, 8, 0, MemoryPage_TilemapSprite, MemoryPage_0.Sprite_Bot_0     ; 0
                FSprite 16,     0,      8,      0,      0, MemoryPage_Sprites_0,    MemoryPage_0.SolderA_Move_0_0   ; напровление 0, индекс анимации 0
                FSprite 16,     0,      16,     8,      0, MemoryPage_Sprites_0,    MemoryPage_0.SolderA_Move_0_1   ; напровление 0, индекс анимации 1
                FSprite 16,     0,      16,     8,      0, MemoryPage_Sprites_0,    MemoryPage_0.SolderA_Move_0_1   ; напровление 0, индекс анимации 1
                FSprite 16,     0,      8,      0,      0, MemoryPage_Sprites_0,    MemoryPage_0.SolderA_Move_0_2   ; напровление 0, индекс анимации 2
                FSprite 16,     0,      8,      0,      0, MemoryPage_Sprites_0,    MemoryPage_0.SolderA_Move_0_3   ; напровление 0, индекс анимации 3
                FSprite 16,     0,      8,      0,      0, MemoryPage_Sprites_0,    MemoryPage_0.SolderA_Move_0_3   ; напровление 0, индекс анимации 3
Sprite_Cursor_Table:
                FSprite 16,     0,     16,      0,      0, MemoryPage_CursorSprite, MemoryPage_7.Sprite_Cursor_0    ; 
                FSprite 16,     0,     16,      0,      0, MemoryPage_CursorSprite, MemoryPage_7.Sprite_Cursor_1    ; 
                FSprite 16,     0,     16,      0,      0, MemoryPage_CursorSprite, MemoryPage_7.Sprite_Cursor_2    ; 
                FSprite 16,     0,     16,      0,      0, MemoryPage_CursorSprite, MemoryPage_7.Sprite_Cursor_3    ; 
MemoryPage_5_End:
SizePage_5:     EQU MemoryPage_5_End - MemoryPage_5_Start

                endif ; ~_CORE_MEMORY_PAGE_05_
