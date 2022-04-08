
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
RunBTT:         ; JR$

                ; копирование адреса начала дерева поведения (для верхнего массива)
                LD D, H
                LD E, L

                ; применение предыдущего исполненого узла
                LD B, #00
                LD C, (IX + FBehaviorTree.Index)
                ADD HL, BC

                ; расчёт адреса родительского узла
                LD C, (HL)
                SLL C
                EX AF, AF'                                                      ; сохранение флага (последний в списке)
                EX DE, HL
                DEC B
                ADD HL, BC

                ; переход к обработчику узла
                LD B, (HL)
                DEC HL
                LD C, (HL)
                LD A, BTT_MASK
                AND C
                ADD A, A
                ADD A, A
                LD (.Jump), A
.Jump           EQU $+1
                JR $

                ; переход к selector'у
                JP Selector
                DB #00

                ; переход к sequence'у
                JP Sequence
                DB #00

                ; переход к task'е
                JP Task
                DB #00

                ; звуковое оповещение об ошибке
                ifdef DEBUG
                JP SFX.BEEP.Fail
                endif

; -----------------------------------------
; selector
; выполняет последовательность узлов, пока какая-то из них не вернёт успешное выполнение
; In:
;   BC - значение из верхнего массива
;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
;   | 15 | 14 | 13 | 12 | 11 | 10 |  9 |  8 |   |  7 |  6 |  5 |  4 |  3 |  2 |  1 |  0 |
;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
;   | C6 | C5 | C4 | C3 | C2 | C1 | C0 | P6 |   | P5 | P4 | P3 | P2 | P1 | P0 | T1 | T0 |
;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
;
;   C6-C0 - child index value
;   P6-P0 - parent index value
;   T1,T0 - node type
;
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; -----------------------------------------
Selector:       LD A, (IX + FBehaviorTree.State)
                CP BTS_UNKNOW
                JP Z, GoToChild
                CP BTS_SUCCESS
                JP Z, GoToParent
                CP BTS_FAILURE
                JP Z, GoToNextChild


                RET
Sequence:       RET
Task:           RET

GoToChild:      SRL B
                LD (IX + FBehaviorTree.Index), B
                RET
GoToNextChild:  ; проверка, что узел не последний
                EX AF, AF'                                                      ; востановление флага (последний в списке)
                JR C, GoToParent                                                ; узел последний в списке, переход к родительскому узлу

                ; переход к следующему узлу
                INC (IX + FBehaviorTree.Index)
                RET
GoToParent:     SRL B
                LD A, C
                RRA
                SRL A
                LD (IX + FBehaviorTree.Index), A
                RET

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