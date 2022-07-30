    
                ifndef _BUILDER_PACK_
                define _BUILDER_PACK_

                emptytrd TRD_FILENAME

                display "Packing..."

                include "Bootloader/Pack.inc"                                   ; упаковка boot загрузчика      (1)
                include "Kernel/Pack.inc"                                       ; упаковка кернеля              (2)
                include "FileSystem/Pack.inc"                                   ; упаковка файловой системы     (3)
                include "Game/Pack.inc"                                         ; упаковка игрового кода
                include "Language/Pack.inc"                                     ; упаковка языков
                include "Loader/Pack.inc"                                       ; упаковка загрузчика
                include "Menu/Pack.inc"                                         ; упаковка меню

                display "-------------------------------------------------------------------------------------------------------------------------------"

                labelslist "C:/Work/spectrum/unreal/user.l"

                endif ; ~_BUILDER_PACK_
