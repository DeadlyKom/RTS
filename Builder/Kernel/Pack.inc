
                ifndef _BUILDER_KERNEL_PACK_
                define _BUILDER_KERNEL_PACK_

                include "Kernel.inc"

                MMU 2, 2                                                        ; 2 bank, 2 page
                ORG Adr.Interrupt
                module Kernel

                display "\'Kernel\' :\t\t\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ] \t-------------------------------------------------"
Begin:          EQU $
                include "../../Core/Module/Interrupt/Include.inc"
                include "../../Core/Module/Memory/Switch.asm"
                include "../../Core/Module/Memory/MemSet.asm"
                include "../../Core/Module/Memory/MemcpyPages.asm"
                include "../../Core/Module/Draw/Attribute/PixelAddress.asm"
                include "../../Core/Module/Draw/Attribute/PixelAttribute.asm"
                include "../../Core/Module/Draw/Attribute/DrawChar.asm"
                include "../../Core/Module/Draw/Attribute/DrawSprite.asm"
                include "Functions/Include.inc"
                include "Modules/Include.inc"
Size:           EQU $ - Begin
SizeInSectors   EQU ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01) + (Size >> 8)

                savetrd TRD_FILENAME, KernelNameTRD, Begin, Size

                endmodule

                endif ; ~ _BUILDER_KERNEL_PACK_