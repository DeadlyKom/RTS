
                ifndef _CORE_MODULE_AI_COMPOSITE_HANDLER_
                define _CORE_MODULE_AI_COMPOSITE_HANDLER_

; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
;   HL, DE, BC, AF, AF'
; -----------------------------------------
HandlerRoot:    LD IY, .Next
.Next           LD A, (HL)
                INC HL
                LD C, (HL)
                RLA
                JP C, AI.Composite.Selector         ; BT_SELECTOR
                RLA
                JP C, AI.Composite.Sequence         ; BT_SEQUENCE
                JP AI.Composite.TaskExecute         ; BT_TASK
.RET            RET

                endif ; ~ _CORE_MODULE_AI_COMPOSITE_HANDLER_