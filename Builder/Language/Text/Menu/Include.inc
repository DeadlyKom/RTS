

                ifndef _BUILDER_LANGUAGE_PACK_TEXT_MENU_INCLUDE_
                define _BUILDER_LANGUAGE_PACK_TEXT_MENU_INCLUDE_

                module Menu

                include "Const.inc"

                include "English.inc"
                include "Russian.inc"

                display "Max Length Language: ", /D, Size
Size:           EQU English.Size >? Russian.Size

                endmodule

                endif ; ~ _BUILDER_LANGUAGE_PACK_TEXT_MENU_INCLUDE_

