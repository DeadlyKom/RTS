
                ifndef _BUILDER_MENU_PACK_
                define _BUILDER_MENU_PACK_

                MMU 1, 5                                                        ; 1 bank, 5 page
                ORG #4000
                module Menu

                display "\'Menu\' :\t\t\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ] \t\t-------------------------------------------------"
Begin:          EQU $
                include "../../Core/Module/Menu/Include.inc"
Size:           EQU $ - Begin
SizeInSectors:  EQU ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01) + (Size >> 8)

                savetrd TRD_FILENAME, MainMenuNameTRD, Begin, Size

                endmodule

                endif ; ~ _BUILDER_MENU_PACK_

