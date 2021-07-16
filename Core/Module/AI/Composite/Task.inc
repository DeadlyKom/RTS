
                ifndef _CORE_MODULE_AI_TASK_
                define _CORE_MODULE_AI_TASK_
; -----------------------------------------
; task executor
; In:
; Out:
; Corrupt:
;   HL, DE, BC, AF, AF'
; -----------------------------------------
TaskExecute:    LD E, C
                INC HL
                LD D, (HL)

                POP BC
                EX (SP), HL
                PUSH BC

                EX DE, HL
                JP (HL)

                endif ; ~ _CORE_MODULE_AI_TASK_