

                ifndef _BUILDER_LANGUAGE_PACK_TEXT_MESSAGE_INCLUDE_
                define _BUILDER_LANGUAGE_PACK_TEXT_MESSAGE_INCLUDE_

                module Message

                include "Const.inc"

                include "English.inc"
                include "Russian.inc"

                display "Message -> Max Length Language: ", /D, Size
Size:           EQU English.Size >? Russian.Size

                endmodule

                endif ; ~ _BUILDER_LANGUAGE_PACK_TEXT_MESSAGE_INCLUDE_

