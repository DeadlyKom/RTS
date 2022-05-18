
                ifndef _BUILDER_LOADER_PACK_
                define _BUILDER_LOADER_PACK_

                MMU 1, 5                                                        ; 1 bank, 5 page
                ORG Adr.Loader
                module Loader

                display "\'Loader\' :\t\t\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ] \t\t-------------------------------------------------"

                include "../../Sprites/Menu/Loader/Compress.inc"
Begin:          EQU $
                include "../../Core/Module/Loader/Include.inc"
Size:           EQU $ - Begin
SizeInSectors:  EQU ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01) + (Size >> 8)

                savetrd TRD_FILENAME, LoaderNameTRD, Begin, Size

                endmodule

                endif ; ~ _BUILDER_LOADER_PACK_

