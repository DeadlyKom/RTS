
                ifndef _CONST_FILE_SYSTEM_
                define _CONST_FILE_SYSTEM_

                define FileSystemFunc SetPage1

                module Size
                module Module
FileSystem:     EQU FileSystem.Size                                             ; размер блока файловой системы

                endmodule
                endmodule

                module Page
                module Module
FileSystem      EQU 0x01                                                        ; номер страницы файловой системы

                endmodule
                endmodule

                module Adr
                module Module
FileSystem:     EQU MemBank_03 + BankSize - FileSystem.Size                     ; адрес блока файловой системы

                endmodule
                endmodule

; FFileArea.Info
FILE_ARCHIVE_BIT EQU 7                                                          ; флаг, архивных данных
FILE_ARCHIVE    EQU 1 << FILE_ARCHIVE_BIT

                endif ; ~_CONST_FILE_SYSTEM_
