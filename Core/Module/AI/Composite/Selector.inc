
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
; PreSelector:    ; INC HL
;                 LD B, #00
;                 ADD HL, BC
; ;                 ; LD DE, Selector
; Selector:       PUSH DE                     ; сохраним адрес перехода родительского обработчика
;                 PUSH HL
; .Continue       LD DE, PostSelector
;                 LD A, (HL)
;                 INC HL
;                 LD C, (HL)
;                 LD B, #00
;                 ADD HL, BC
;                 AND %11000000
;                 JP Z, Selector              ; BT_SELECTOR
;                 SUB #40
;                 JP Z, Sequence              ; BT_SEQUENCE
;                 SUB #40
;                 JR Z, TaskExecute           ; BT_TASK
;                 ; BT_BREAK
;                 POP HL
;                 RET

; ; .PreSequence    LD DE, PostSelector
; ;                 PUSH DE
; ;                 JP Selector

; ; .PreTaskExecute LD HL, PostSelector
; ;                 PUSH HL
; ;                 JP TaskExecute

Selector:       LD A, C
                OR A
                JR Z, .End
                LD B, #00
                ADD HL, BC
                LD DE, PostSelector
                JP AI.HandlerRoot.Next
.End            POP HL
                INC HL
                POP DE
                ; LD DE, PostSelector
                JP AI.HandlerRoot.Next
                

PostSelector:   POP HL
                INC HL
                LD DE, PostSelector
                JP NC, AI.HandlerRoot.Next
                JR $
                ; JR NC, Selector.Continue
                RET

                endif ; ~ _CORE_MODULE_AI_COMPOSITE_SELECTOR_