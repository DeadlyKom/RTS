
                        ifndef _CORE_MEMORY_INCLUDE_
                        define _CORE_MEMORY_INCLUDE_

Page_0:                 EQU #C000                   ; Bank 03
Page_1:                 EQU #C000                   ; Bank 03
Page_2:                 EQU #8000                   ; Bank 02
Page_3:                 EQU #C000                   ; Bank 03
Page_4:                 EQU #C000                   ; Bank 03
Page_5:                 EQU #4000 + #1B00 + #0225   ; Bank 01 (Screen 0) (пропуск экрана и 0x225 байт данных для TR DOS )
Page_6:                 EQU #C000                   ; Bank 03
Page_7:                 EQU #C000 + #1B00           ; Bank 03 (Screen 1) (пропуск экрана)

                        include "../Structure/Base.inc"
                        include "../Structure/Sprite.inc"
                        include "../Structure/UnitInfo.inc"

                        include "Page_00.asm"
                        include "Page_01.asm"
                        include "Page_01_Map.asm"
                        include "Page_02.asm"
                        include "Page_03.asm"
                        include "Page_04.asm"
                        include "Page_05.asm"
                        include "Page_06.asm"
                        include "Page_07.asm"

MemoryPage_TilemapSprite EQU CONST_7FFD | 0
MemoryPage_Tilemap      EQU CONST_7FFD | 1
MemoryPage_Music        EQU CONST_7FFD | 3
MemoryPage_ShadowScreen EQU CONST_7FFD | 7

                        endif ; ~_CORE_MEMORY_INCLUDE_
