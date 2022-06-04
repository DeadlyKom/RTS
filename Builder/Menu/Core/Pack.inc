
                ifndef _BUILDER_MENU_PACK_CORE_
                define _BUILDER_MENU_PACK_CORE_

                MMU 1, Page.Core                                                ; 1 bank, Page.Core (5) page
                ORG Adr.Module.Core
                module Core

                display "\'Menu - Core\' :\t\t\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ] \t-------------------------------------------------"
Begin:          EQU $
                include "../../../Core/Module/Menu/Core/Include.inc"
Size:           EQU $ - Begin
SizeInSectors:  EQU ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01) + (Size >> 8)

                savetrd TRD_FILENAME, MenuCoreNameTRD, Begin, Size

                endmodule

                endif ; ~ _BUILDER_MENU_PACK_CORE_

