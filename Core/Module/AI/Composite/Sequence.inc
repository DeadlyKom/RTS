
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
                JP (IY)
PostSequence:   POP HL
                RET NC
                EX AF, AF'
                INC HL
                LD A, (HL)
                OR A
                JR Z, .RET
                PUSH HL
                ; interruption can corrupt the values, so restore the return point
                ; DEC SP
                ; DEC SP
                LD DE, PostSequence
                PUSH DE
                JP (IY)
                
.RET            EX AF, AF'
                RET

                endif ; ~ _CORE_MODULE_AI_COMPOSITE_SEQUENCE_