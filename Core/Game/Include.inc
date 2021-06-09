
                ifndef _CORE_GAME_INCLUDE_
                define _CORE_GAME_INCLUDE_

                module Game

                include "EntryPoint.asm"
                include "Initialize.asm"
                include "Loop.asm"
                include "Music.asm"
TilemapPtr:     DW #0000
UnitArrayPtr:   DW #0000
TilemapOffset:  FLocation 0, 0
TilemapSize:    FMapSize 64, 64
FrameFlags:     DB #00
FrameUnitsFlag: DB #00
HardwareFlags:  DB #00

                ifdef DEBUG
DebugFlags:     DB #00
                endif

                endmodule

                endif ; ~_CORE_GAME_INCLUDE_
