
                ifndef _MATH_LERP_
                define _MATH_LERP_
; -----------------------------------------
; интерполяция двух 16-битных значений
; In :
;   HL - второе значение
;   BC - первое значение
;   E' - альфа-значений от 0 до 1 [0 .. 255]
; Out :
;   HL - результат
; Corrupt :
;   HL, DE, AF, AF'
; Note:
;   A + Alpha * (B - A)
; -----------------------------------------
Lerp:           ; B - A
                OR A
                SBC HL, BC
                JP P, .IsPositive

                ; NEG HL
                XOR A
                SUB L
                LD L, A
                SBC A, A
                SUB H
                LD H, A

                ; Alpha * (B - A)
                EXX
                LD A, E
                EXX
                EX DE, HL
                CALL Mul16x8_24                                                 ; A:HL

                ; HL == A:HL (остаток отбросить)
                LD L, H
                LD H, A

                ; NEG HL
                XOR A
                SUB L
                LD L, A
                SBC A, A
                SUB H
                LD H, A

                ; A + Alpha * (B - A)
                ADD HL, BC
                RET

.IsPositive     ; Alpha * (B - A)
                EXX
                LD A, E
                EXX
                EX DE, HL
                CALL Mul16x8_24                                                 ; A:HL

                ; HL == A:HL (остаток отбросить)
                LD L, H
                LD H, A

                ; A + Alpha * (B - A)
                ADD HL, BC

                RET

                display " - Lerp 16 : \t\t\t\t", /A, Lerp, " = busy [ ", /D, $ - Lerp, " bytes  ]"

                endif ; ~_MATH_LERP_
