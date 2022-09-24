
                ifndef _BUILDER_GAME_TILE_CODE_PACK_
                define _BUILDER_GAME_TILE_CODE_PACK_

                MMU 3, Page.Game.Tilemap                                        ; 3 bank, Page.Game.Tilemap (1) page
                ORG Adr.Module.Game.TilemapCode
                module Game

                display "\'Game Tilemap Code\' :\t\t\t-------------------- [ ", /D, SizeTilemapCode, " bytes / ", /D, SizeInSectorsTilemapCode, " sector(s) ]  [", /D, Page.Game.Tilemap, "]\t-------------------------------------------------"

BeginTilemapCode:   EQU $
                include "Core/Module/Tilemap/Include.inc"
SizeTilemapCode:    EQU $ - BeginTilemapCode
SizeInSectorsTilemapCode:   EQU (SizeTilemapCode >> 8) + ((SizeTilemapCode % TRDOS.SECTOR_SIZE > 0) & 0x01)

                savetrd TRD_FILENAME, GameTilemapCodeNameTRD, BeginTilemapCode, SizeTilemapCode

                endmodule

                endif ; ~ _BUILDER_GAME_TILE_CODE_PACK_

