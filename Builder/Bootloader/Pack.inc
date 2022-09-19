
                ifndef _BUILDER_BOOTLOADER_PACK_
                define _BUILDER_BOOTLOADER_PACK_

                MMU 1, 5                                                        ; 1 bank, 5 page
                ORG #4000
                module Bootloader

                display "\'Bootloader\' :\t\t\t---------------------------------------------------------------------------------------------------------"
Begin:          EQU $
                include "Basic.asm"
Size:           EQU $ - Begin

                savetrd TRD_FILENAME, BootNameTRD, Begin, Size

                endmodule

                endif ; ~ _BUILDER_BOOTLOADER_PACK_

