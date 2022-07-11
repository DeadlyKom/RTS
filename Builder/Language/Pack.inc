
                ifndef _BUILDER_LANGUAGE_PACK_
                define _BUILDER_LANGUAGE_PACK_

                include "Language.inc"

                include "Font/Include.inc"                                      ; упаковка шрифтов

                MMU 3, Page.Module.Language                                     ; 3 bank, Page.Language page
                ORG Adr.Module.Language
                module Language

                
                display "\'Language\' :\t\t\t-------------------- [ ", /D, Size, " bytes / ", /D, SizeInSectors, " sector(s) ] \t-------------------------------------------------"
Begin:          EQU $
                include "Core/Module/Language/Include.inc"
Size:           EQU $ - Begin
SizeInSectors:  EQU (Size >> 8) + ((Size % TRDOS.SECTOR_SIZE > 0) & 0x01)

                savetrd TRD_FILENAME, LanguageNameTRD, Begin, Size

                include "Text/Include.inc"                                      ; упаковка текста
                endmodule

                endif ; ~ _BUILDER_LANGUAGE_PACK_

