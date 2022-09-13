
                ifndef _BUILDER_FILE_SYSTEM_PACK_
                define _BUILDER_FILE_SYSTEM_PACK_

                MMU 3, Page.Module.FileSystem                                   ; 3 bank, Page.Module.FileSystem (1) page
                ORG Adr.Module.FileSystem
                module FileSystem

                display "\'FileSystem\' :\t\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ]  [", /D, Page.Module.FileSystem, "]\t-------------------------------------------------"
Begin:          EQU $
                include "Core/Module/FileSystem/Base/Include.inc"
                include "Core/Module/FileSystem/Load/Level/Include.inc"

Size:           EQU $ - Begin
SizeInSectors:  EQU ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01) + (Size >> 8)

                savetrd TRD_FILENAME, FileSystemNameTRD, Begin, Size

                endmodule

                endif ; ~ _BUILDER_FILE_SYSTEM_PACK_