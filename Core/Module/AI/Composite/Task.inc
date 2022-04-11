
                ifndef _CORE_MODULE_AI_TASK_
                define _CORE_MODULE_AI_TASK_
; -----------------------------------------
; task executor
; выполняет задачу
; In:
;   DE - значение
;       +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
;       | 15 | 14 | 13 | 12 | 11 | 10 |  9 |  8 |   |  7 |  6 |  5 |  4 |  3 |  2 |  1 |  0 |
;       +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
;       | T1 | T0 | P5 | P4 | P3 | P2 | P1 | P0 |   | F1 | F0 | C5 | C4 | C3 | C2 | C1 | C0 |
;       +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
;
;       T0, T1  - node type
;       F0, F1  - internal flags of behavior tree
;       N0 - N5 - number task
;       P0 - P5 - index parent
;
;   C  - состояние
;       +----+----+----+----+----+----+----+----+
;       |  7 |  6 |  5 |  4 |  3 |  2 |  1 |  0 |
;       +----+----+----+----+----+----+----+----+
;       | S1 | S0 | P5 | P4 | P3 | P2 | P1 | P0 |
;       +----+----+----+----+----+----+----+----+
;
;       S0, S1  - state execute node
;       P0 - P5 - index
;
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
;   BTS_RUNNING - в процесе выполнения
;   BTS_SUCCESS - успешное выполнение
;   BTS_FAILURE - неудачное выполнение
;   BTS_UNKNOW  - первичный запуск задачи
; -----------------------------------------
Task:           LD A, C
                AND BT_STATE_MASK

                ; BTS_RUNNING - продолжить выполнение
                JP Z, .Continue

                ; BTS_SUCCESS - переход выше по иерархии
                CP BTS_SUCCESS
                JP Z, GoToParent

                ; BTS_FAILURE - переход к следующему дочернему узлу
                CP BTS_FAILURE
                JP Z, GoToParent

                ; BTS_UNKNOW  - первичный запуск задачи
                
.Continue       ; расчёт адреса задачи
                LD HL, Table
                LD A, E
                AND BT_TASK_MASK
                ADD A, A
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H

                ; чтение адреса задачи
                LD A, (HL)
                INC HL
                LD H, (HL)
                LD L, A
                JP (HL)

                endif ; ~ _CORE_MODULE_AI_TASK_