
                ifndef _CORE_MODULE_INTERRUPT_INITIALIZE_
                define _CORE_MODULE_INTERRUPT_INITIALIZE_

                module Interrupt
; -----------------------------------------
; инициализация прерывания
; In:
; Out:
; Corrupt:
; Note:
;   код для встраивания (не вызова)
; -----------------------------------------
Initialize:     ; **** INITIALIZE HANDLER IM 2 ****

                ; формирование таблицы прерывания
                LD HL, IntTable
                LD DE, IntTable + 1
                LD BC, IntTableSize - 1
                LD (HL), HIGH Adr.Interrupt
                LDIR
                
                ; очистка стека прерывания
                INC L
                INC E
                LD (HL), C
                LD BC, IntStackSize - 1
                LDIR

                ; задание вектора прерывания
                LD A, HIGH Adr.Interrupt - 1
                LD I, A
                IM 2

                EI
                HALT
                ; ~ INITIALIZE HANDLER IM 2

                endmodule

                endif ; ~ _CORE_MODULE_INTERRUPT_INITIALIZE_
