
                ifndef _BUILDER_GRAPHICS_TILEMAP_PACK_2_
                define _BUILDER_GRAPHICS_TILEMAP_PACK_2_

                MMU 3, Page.Tilemap.Sprite                                      ; 3 bank, Page.Tilemap.Sprite (7) page
                ORG Adr.Tilemap.SpriteTable
                module GraphicsB

                display "\'Tilemap Pack 2\' :\t\t\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ] \t-------------------------------------------------"
Begin:          EQU $
                include "Core/Module/Tables/Sprites/Tilemap/Pack_2.inc"
Size:           EQU $ - Begin
SizeInSectors:  EQU ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01) + (Size >> 8)

                OPT -Wno-trdext                                                 ; disable "trdext"
                savetrd TRD_FILENAME, TilemapPack_1_2_NameTRD, Begin, Size
                OPT -Wtrdext                                                    ; re-enable "trdext"

                endmodule

                endif ; ~ _BUILDER_GRAPHICS_TILEMAP_PACK_2_