
                ifndef _CORE_GAME_INCLUDE_
                define _CORE_GAME_INCLUDE_

                module Game

                include "EntryPoint.asm"
                include "Initialize.asm"
                include "Loop.asm"
                include "Music.asm"
TilemapPtr:     DW TileMap + 0
TilemapOffset:  FLocation 0, 0
TilemapSize:    FMapSize 64, 64
StatusFlag      DB #00

                endmodule

                endif ; ~_CORE_GAME_INCLUDE_
