                ifndef _EDITOR_
                define _EDITOR_

                include "../Core/Memory/Include.inc"
Editor:         LD HL, MemoryPage_0.MenuSprites + 10
                nop
                CALL MemoryPage_2.DisplayTileMap;  печать экрана

                JP Editor

                endif ; ~_INPUT_KEYBOARD_INCLUDE_