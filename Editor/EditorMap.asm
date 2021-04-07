                ifndef _EDITOR_
                define _EDITOR_

                include "../Core/Memory/Include.inc"
Editor:         LD HL, MemoryPage_0.MenuSprites + 10
                
                CALL MemoryPage_2.DisplayTileMap;  печать экрана
                nop
                JP Editor

                endif ; ~_INPUT_KEYBOARD_INCLUDE_