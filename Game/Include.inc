
                            ifndef _GAME_INCLUDE_
                            define _GAME_INCLUDE_

                            include "../Config.inc"
                    
                            define TRD_FILENAME "RTS.trd"       ; имя образа TRD
StackTop                    EQU #BFFE                           ; расположение стека
InterruptVectorAddress      EQU #BF00                           ; адрес вектора прерывания
InterruptVectorAddressFrame EQU InterruptVectorAddress + #FF    ; 

                            endif ; ~_GAME_INCLUDE_
