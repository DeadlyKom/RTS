
                ifndef _CORE_MODULE_AI_COMPOSITE_HANDLER_
                define _CORE_MODULE_AI_COMPOSITE_HANDLER_

; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
;   HL, DE, BC, AF, AF'
; -----------------------------------------
HandlerRoot:    LD DE, .RET
                PUSH DE
                LD DE, .Continue
.Next           LD A, (HL)
                AND %11000000
                JR Z, .Back
                INC HL
                LD C, (HL)
                PUSH HL
                PUSH DE
                ; AND %11000000
                SUB #40
                JP Z, AI.Composite.Selector         ; BT_SELECTOR
                SUB #40
                JP Z, AI.Composite.Sequence         ; BT_SEQUENCE
                ; SUB #40
                JP AI.Composite.TaskExecute         ; BT_TASK
                ; BT_BREAK
                ; EX (SP), HL

.RET            RET
.Back           ; POP HL
                ; INC HL
                ; EX (SP), HL
                ; PUSH HL
                RET

.Continue       POP HL
                INC HL
                JR .Next

                endif ; ~ _CORE_MODULE_AI_COMPOSITE_HANDLER_