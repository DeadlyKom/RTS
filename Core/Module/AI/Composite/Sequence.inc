
                ifndef _CORE_MODULE_AI_COMPOSITE_SEQUENCE_
                define _CORE_MODULE_AI_COMPOSITE_SEQUENCE_
; -----------------------------------------
; Sequence
; выполняет последовательность задачь, до тех пор, пока какая-то из них вернёт неудачу
; In:
; Out:
; Corrupt:
;   HL, DE, BC, AF, AF'
; -----------------------------------------
; PreSequence:    INC HL
;                 LD B, #00
;                 ADD HL, BC
;                 LD DE, Sequence
Sequence:       PUSH DE                     ; сохраним адрес перехода родительского обработчика
                PUSH HL
.Continue       LD DE, PostSequence
                LD A, (HL)
                INC HL
                LD C, (HL)
                LD B, #00
                ADD HL, BC
                AND %11000000
                JP Z, Selector              ; BT_SELECTOR
                SUB #40
                JP Z, Sequence              ; BT_SEQUENCE
                SUB #40
                JR Z, TaskExecute           ; BT_TASK
                ; BT_BREAK
                POP HL
                RET

; .PreTaskExecute LD DE, PostSequence
;                 PUSH DE
;                 JP TaskExecute
PostSequence:   POP HL
                ; INC HL
                ; INC HL
                JR NC, Sequence.Continue
                RET

                endif ; ~ _CORE_MODULE_AI_COMPOSITE_SEQUENCE_