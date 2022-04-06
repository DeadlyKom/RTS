
                ifndef _CORE_MODULE_AI_COMPOSITE_HANDLER_
                define _CORE_MODULE_AI_COMPOSITE_HANDLER_
; -----------------------------------------
; запуск behavior tree
; In:
;   HL - адрес дерева поведения
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
;   HL, DE, BC, AF, AF', IY
; -----------------------------------------
RunBTT:         
                ; JR$

                LD IY, .Next
                
.Next           RET
;                 LD IY, .Next
; .Next           LD D, HIGH Selector
;                 LD E, (HL)
;                 INC HL
;                 EX DE, HL
;                 JP (HL)
; .Exit           POP AF
;                 POP AF
;                 RET

; Selector:       PUSH DE
;                 EX DE, HL
;                 LD DE, .PostSelector
;                 PUSH DE
;                 JP (IY)

; .PostSelector   POP HL
;                 RET C

;                 INC HL
;                 PUSH HL
;                 LD DE, .PostSelector
;                 PUSH DE
;                 JP (IY)

; Sequence:       PUSH DE
;                 EX DE, HL
;                 LD DE, .PostSequence
;                 PUSH DE
;                 JP (IY)

; .PostSequence   POP HL
;                 RET NC

;                 INC HL
;                 PUSH HL
;                 LD DE, .PostSequence
;                 PUSH DE
;                 JP (IY)

; Nested:         EX DE, HL
;                 POP BC
;                 EX (SP), HL
;                 PUSH BC
;                 INC HL
;                 LD B, #00
;                 LD C, (HL)
;                 ADD HL, BC
;                 JP (IY)
; Task:           EX DE, HL
;                 LD E, (HL)
;                 INC HL
;                 LD D, (HL)
                
;                 POP BC
;                 EX (SP), HL
;                 PUSH BC

;                 EX DE, HL
;                 JP (HL)

;                 if ($ >> 8) - (RunBTT >> 8)
;                 error "all code must be within one 256-bit block"
;                 endif

                endif ; ~ _CORE_MODULE_AI_COMPOSITE_HANDLER_