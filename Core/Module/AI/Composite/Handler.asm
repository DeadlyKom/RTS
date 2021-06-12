
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
.Next           LD A, (HL)
                AND %11000000
                INC HL
                LD C, (HL)
                SUB #40
                JP Z, AI.Composite.Selector         ; BT_SELECTOR
                SUB #40
                JP Z, AI.Composite.Sequence         ; BT_SEQUENCE
                JP AI.Composite.TaskExecute         ; BT_TASK
.RET            RET

                endif ; ~ _CORE_MODULE_AI_COMPOSITE_HANDLER_