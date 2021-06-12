
                ifndef _CORE_MODULE_AI_TASK_
                define _CORE_MODULE_AI_TASK_
; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
;   HL, DE, BC, AF, AF'
; -----------------------------------------
TaskExecute:    ; PUSH DE
                ; ; INC HL
                ; LD E, (HL)
                ; INC HL
                ; LD D, (HL)
                ; INC HL
                ; EX (SP), HL
                ; PUSH HL
                ; EX DE, HL
                ; JP (HL)

                ; LD E, (HL)
                LD E, C
                INC HL
                LD D, (HL)
                ; INC HL

                ; EX (SP), HL
                ; POP HL
                ; POP BC
                ; PUSH HL
                ; PUSH BC

                POP BC          ; мусор
                EX (SP), HL
                PUSH HL
                

                EX DE, HL
                JP (HL)

                endif ; ~ _CORE_MODULE_AI_TASK_