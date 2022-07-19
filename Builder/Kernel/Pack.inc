
                ifndef _BUILDER_KERNEL_PACK_
                define _BUILDER_KERNEL_PACK_

                include "Kernel.inc"
                include "Core/Module/Input/Mouse/VirtualKeys.inc"
                include "Core/Module/Input/Keyboard/VirtualKeys.inc"
                include "Core/Module/Input/Kempston/VirtualKeys.inc"

                MMU 2, 2                                                        ; 2 bank, 2 page
                ORG Adr.Interrupt
                module Kernel

                display "\'Kernel\' :\t\t\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ] \t-------------------------------------------------"
Begin:          EQU $
                include "Core/Module/Interrupt/Include.inc"
                include "Core/Module/Memory/Switch.asm"
                include "Core/Module/Memory/MemSet.asm"
                include "Core/Module/Memory/MemcpyPages.asm"
                include "Core/Module/Memory/MemCopyFastLDIR.asm"
                include "Core/Module/Draw/Attribute/PixelAddress.asm"
                include "Core/Module/Draw/Attribute/PixelAttribute.asm"
                include "Core/Module/Draw/Attribute/DrawCharBoundary.asm"
                include "Core/Module/Draw/Attribute/DrawSprite.asm"
                ; include "Core/Module/Draw/Monochrome/DrawSpriteTest.asm"
                include "Core/Module/Draw/Monochrome/DrawSprite.asm"
                include "Core/Module/Draw/Attribute/DrawStencilSprite.asm"
                include "Core/Module/Input/Include.inc"
                include "Core/Module/Math/RNG/Rand8.asm"
                include "Core/Module/Math/Div/Div8x8.asm"
                include "Core/Module/Decompressor/Forward.asm"
                include "Core/Module/Decompressor/Backward.asm"
                include "Functions/Include.inc"
                include "Modules/Include.inc"

                include "Core/Module/Tables/ShiftTable.inc"                     ; таблица сдвигов (3584 байт)
Size:           EQU $ - Begin
SizeInSectors   EQU ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01) + (Size >> 8)

                savetrd TRD_FILENAME, KernelNameTRD, Begin, Size

                endmodule

                endif ; ~ _BUILDER_KERNEL_PACK_