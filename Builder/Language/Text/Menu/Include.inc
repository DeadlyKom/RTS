

                ifndef _BUILDER_LANGUAGE_PACK_TEXT_MENU_INCLUDE_
                define _BUILDER_LANGUAGE_PACK_TEXT_MENU_INCLUDE_

                module Menu

                include "Const.inc"

                include "English.inc"
                include "Russian.inc"

                if English.Size >? Russian.Size
Size:           EQU English.Size
                else
Size:           EQU Russian.Size
                endif

                endmodule

                endif ; ~ _BUILDER_LANGUAGE_PACK_TEXT_MENU_INCLUDE_

