
                ifndef _BUILDER_LANGUAGE_PACK_TEXT_MENU_ENGLISH_
                define _BUILDER_LANGUAGE_PACK_TEXT_MENU_ENGLISH_

                MMU 1, Page.MainMenu                                            ; 1 bank, Page.MainMenu page
                ORG Adr.MainMenuText
                module English

                display "\'Menu Text EN\' :\t\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ] \t-------------------------------------------------"
Begin:          EQU $

                incbin "En/MainMenuEN_Table.bin"
                incbin "En/MainMenuEN.txt"
Size:           EQU $ - Begin
SizeInSectors:  EQU (Size >> 8) + ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01)

                savetrd TRD_FILENAME, MainTextEnNameTRD, Begin, Size

                endmodule

                endif ; ~ _BUILDER_LANGUAGE_PACK_TEXT_MENU_ENGLISH_

