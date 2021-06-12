
                ifndef _CORE_MODULE_AI_COMPOSITE_SEQUENCE_
                define _CORE_MODULE_AI_COMPOSITE_SEQUENCE_
; -----------------------------------------
; sequence
; выполняет последовательность задачь, до тех пор, пока какая-то из них вернёт неудачу
; In:
; Out:
; Corrupt:
;   HL, DE, BC, AF, AF'
; -----------------------------------------
Sequence:       PUSH HL
                LD B, #00
                ADD HL, BC
                
                LD DE, PostSequence
                PUSH DE
                JP AI.HandlerRoot.Next

PostSequence:   POP HL
                RET NC
                EX AF, AF'
                INC HL
                LD A, (HL)
                AND %11000000
                JR NZ, .L1
                EX AF, AF'
                RET
.L1             PUSH HL
                DEC SP
                DEC SP
                JP AI.HandlerRoot.Next

                endif ; ~ _CORE_MODULE_AI_COMPOSITE_SEQUENCE_