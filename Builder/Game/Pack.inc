
                ifndef _BUILDER_GAME_PACK_
                define _BUILDER_GAME_PACK_

                MMU 1, Page.Game.First                                          ; 1 bank, Page.Game.First (5) page
                ORG Adr.Module.Game.First
                module Game

                display "\'Game\' :\t\t\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ] \t-------------------------------------------------"

Begin:          EQU $
                include "Core/Module/Game/include.inc"
Size:           EQU $ - Begin
SizeInSectors:  EQU (Size >> 8) + ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01)

                savetrd TRD_FILENAME, GameNameTRD, Begin, Size

                endmodule

                endif ; ~ _BUILDER_GAME_PACK_

