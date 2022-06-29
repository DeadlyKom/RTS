
                ifndef _BUILDER_MENU_PACK_OPTIONS_
                define _BUILDER_MENU_PACK_OPTIONS_

                MMU 1, Page.Options                                             ; 1 bank, Page.Options (5) page
                ORG Adr.Module.Options
                module Options

                display "\' Menu - Options\' :\t\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ] \t-------------------------------------------------"
Begin:          EQU $
                include "Core/Module/Menu/Options/Include.inc"
Size:           EQU $ - Begin
SizeInSectors:  EQU ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01) + (Size >> 8)

                savetrd TRD_FILENAME, MenuOptionsNameTRD, Begin, Size

                endmodule

                endif ; ~ _BUILDER_MENU_PACK_OPTIONS_

