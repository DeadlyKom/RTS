
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
                JP AI.HandlerRoot.Next

PostSelector:   POP HL
                EX AF, AF'
                RET C
                EX AF, AF'
                INC HL
                LD A, (HL)
                AND %11000000
                RET Z
                PUSH HL
                DEC SP
                DEC SP
                JP AI.HandlerRoot.Next

                endif ; ~ _CORE_MODULE_AI_COMPOSITE_SELECTOR_