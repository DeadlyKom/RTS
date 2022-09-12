
                ifndef _CONST_SHARED_MEMORY_MAP_
                define _CONST_SHARED_MEMORY_MAP_

MemBank_01_SCR  EQU #4000                                                       ; Bank 01 (Screen 0)
ScreenSize      EQU #1B00                                                       ; размер экрана
MemBank_01      EQU #4000 + ScreenSize                                          ; Bank 01 (Screen 0) (пропуск экрана)
MemBank_01_DOS  EQU MemBank_01 + #0500                                          ; Bank 01 (Screen 0) (пропуск экрана и 0x500 байт данных для TR DOS)
MemBank_02      EQU #8000                                                       ; Bank 02 (16384 байт)
MemBank_03      EQU #C000                                                       ; Bank 03 (16384 байт)
MemBank_03_SCR  EQU #C000                                                       ; Bank 03 (Screen 1)
MemBank_03_     EQU #C000 + ScreenSize                                          ; Bank 03 (16384 байт) (пропуск экрана)
BankSize        EQU #4000                                                       ; размер банка (16384 байт)

                endif ; ~_CONST_SHARED_MEMORY_MAP_
