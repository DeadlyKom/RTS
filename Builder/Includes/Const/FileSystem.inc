
                ifndef _CONST_FILE_SYSTEM_
                define _CONST_FILE_SYSTEM_
FileSystemPage      EQU 1                                                       ; номер страницы файловой системы

; FFileArea.Info
FILE_ARCHIVE_BIT    EQU 7                                                       ; флаг, архивных данных
FILE_ARCHIVE        EQU 1 << FILE_ARCHIVE_BIT

                endif ; ~_CONST_FILE_SYSTEM_
