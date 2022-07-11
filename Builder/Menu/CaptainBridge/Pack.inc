
                ifndef _BUILDER_MENU_PACK_NEW_GAME_
                define _BUILDER_MENU_PACK_NEW_GAME_

                MMU 1, Page.CaptainBridge                                       ; 1 bank, Page.CaptainBridge (5) page
                ORG Adr.Module.CaptainBridge
                module CaptainBridge

                display "\'Menu - Captain Bridge\' :\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ] \t-------------------------------------------------"
Begin:          EQU $
                include "Core/Module/Menu/CaptainBridge/Include.inc"
Size:           EQU $ - Begin
SizeInSectors:  EQU ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01) + (Size >> 8)

                savetrd TRD_FILENAME, CaptainBridgeNameTRD, Begin, Size

                endmodule

                endif ; ~ _BUILDER_MENU_PACK_NEW_GAME_

