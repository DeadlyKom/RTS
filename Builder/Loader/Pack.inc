
                ifndef _BUILDER_LOADER_PACK_
                define _BUILDER_LOADER_PACK_

                MMU 1, Page.Loader                                              ; 1 bank, Page.Loader page
                ORG Adr.Loader
                module Loader

                display "\'Loader\' :\t\t\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ] \t-------------------------------------------------"

                ifdef _REBUILD
                include "../../Sprites/Menu/Loader/Compress.inc"
                endif
Begin:          EQU $
                include "../../Core/Module/Loader/Include.inc"
Size:           EQU $ - Begin
SizeInSectors:  EQU (Size >> 8) + ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01)

                savetrd TRD_FILENAME, LoaderNameTRD, Begin, Size

                endmodule

                endif ; ~ _BUILDER_LOADER_PACK_

