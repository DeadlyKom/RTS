
                ifndef _BUILDER_FILE_SYSTEM_PACK_
                define _BUILDER_FILE_SYSTEM_PACK_

                include "FileSystem.inc"

                MMU 3, FileSystemPage                                           ; 3 bank, FileSystemPage (1) page
                ORG FileSystem
                module FileSystem

                display "\'FileSystem\' :\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ] \t-------------------------------------------------"
Begin:          EQU $
                include "../../Core/Module/FileSystem/Include.inc"

Size:           EQU $ - Begin
SizeInSectors   EQU ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01) + (Size >> 8)

                savetrd TRD_FILENAME, "FS.#", Begin, Size

                endmodule

                endif ; ~ _BUILDER_FILE_SYSTEM_PACK_