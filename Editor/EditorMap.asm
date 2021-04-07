                ifndef _EDITOR_
                define _EDITOR_

                include "../Core/Memory/Include.inc"
Editor:         LD HL, MemoryPage_0.MenuSprites + 10
                HALT
                CALL MemoryPage_2.DisplayTileMap;  печать экрана
                CALL MemoryPage_2.DrawCursor
                CALL CopyShadow
                ld hl,(MemoryPage_5.TileMapPtr)
                ld hl,#7000
                
                ld (hl),#01+#80
                JP Editor
        ; карта в памяти page 05  addres #7000 

CopyShadow:     LD BC, PORT_7FFD; переключаем экран
                LD A, MemoryPage_ShadowScreen   
                OUT (C), A
                CALL MemoryPage_7.CopyScreen
                RET
                endif ; ~_INPUT_KEYBOARD_INCLUDE_