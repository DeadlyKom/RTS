
                ifndef _CONST_INTERRUPT_
                define _CONST_INTERRUPT_
IntTableSize    EQU 257                                                         ; размер таблицы прерывания
IntStackSize    EQU 64 * 2                                                      ; размер стека прерывания

                endif ; ~_CONST_INTERRUPT_