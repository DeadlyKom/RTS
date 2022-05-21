
                ifndef _CONST_MEMORY_MAP_
                define _CONST_MEMORY_MAP_

; bank 01 (#4000 - #7FFF)
StackTop        EQU MemBank_01                                                  ; расположение стека
MemoryPageRef   EQU PORT_7FFD                                                   ; адрес хранения номера странички

; bank 02 (#8000 - #BFFF)
IntTable        EQU MemBank_02                                                  ; таблица прерываний 257 байт
IntStackBottom  EQU IntTable + IntTableSize                                     ; нижний адрес стека
IntStackTop     EQU IntStackBottom + IntStackSize                               ; верхний адрес стека
Adr.Interrupt   EQU #8181                                                       ; адрес вектора прерывания
Adr.Kernel      EQU Adr.Interrupt                                               ; адрес блока кернела

; bank 03 (#С000 - #СFFF)
Adr.FileSystem  EQU MemBank_03 + BankSize - FileSystem.Size                     ; адрес блока файловой системы

                endif ; ~_CONST_MEMORY_MAP_
