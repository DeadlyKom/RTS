
                ifndef _MEMORY_COPY_PAGES_
                define _MEMORY_COPY_PAGES_
; -----------------------------------------
; копирование данных между страничек
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
BetweenPages:   PUSH AF
                EX AF, AF'
                PUSH BC
                CALL Memory.SetPage
                POP BC
                LDIR
                POP AF
                JP Memory.SetPage

                endif ; ~_MEMORY_COPY_PAGES_