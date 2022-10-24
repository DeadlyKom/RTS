
                ifndef _BUILDER_GRAPHICS_SPRITE_PACK_1_
                define _BUILDER_GRAPHICS_SPRITE_PACK_1_

                MMU 3, Page.Graphics.Pack1                                      ; 3 bank, Page.Graphics.Pack1 (2) page
                ORG Adr.Graphics.Pack1
                module Spites

                display "\'Sprite Pack 1\' :\t\t\t\t\t-------------------- [ ", /D, GraphSP1Size, " bytes / ", /D, SizeInSectorsGraphSP1, " sector(s) ] \t-------------------------------------------------"
BeginGraphSP1:  EQU $
                include "Shuttle/Include.inc"
                include "Core/Module/Tables/Graphics/Infantry/Move.inc"
GraphSP1Size:   EQU $ - BeginGraphSP1
SizeInSectorsGraphSP1:  EQU ((GraphSP1Size % TRDOS.SECTOR_SIZE > 0) & 0x01) + (GraphSP1Size >> 8)

                OPT -Wno-trdext                                                 ; disable "trdext"
                savetrd TRD_FILENAME, GraphicsPack_1_NameTRD, BeginGraphSP1, GraphSP1Size
                OPT -Wtrdext                                                    ; re-enable "trdext"

                endmodule

                endif ; ~ _BUILDER_GRAPHICS_SPRITE_PACK_1_