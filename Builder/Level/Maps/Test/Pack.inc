
                ifndef _BUILDER_LEVEL_MAP_TEST_PACK_
                define _BUILDER_LEVEL_MAP_TEST_PACK_

                MMU 3, Page.Game.Tilemap                                        ; 3 bank, Page.Game.Tilemap (1) page
                ORG Adr.Module.Game.Tilemap
                module Tilemap

                display "\'Tilemap - Test\' :\t\t\t\t\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ]  [", /D, Page.Game.Tilemap, "]\t-------------------------------------------------"

Begin:          EQU $

                include "Map.asm"
                include "Surface.inc"
                include "Units.inc"

Size:           EQU $ - Begin
SizeInSectors:  EQU (Size >> 8) + ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01)

                OPT -Wno-trdext                                                 ; disable "trdext"
                savetrd TRD_FILENAME, TilemapTestNameTRD, Begin, Size
                OPT -Wtrdext                                                    ; re-enable "trdext"

                endmodule

                endif ; ~ _BUILDER_LEVEL_MAP_TEST_PACK_

