
                ifndef _STRUCT_LEVEL_
                define _STRUCT_LEVEL_

                struct FArrayLevels                                             ; 32 элемента * 8 байт
File            FFileName                                                       ; имя файла

                ends

                struct FLevelInfo
Size            FMapSize 0, 0                                                   ; размер карты
Start           FLocation 0, 0                                                  ; координаты центра экрана
                ends

                endif ; ~ _STRUCT_LEVEL_
