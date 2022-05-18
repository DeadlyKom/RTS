
                ifndef _CONST_FILE_SYSTEM_
                define _CONST_FILE_SYSTEM_
FileSystemPage  EQU 1                                                           ; номер страницы файловой системы

; FFileArea.
FILE_ARCHIVE_BIT EQU 1                                                          ; флаг архивных данных
FILE_ARCHIVE    EQU 1 << FILE_ARCHIVE_BIT
FILE_PAGE_SHIFT EQU 1                                                           ; смещение номера страницы

                endif ; ~_CONST_FILE_SYSTEM_
