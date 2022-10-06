
                ifndef _BUILDER_GAME_TABLE_PACK_
                define _BUILDER_GAME_TABLE_PACK_

                MMU 3, Page.Game.TilemapEx                                      ; 3 bank, Page.Game.Third (7) page
                ORG Adr.Module.Game.TilemapEx
                module Game

                display "\'Game Tilemap Ex\' :\t\t\t\t\t-------------------- [ ", /D, SizeTilemapEx, " bytes / ", /D, SizeInSectorsT, " sector(s) ]  [", /D, Page.Game.TilemapEx, "]\t-------------------------------------------------"

BeginTilemapEx: EQU $
                include "Core/Module/Tables/BypassFOW.inc"                      ; таблица обхода FOW
SizeTilemapEx:  EQU $ - BeginTilemapEx
SizeInSectorsT: EQU (SizeTilemapEx >> 8) + ((SizeTilemapEx % TRDOS.SECTOR_SIZE > 0) & 0x01)

                savetrd TRD_FILENAME, GameTilemapExNameTRD, BeginTilemapEx, SizeTilemapEx

                endmodule

                endif ; ~ _BUILDER_GAME_TABLE_PACK_

