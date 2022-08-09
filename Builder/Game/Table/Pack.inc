
                ifndef _BUILDER_GAME_TABLE_PACK_
                define _BUILDER_GAME_TABLE_PACK_

                MMU 3, Page.Game.Third                                          ; 3 bank, Page.Game.Third (7) page
                ORG Adr.Module.Game.Third
                module Game

                display "\'Game Third\' :\t\t\t-------------------- [ ", /D, SizeThird, " bytes / ", /D, SizeInSectorsT, " sector(s) ] \t-------------------------------------------------"

BeginThird:     EQU $
                include "Core/Module/Tables/BypassFOW.inc"                      ; таблица обхода FOW
SizeThird:      EQU $ - BeginThird
SizeInSectorsT: EQU (SizeThird >> 8) + ((SizeThird % TRDOS.SECTOR_SIZE > 0) & 0x01)

                savetrd TRD_FILENAME, GameThirdNameTRD, BeginThird, SizeThird

                endmodule

                endif ; ~ _BUILDER_GAME_TABLE_PACK_

