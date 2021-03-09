
                            ifndef _GAME_INCLUDE_
                            define _GAME_INCLUDE_
                    
                            define TRD_FILENAME "RTS.trd"       ; имя образа TRD
EntryPointer                EQU #6001                           ; главная точка входа
StackTop                    EQU #5FFE                           ; расположение стека
InterruptVectorAddress      EQU #5F00                           ; адрес вектора прерывания
InterruptVectorAddressFrame EQU InterruptVectorAddress + #FF    ; 

                            endif ; ~_GAME_INCLUDE_
