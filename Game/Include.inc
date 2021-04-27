
                            ifndef _GAME_INCLUDE_
                            define _GAME_INCLUDE_

                            include "../Config.inc"
                            include "Color.inc"
                            include "../Core/Macro.inc"
                    
                            define TRD_FILENAME "RTS.trd"       ; имя образа TRD
StackTop                    EQU #5BFD                           ; расположение стека
MemoryPagePtr               EQU #5BFE                           ; адрес хранения номера странички
InterruptVectorAddress      EQU #5B00                           ; адрес вектора прерывания
InterruptVectorAddressFrame EQU InterruptVectorAddress + #FF    ; 
TileMap                     EQU #D000                           ; адрес тайловой карты
TimeOfDayChangeRate         EQU 50 * 60                         ; скорость смены времени дня

TilesOnScreenX              EQU 16                              ; количество тайлов на экране по горизонтали
TileOnScreenY               EQU 12                              ; количество тайлов на экране по вертикали

                            endif ; ~_GAME_INCLUDE_
