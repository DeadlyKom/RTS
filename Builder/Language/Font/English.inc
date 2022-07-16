
                ifndef _BUILDER_LANGUAGE_PACK_FONT_ENGLISH_
                define _BUILDER_LANGUAGE_PACK_FONT_ENGLISH_

                MMU 3, Page.English                                             ; 3 bank, Page.Language.English page
                ORG Adr.English
                module English

                display "\'English Fonts\' :\t\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ] \t-------------------------------------------------"
Begin:          EQU $

                incbin "Core/Module/Sprites/Fonts/En/ASCII.spr"

                ORG Adr.Table
                incbin "Core/Module/Sprites/Fonts/En/ASCII_Table.bin"
Size:           EQU $ - Begin
SizeInSectors:  EQU (Size >> 8) + ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01)

                savetrd TRD_FILENAME, FontEnNameTRD, Begin, Size

                endmodule

                endif ; ~ _BUILDER_LANGUAGE_PACK_FONT_ENGLISH_

