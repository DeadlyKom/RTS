
                ifndef _CONST_MEMORY_MAP_
                define _CONST_MEMORY_MAP_

; bank 01 (#4000 - #7FFF)
StackTop        EQU MemBank_01_DOS                                              ; расположение стека
GameConfigRef   EQU #5B00                                                       ; адрес хранения FConfig
MemoryPageRef   EQU PORT_7FFD                                                   ; адрес хранения номера странички
LocalizationRef EQU #7FFE                                                       ; адрес хранения указателя таблицы текста локализации
LoaderBuffer    EQU Adr.Loader + Adr.Loader.Size                                ; адрес буфера загрузчика

; bank 02 (#8000 - #BFFF)
Adr:
.Interrupt      EQU #8181                                                       ; адрес вектора прерывания
.Kernel         EQU Adr.Interrupt                                               ; адрес блока кернела

; bank 03 (#С000 - #СFFF)
Adr.Screens     EQU MemBank_03_SCR                                              ; адрес экранов 5/7

                endif ; ~_CONST_MEMORY_MAP_
