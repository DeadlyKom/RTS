
                ifndef _CORE_MODULE_AI_COMPOSITE_SEQUENCE_
                define _CORE_MODULE_AI_COMPOSITE_SEQUENCE_
; -----------------------------------------
; sequence
; выполняет последовательность задач, до тех пор, пока какая-то из них вернёт неудачу
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
;       C0 - C5 - index child
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
;   BTS_RUNNING - не определено
;   BTS_SUCCESS - переход к следующему дочернему узлу
;   BTS_FAILURE - переход выше по иерархии
;   BTS_UNKNOW  - запуск первого дочернего узла
; -----------------------------------------
Sequence:       LD A, C
                AND BT_STATE_MASK

                ; BTS_RUNNING - не определено
                JP Z, $

                ; BTS_SUCCESS - переход к следующему дочернему узлу
                CP BTS_SUCCESS
                JP Z, GoToNextChild

                ; BTS_FAILURE - переход выше по иерархии
                CP BTS_FAILURE
                JP Z, GoToParent

                ; BTS_UNKNOW  - запуск первого дочернего узла
                JP GoToChild

                endif ; ~ _CORE_MODULE_AI_COMPOSITE_SEQUENCE_
