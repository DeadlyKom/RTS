
                ifndef _STRUCT_FILES_
                define _STRUCT_FILES_

                struct FFile
Name            TEXT 8, {"", 32}                                                       ; имя файла
Extension       DB 'X'                                                          ; расширение файла
                ends

                struct FFileArea
File            FFile                                                           ; данные файла
;
;      7    6    5    4    3    2    1    0
;   +----+----+----+----+----+----+----+----+
;   | .. | .. | .. | .. | P2 | P1 | P0 | AR |
;   +----+----+----+----+----+----+----+----+
;
;   AR    - [0]     - флаг архивных данных
;   P2-P0 - [1-2]   - номер страницы
;
Data            DB #00                                                          ; данные файла
Address         DW #0000                                                        ; адрес расположения файла
                ends

                endif ; ~_STRUCT_FILES_
