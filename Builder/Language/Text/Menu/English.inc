
                ifndef _BUILDER_LANGUAGE_PACK_TEXT_MENU_ENGLISH_
                define _BUILDER_LANGUAGE_PACK_TEXT_MENU_ENGLISH_

                MMU 1, Page.Core                                                ; 1 bank, Page.Core page
                ORG Adr.Module.MenuText
                module English

                display "\'Menu Text EN\' :\t\t\t\t\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ]  [", /D, Page.Core, "]\t-------------------------------------------------"
Begin:          EQU $

                incbin "En/MenuEN_EN_Table.bin"
                incbin "En/MenuEN_EN.txt"
Size:           EQU $ - Begin
SizeInSectors:  EQU (Size >> 8) + ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01)

                OPT -Wno-trdext                                                 ; disable "trdext"
                savetrd TRD_FILENAME, MenuTextEnNameTRD, Begin, Size
                OPT -Wtrdext                                                    ; re-enable "trdext"

                endmodule

                endif ; ~ _BUILDER_LANGUAGE_PACK_TEXT_MENU_ENGLISH_

