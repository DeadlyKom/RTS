
                ifndef _CORE_MEMORY_PAGE_05_
                define _CORE_MEMORY_PAGE_05_

                MMU 1, 5
                ORG Page_5
MemoryPage_5_Start:
                include "Tables/ShiftTable.inc"                                 ; таблица сдвигов (3584 байт)
                include "Tables/ScreenAddressTable.inc"                         ; таблица таблица адресов экрана (1024 байта)
                include "Tables/DrawMetods.inc"
                include "Tables/MultiplySprite.inc"                             ; выровненая таблица (занимает 128 байт)
                include "../../Sprites/Include.inc"                             ; таблица спрайтов
                
                include "../../Core/Game/Include.inc"

                ifdef SHOW_DEBUG
                include "../../Utils/Console.asm"
                endif

                ifdef SHOW_FPS
	            include "../../Utils/FPS_Counter.asm"
                endif

                include "../../Utils/DrawLine.asm"
                include "../../Utils/DrawRectangle.asm"

MemoryPage_5_End:
SizePage_5:     EQU MemoryPage_5_End - MemoryPage_5_Start

                endif ; ~_CORE_MEMORY_PAGE_05_
