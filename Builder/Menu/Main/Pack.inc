
                ifndef _BUILDER_MENU_PACK_MAIN_
                define _BUILDER_MENU_PACK_MAIN_

                MMU 1, Page.Main                                                ; 1 bank, Page.Main.Menu (5) page
                ORG Adr.Module.Main
                module Main

                display "\'Menu - Main\' :\t\t\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ]  [", /D, Page.Main, "]\t-------------------------------------------------"
Begin:          EQU $
                include "Core/Module/Menu/Main/Include.inc"
Size:           EQU $ - Begin
SizeInSectors:  EQU ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01) + (Size >> 8)

                savetrd TRD_FILENAME, MenuMainNameTRD, Begin, Size

                endmodule

                endif ; ~ _BUILDER_MENU_PACK_MAIN_

