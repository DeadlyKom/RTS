
                ifndef _BUILDER_LANGUAGE_PACK_TEXT_MESSAGE_ENGLISH_
                define _BUILDER_LANGUAGE_PACK_TEXT_MESSAGE_ENGLISH_

                MMU 1, Page.Core                                                ; 1 bank, Page.Core page
                ORG Adr.Module.MsgText
                module English

                display "\'Message Text EN\' :\t\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ]  [", /D, Page.Core, "]\t-------------------------------------------------"
Begin:          EQU $

                incbin "En/MessageEN_EN_Table.bin"
                incbin "En/MessageEN_EN.txt"
Size:           EQU $ - Begin
SizeInSectors:  EQU (Size >> 8) + ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01)

                OPT -Wno-trdext                                                 ; disable "trdext"
                savetrd TRD_FILENAME, MsgTextEnNameTRD, Begin, Size
                OPT -Wtrdext                                                    ; re-enable "trdext"

                endmodule

                endif ; ~ _BUILDER_LANGUAGE_PACK_TEXT_MESSAGE_ENGLISH_

