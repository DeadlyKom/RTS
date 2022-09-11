
                ifndef _BUILDER_GAME_TILE_PACK_
                define _BUILDER_GAME_TILE_PACK_

                MMU 3, Page.Game.Second                                         ; 3 bank, Page.Game.Second (1) page
                ORG Adr.Module.Game.Second
                module Game

                display "\'Game Second\' :\t\t-------------------- [ ", /D, SizeSecond, " bytes / ", /D, SizeInSectorsS, " sector(s) ] \t-------------------------------------------------"

BeginSecond:    EQU $
                include "Core/Module/Tilemap/include.inc"
SizeSecond:     EQU $ - BeginSecond
SizeInSectorsS: EQU (SizeSecond >> 8) + ((SizeSecond % TRDOS.SECTOR_SIZE > 0) & 0x01)

                savetrd TRD_FILENAME, GameSecondNameTRD, BeginSecond, SizeSecond

                endmodule

                endif ; ~ _BUILDER_GAME_TILE_PACK_

