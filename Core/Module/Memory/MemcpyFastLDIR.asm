
                ifndef _MEMORY_COPY_FAST_LDIR_
                define _MEMORY_COPY_FAST_LDIR_

                module Memcpy
; -----------------------------------------
; копирование данных
; In:
;   HL - адрес буфера
;   DE - адрес назначения
;   BC - длина блока
; Out:
; Corrupt:
;   HL, DE, BC, AF
; Note:
; копирование эффективно, если размер блока > 18 байт
; -----------------------------------------
FastLDIR:       LD A, B
                OR C
                RET Z
                XOR A
                SUB C
                AND #3F
                ADD A, A
                LD (.Jump), A
.Jump           EQU $+1
                JR NZ, .Loop
.Loop           rept 64
                LDI
                endr
                JP PE, .Loop

                RET

                display " - Memcpy Fast LDIR : \t\t\t\t", /A, FastLDIR, " = busy [ ", /D, $ - FastLDIR, " bytes  ]"
                
                endmodule

                endif ; ~_MEMORY_COPY_FAST_LDIR_