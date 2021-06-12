
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
                LD A, (HL)
                INC HL
                LD C, (HL)
                ; INC HL
                ; PUSH HL
                LD B, #00
                ADD HL, BC
                AND %11000000
                JP Z, AI.Composite.Selector      ; BT_SELECTOR
                SUB #40
                JP Z, AI.Composite.Sequence         ; BT_SEQUENCE
                SUB #40
                JP Z, AI.Composite.TaskExecute      ; BT_TASK
.RET            RET                                 ; BT_BREAK

                endif ; ~ _CORE_MODULE_AI_COMPOSITE_HANDLER_