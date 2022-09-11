
                ifndef _BUILDER_GAME_PACK_
                define _BUILDER_GAME_PACK_

                MMU 1, Page.Game.First                                          ; 1 bank, Page.Game.First (5) page
                ORG Adr.Module.Game.First
                module Game

                display "\'Game First\' :\t\t-------------------- [ ", /D, SizeFirst, " bytes / ", /D, SizeInSectorsF, " sector(s) ] \t-------------------------------------------------"

BeginFirst:     EQU $
                include "Core/Module/Game/include.inc"
SizeFirst:      EQU $ - BeginFirst
SizeInSectorsF: EQU (SizeFirst >> 8) + ((SizeFirst % TRDOS.SECTOR_SIZE > 0) & 0x01)

                savetrd TRD_FILENAME, GameFirstNameTRD, BeginFirst, SizeFirst

                endmodule

                endif ; ~ _BUILDER_GAME_PACK_

