
                ifndef _MEMORY_COPY_PAGES_
                define _MEMORY_COPY_PAGES_

                module Memcpy
Begin:          EQU $
; -----------------------------------------
; копирование данных между страниц
; In:
;   A  - страница исходного кода
;   A' - страница назначения
;   HL - адрес буфера (мб со смещением)
;   DE - адрес назначения
;   BC - длина блока (неболее 256 байт)
; Out:
; Corrupt:
; Note:
; копирование из общего буфера SharedBuffer
; -----------------------------------------
Pages:          PUSH AF
                EX AF, AF'
                PUSH BC
                CALL SetPage
                POP BC
                LDIR
                POP AF
                JP SetPage

                display " - Memcpy Pages : \t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~_MEMORY_COPY_PAGES_
