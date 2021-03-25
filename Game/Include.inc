
                            ifndef _GAME_INCLUDE_
                            define _GAME_INCLUDE_

                            include "../Config.inc"
                    
                            define TRD_FILENAME "RTS.trd"       ; имя образа TRD
StackTop                    EQU #5BFE                           ; расположение стека
InterruptVectorAddress      EQU #5B00                           ; адрес вектора прерывания
InterruptVectorAddressFrame EQU InterruptVectorAddress + #FF    ; 
TileMap:                    EQU #7000                           ; адрес тайловой карты

                            endif ; ~_GAME_INCLUDE_
