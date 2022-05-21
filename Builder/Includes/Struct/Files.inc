
                ifndef _STRUCT_FILES_
                define _STRUCT_FILES_

                struct FFile
Name            TEXT 8, {"", 32}                                                ; имя файла
Extension       DB 'X'                                                          ; расширение файла
                ends

                struct FFileArea
File            FFile                                                           ; данные файла
;
;      7    6    5    4    3    2    1    0
;   +----+----+----+----+----+----+----+----+
;   | AR | .. | .. | .. | .. | P2 | P1 | P0 |
;   +----+----+----+----+----+----+----+----+
;
;   AR    - [7]     - флаг архивных данных
;   P2-P0 - [2-0]   - номер страницы
;
Info            DB #00                                                          ; данные файла
Address         DW FValue                                                       ; адрес расположения файла
                ends

                endif ; ~_STRUCT_FILES_
