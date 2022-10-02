
                ifndef _MATH_MULTIPLY_INTEGER_16x8_24
                define _MATH_MULTIPLY_INTEGER_16x8_24
; -----------------------------------------
; integer multiplies DE by A
; In :
;   DE - multiplicand
;   A  - multiplier
; Out :
;   AHL - product DE * A
; Corrupt :
;   HL, AF
; Note:
;   http://map.grauw.nl/sources/external/z80bits.html#1.2
; -----------------------------------------
Mul16x8_24:     LD HL, #0000
                ADD A, A
                JR NC, $+4+1                                                    ; пропустим ADD HL, HL т.к. HL равен нулю, сдвиг не требуется
                LD H, D
                LD L, E
                
                ; unroll
                rept 7
                ADD HL, HL
                ADC A, A
                JR NC, $+5
                ADD HL, DE
                ADC A, #00
                endr
                
                RET

                display " - Multiply 16x8 : \t\t\t", /A, Mul16x8_24, " = busy [ ", /D, $ - Mul16x8_24, " bytes  ]"

                endif ; ~_MATH_MULTIPLY_INTEGER_16x8_24
