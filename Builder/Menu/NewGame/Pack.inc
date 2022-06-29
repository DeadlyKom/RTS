
                ifndef _BUILDER_MENU_PACK_NEW_GAME_
                define _BUILDER_MENU_PACK_NEW_GAME_

                MMU 1, Page.NewGame                                             ; 1 bank, Page.NewGame (5) page
                ORG Adr.Module.NewGame
                module NewGame

                display "\'Menu - New Game\' :\t\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ] \t-------------------------------------------------"
Begin:          EQU $
                include "Core/Module/Menu/NewGame/Include.inc"
Size:           EQU $ - Begin
SizeInSectors:  EQU ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01) + (Size >> 8)

                savetrd TRD_FILENAME, MenuNewGameNameTRD, Begin, Size

                endmodule

                endif ; ~ _BUILDER_MENU_PACK_NEW_GAME_

