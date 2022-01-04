
                ifndef _CORE_MODULE_AI_COMPOSITE_HANDLER_
                define _CORE_MODULE_AI_COMPOSITE_HANDLER_

; -----------------------------------------
; запуск behavior tree
; In:
;   HL - адрес дерева поведения
; Out:
; Corrupt:
;   HL, DE, BC, AF, AF', IY
; -----------------------------------------
RunBTT:         LD IY, .Next
.Next           LD A, (HL)
                INC HL
                LD C, (HL)
                RLA
                JP C, AI.Composite.Selector                                     ; BT_SELECTOR
                RLA
                JP C, AI.Composite.Sequence                                     ; BT_SEQUENCE
                JP AI.Composite.TaskExecute                                     ; BT_TASK

                endif ; ~ _CORE_MODULE_AI_COMPOSITE_HANDLER_