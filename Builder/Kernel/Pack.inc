
                ifndef _BUILDER_KERNEL_PACK_
                define _BUILDER_KERNEL_PACK_

                include "Kernel.inc"

                MMU 2, 2                                                        ; 2 bank, 2 page
                ORG Interrupt
                module Kernel

                display "\'Kernel\' :\t\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ] \t-------------------------------------------------"
Begin:          EQU $
                include "../../Core/Module/Interrupt/Include.inc"
                include "../../Core/Module/Memory/Switch.asm"
                include "../../Core/Module/Memory/MemcpyPages.asm"
Size:           EQU $ - Begin
SizeInSectors   EQU ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01) + (Size >> 8)

                savetrd TRD_FILENAME, "Kernel.#", Begin, Size

                endmodule

                endif ; ~ _BUILDER_KERNEL_PACK_