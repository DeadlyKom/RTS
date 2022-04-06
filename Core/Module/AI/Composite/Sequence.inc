
                ifndef _CORE_MODULE_AI_COMPOSITE_SEQUENCE_
                define _CORE_MODULE_AI_COMPOSITE_SEQUENCE_
; -----------------------------------------
; sequence
; выполняет последовательность задач, до тех пор, пока какая-то из них вернёт неудачу
; In:
; Out:
; Corrupt:
;   HL, DE, BC, AF, AF'
; -----------------------------------------
Sequence:       PUSH HL
                LD B, #00
                ADD HL, BC

                ; LD A, (HL)
                ; OR A
                ; JR Z, PostSequence
                
                LD DE, PostSequence
                PUSH DE
                JP (IY)
PostSequence:   POP HL
                RET NC
                INC HL
                LD A, (HL)
                OR A
                RET Z

                RRA
                JR C, $+4
                JP (IY)

                PUSH HL
                ; interruption can corrupt the values, so restore the return point
                ; DEC SP
                ; DEC SP
                LD DE, PostSequence
                PUSH DE
                JP (IY)

                endif ; ~ _CORE_MODULE_AI_COMPOSITE_SEQUENCE_