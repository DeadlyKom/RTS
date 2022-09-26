
                ifndef _BUILDER_KERNEL_PACK_
                define _BUILDER_KERNEL_PACK_

                include "Kernel.inc"
                include "Core/Module/Input/Mouse/VirtualKeys.inc"
                include "Core/Module/Input/Keyboard/VirtualKeys.inc"
                include "Core/Module/Input/Kempston/VirtualKeys.inc"

                MMU 2, 2                                                        ; 2 bank, 2 page
                ORG Adr.Interrupt
                module Kernel

                assert SizeInSectors <= 0x4000, page overflow

                display "\'Kernel\' :\t\t\t\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ]  [2]\t-------------------------------------------------"
Begin:          EQU $
                include "Core/Module/Interrupt/Include.inc"
                ; memory
                include "Core/Module/Memory/Switch.asm"
                include "Core/Module/Memory/MemSet.asm"
                include "Core/Module/Memory/MemcpyPages.asm"
                include "Core/Module/Memory/MemcpyFastLDIR.asm"
                include "Core/Module/Memory/MemcpySprite.asm"
                ; utils
                include "Core/Module/Draw/Utils/PixelAddress.asm"
                include "Core/Module/Draw/Utils/PixelAttribute.asm"
                ; draw
                include "Core/Module/Draw/Sprite/Charboundary/DrawCharboundary.asm"
                include "Core/Module/Draw/Sprite/Charboundary/DrawSprite.asm"
                include "Core/Module/Draw/Sprite/Charboundary/DrawStencilSprite.asm"
                include "Core/Module/Draw/Sprite/Unit/Include.inc"
                ; tilemap
                include "Core/Module/Draw/Tilemap/DrawRow.asm"                  ; Game
                include "Core/Module/Draw/Tilemap/DrawTileRows.asm"             ; Game
                ; math
                include "Core/Module/Math/RNG/Rand8.asm"
                include "Core/Module/Math/Div/Div8x8.asm"
                ; decompressor
                include "Core/Module/Decompressor/Forward.asm"
                include "Core/Module/Decompressor/Backward.asm"

                include "Core/Module/Draw/Old/DrawSprite.asm"                   ; ??
        
                include "Core/Module/Input/Include.inc"
                
                include "Functions/Include.inc"
                include "Modules/Include.inc"

                include "Core/Module/Tables/ShiftTable.inc"                     ; таблица сдвигов                                           (3584 байт)
                include "Core/Module/Tables/ScreenAddressTable.inc"             ; таблица предрасчитаных адресов экрана                     (512 байт)  есть свободные 64 байта х2
                include "Core/Module/Tables/MultiplySprite.inc"                 ; таблица умножения, применение для пропуска байт спрайтов  (128 байт)  есть свободные 128 байт

                ; отладочная
                ifdef _DEBUG
                include "Core/Module/Utils/Debug/Console.asm"
                include "Core/Module/Utils/Debug/FPS_Counter.asm"
                endif
Size:           EQU $ - Begin
SizeInSectors   EQU ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01) + (Size >> 8)

                savetrd TRD_FILENAME, KernelNameTRD, Begin, Size

                endmodule

                endif ; ~ _BUILDER_KERNEL_PACK_
