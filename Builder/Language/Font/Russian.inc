
                ifndef _BUILDER_LANGUAGE_PACK_FONT_RUSSIAN_
                define _BUILDER_LANGUAGE_PACK_FONT_RUSSIAN_

                MMU 3, Page.Russian                                             ; 3 bank, Page.Language.Russian page
                ORG Adr.Russian
                module Russian

                display "\'Russian Fonts\' :\t\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ] \t-------------------------------------------------"
Begin:          EQU $

                incbin "Core/Module/Sprites/Fonts/Ru/ASCII.spr"

                ORG Adr.Table
                incbin "Core/Module/Sprites/Fonts/Ru/ASCII_Table.bin"
                
Size:           EQU $ - Begin
SizeInSectors:  EQU (Size >> 8) + ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01)

                OPT -Wno-trdext                                                 ; disable "trdext"
                savetrd TRD_FILENAME, FontRuNameTRD, Begin, Size
                OPT -Wtrdext                                                    ; re-enable "trdext"

                endmodule

                endif ; ~ _BUILDER_LANGUAGE_PACK_FONT_RUSSIAN_

