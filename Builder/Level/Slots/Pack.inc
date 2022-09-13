
                ifndef _BUILDER_LEVEL_SLOTS_PACK_
                define _BUILDER_LEVEL_SLOTS_PACK_

                MMU 1, 2                                                        ; 1 bank, 2 page
                ORG RenderBuffer
                module Slot

                display "\'Level Slots\' :\t\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ]  [", /D, 2, "]\t-------------------------------------------------"

Begin:          EQU $
                include "Slots.inc"
Size:           EQU $ - Begin
SizeInSectors:  EQU (Size >> 8) + ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01)

                OPT -Wno-trdext                                                 ; disable "trdext"
                savetrd TRD_FILENAME, LevelsNameTRD, Begin, Size
                OPT -Wtrdext                                                    ; re-enable "trdext"

                endmodule

                endif ; ~ _BUILDER_LEVEL_SLOTS_PACK_

