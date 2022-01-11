
                ifndef _CORE_MODULE_AI_COMPOSITE_SELECTOR_
                define _CORE_MODULE_AI_COMPOSITE_SELECTOR_
; -----------------------------------------
; selector
; выполняет последовательность задачь, пока какая-то из них не вернёт успешное выполнение
; In:
; Out:
; Corrupt:
;   HL, DE, BC, AF, AF'
; -----------------------------------------
Selector:       PUSH HL
                LD B, #00
                ADD HL, BC

                LD A, (HL)
                OR A
                JR Z, PostSelector
                
                LD DE, PostSelector
                PUSH DE
                JP (IY)
PostSelector:   POP HL
                RET C
                ; EX AF, AF'
                INC HL
                LD A, (HL)
                OR A
                ; JR Z, .RET
                RET Z
                PUSH HL
                ; interruption can corrupt the values, so restore the return point
                ; DEC SP
                ; DEC SP
                LD DE, PostSelector
                PUSH DE
                JP (IY)
                
; .RET            EX AF, AF'
;                 RET

                endif ; ~ _CORE_MODULE_AI_COMPOSITE_SELECTOR_