
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
                
                LD DE, PostSelector
                PUSH DE
                JP (IY)
PostSelector:   POP HL
                RET C
                EX AF, AF'
                INC HL
                LD A, (HL)
                OR A
                JR Z, .RET
                PUSH HL
                DEC SP
                DEC SP
                JP (IY)
                
.RET            EX AF, AF'
                RET

                endif ; ~ _CORE_MODULE_AI_COMPOSITE_SELECTOR_