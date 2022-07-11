
                ifndef _BUILDER_LANGUAGE_PACK_TEXT_MESSAGE_RUSSIAN_
                define _BUILDER_LANGUAGE_PACK_TEXT_MESSAGE_RUSSIAN_

                MMU 1, Page.Core                                                ; 1 bank, Page.Core page
                ORG Adr.Module.MsgText
                module Russian

                display "\'Message Text RU\' :\t\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ] \t-------------------------------------------------"
Begin:          EQU $

                incbin "Ru/MessageRU_RU_Table.bin"
                incbin "Ru/MessageRU_RU.txt"
Size:           EQU $ - Begin
SizeInSectors:  EQU (Size >> 8) + ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01)

                savetrd TRD_FILENAME, MsgTextRuNameTRD, Begin, Size

                endmodule

                endif ; ~ _BUILDER_LANGUAGE_PACK_TEXT_MESSAGE_RUSSIAN_

