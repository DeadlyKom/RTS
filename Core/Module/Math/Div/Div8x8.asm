
                ifndef _MATH_DIVISION_8_8_
                define _MATH_DIVISION_8_8_

                module Math
; -----------------------------------------
; integer 8-bit divides D by E
; In :
;   D - dividend
;   E - divider
; Out :
;   D - division result
;   A - remainder
; Corrupt :
;   B, AF
; Note:
;   https://www.smspower.org/Development/DivMod
; -----------------------------------------
Div8x8:         XOR A
                LD B, #08
.Loop           SLA D
                RLA
                CP E
                JR C, .Less
                SUB E
                INC D
.Less           DJNZ .Loop

                RET

                display " - Divide 8x8 : \t\t", /A, Div8x8, " = busy [ ", /D, $ - Div8x8, " bytes  ]"

                endmodule

                endif ; ~_MATH_DIVISION_8_8_
