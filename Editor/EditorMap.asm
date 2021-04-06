                ifndef _EDITOR_
                define _EDITOR_

                include "../Core/Memory/Include.inc"
Editor:         
            ld hl,MemoryPage_0.MenuSprites
            call MemoryPage_2.DisplayTileMap;  печать экрана
            jp Editor

                endif ; ~_INPUT_KEYBOARD_INCLUDE_