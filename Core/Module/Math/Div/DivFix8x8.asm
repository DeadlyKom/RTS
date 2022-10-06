
                ifndef _MATH_DIVISION_FIX_8_8_
                define _MATH_DIVISION_FIX_8_8_

                module Math
; -----------------------------------------
; деление A/D
; In :
;   A - делимое
;   C - делитель
; Out :
;   DE - результат (D - целое, E - дробная часть)
; Corrupt :
;   B, F
; Note:
; -----------------------------------------
DivFix8x8:      EX AF, AF'                                                      ; сохранение делимого

                ; обнуление регистров
                XOR A
                LD H, A
                LD L, A
                LD D, A
                LD E, A
                LD B, A

                ; проверка делителя на 0
                LD A, C
                OR A
                RET Z

                LD A, #10                                                       ; 16 битное деление

.Loop           EX AF, AF'                                                      ; востановление делимого
                RLA
                RL L
                RL H
                SBC HL, BC
                JR NC, .NotOverflow

                ADD HL, BC
.NotOverflow    CCF
                RL E
                RL D

.Next           EX AF, AF'
                DEC A
                JR NZ, .Loop
                RET

                display " - Divide Fix 8x8 : \t\t\t\t\t", /A, DivFix8x8, " = busy [ ", /D, $ - DivFix8x8, " bytes  ]"

                endmodule

                endif ; ~_MATH_DIVISION_FIX_8_8_
