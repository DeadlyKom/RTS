
                ifndef _BUILDER_LANGUAGE_PACK_FONT_SPANISH_
                define _BUILDER_LANGUAGE_PACK_FONT_SPANISH_

                MMU 3, Page.Spanish                                             ; 3 bank, Page.Language.Spanish page
                ORG Adr.Spanish
                module Spanish

                display "\'Spanish Fonts\' :\t\t\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ]    [", /D, Page.Spanish, "]\t-------------------------------------------------"
Begin:          EQU $

                ; incbin "Core/Module/Sprites/Fonts/En/ASCII_Table.bin"
                ; incbin "Core/Module/Sprites/Fonts/En/ASCII.spr"
                DB #00
                
Size:           EQU $ - Begin
SizeInSectors:  EQU (Size >> 8) + ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01)

                OPT -Wno-trdext                                                 ; disable "trdext"
                savetrd TRD_FILENAME, FontSpNameTRD, Begin, Size
                OPT -Wtrdext                                                    ; re-enable "trdext"

                endmodule

                endif ; ~ _BUILDER_LANGUAGE_PACK_FONT_SPANISH_

