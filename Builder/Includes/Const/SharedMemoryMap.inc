
                ifndef _CONST_SHARED_MEMORY_MAP_
                define _CONST_SHARED_MEMORY_MAP_

MemBank_01      EQU #4000 + #1B00                                               ; Bank 01 (Screen 0) (пропуск экрана)
MemBank_01_DOS  EQU MemBank_01 + #0500                                          ; Bank 01 (Screen 0) (пропуск экрана и 0x500 байт данных для TR DOS)
MemBank_02      EQU #8000                                                       ; Bank 02 (16384 байт)
SharedBuffer    EQU #BD00                                                       ; Bank 02 (адрес общего буфера)                     - 256 байт
RenderBuffer    EQU #BE00                                                       ; Bank 02 (адрес буфера обновлений)                 - 192 байта                     [64] заняты буфером выбора и WayPoint'ами
TilemapBuffer   EQU #BF00                                                       ; Bank 02 (адрес тайловой карты буфера)             - 256 байт
MemBank_03      EQU #C000                                                       ; Bank 03 (16384 байт)
BankSize        EQU #4000                                                       ; размер банка (16384 байт)

                endif ; ~_CONST_SHARED_MEMORY_MAP_
