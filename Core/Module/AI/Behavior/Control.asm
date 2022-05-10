
                ifndef _CORE_MODULE_AI_BEHAVIOR_CONTROL_
                define _CORE_MODULE_AI_BEHAVIOR_CONTROL_

; -----------------------------------------
; переход к следующему дочернему узлу
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
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
GoToNextChild:  ; 
                LD A, (IX + FUnit.BehaviorTree.Child)
                BIT BTF_LAST_BIT, A
                ; проверка, если узел последний
                ; BIT BTF_LAST_BIT, D
                JR NZ, GoToParent                                               ; узел последний в списке, переход к родительскому узлу

                LD E, A
                
                ifdef DEBUG
                ; проверка переполнения (дебаг онли)
                LD A, E
                OR BT_STATE_MASK
                INC A
                JP C, SFX.BEEP.Fail
                INC E
                else
                ; переход к следующему узлу
                INC E
                endif

                LD A, BTS_UNKNOW
                LD C, E
                JP SetState.Prepared_C

; -----------------------------------------
; запуск первого дочернего узла
; -----------------------------------------
GoToChild:      LD A, E
                JP SetIndex.Prepared_C

; -----------------------------------------
; переход выше по иерархии
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
; -----------------------------------------
GoToParent:     ; проверка, если узел последний
                BIT BTF_ROOT_BIT, E
                JR NZ, .IsRoot                                                  ; родительский узел последний в списке, выход

                ; LD A, E
                ; AND BT_INDEX_MASK
                LD A, C
                XOR E
                AND BT_INDEX_MASK
                XOR E
                LD (IX + FUnit.BehaviorTree.Child), A

                LD A, D
                JP SetIndex.Prepared_C

.IsRoot         ; сброс состояния дерева поведения
                LD A, BTS_UNKNOW
                LD (IX + FUnit.BehaviorTree.Info), A
                XOR A
                LD (IX + FUnit.BehaviorTree.Child), A
                RET

; -----------------------------------------
; установка индекса
; In:
;   A - новое значение [0..63]
; Out:
; Corrupt:
;   C, AF
; Note:
; -----------------------------------------
SetIndex:       LD C, (IX + FUnit.BehaviorTree.Info)

; -----------------------------------------
; установка индекса
; In:
;   A - новое значение [0..63]
;   C - значение состояниея дерева поведения (подготовленое)
;       +----+----+----+----+----+----+----+----+
;       |  7 |  6 |  5 |  4 |  3 |  2 |  1 |  0 |
;       +----+----+----+----+----+----+----+----+
;       | S1 | S0 | P5 | P4 | P3 | P2 | P1 | P0 |
;       +----+----+----+----+----+----+----+----+
;
;   S0, S1  - state execute node
;   P0 - P5 - index
;
; Out:
; Corrupt:
;   AF
; Note:
; -----------------------------------------
.Prepared_C     XOR C
                AND BT_INDEX_MASK
                XOR C
                LD (IX + FUnit.BehaviorTree.Info), A
                RET
SetBTS_RUNNING: LD A, BTS_RUNNING
                JP SetState
SetBTS_UNKNOW:  LD A, BTS_UNKNOW
                JP SetState
SetBTS_FAILURE: LD A, BTS_FAILURE
                JP SetState
SetBTS_SUCCESS: LD A, BTS_SUCCESS
                ; JP SetState
; -----------------------------------------
; установка состояния
; In:
;   A  - новое значение
;       BTS_RUNNING - в процесе выполнения
;       BTS_SUCCESS - успешное выполнение
;       BTS_FAILURE - неудачное выполнение
;       BTS_UNKNOW  - не определено
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
;   C, AF
; Note:
; -----------------------------------------
SetState:       LD C, (IX + FUnit.BehaviorTree.Info)

; -----------------------------------------
; установка состояния
; In:
;   A  - новое значение
;       BTS_RUNNING - в процесе выполнения
;       BTS_SUCCESS - успешное выполнение
;       BTS_FAILURE - неудачное выполнение
;       BTS_UNKNOW  - не определено
;
;   C  - значение состояниея дерева поведения (подготовленое)
;       +----+----+----+----+----+----+----+----+
;       |  7 |  6 |  5 |  4 |  3 |  2 |  1 |  0 |
;       +----+----+----+----+----+----+----+----+
;       | S1 | S0 | P5 | P4 | P3 | P2 | P1 | P0 |
;       +----+----+----+----+----+----+----+----+
;
;   S0, S1  - state execute node
;   P0 - P5 - index
;
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
;   AF
; Note:
; -----------------------------------------
.Prepared_C     XOR C
                AND BT_STATE_MASK
                XOR C
                LD (IX + FUnit.BehaviorTree.Info), A
                RET

                endif ; ~ _CORE_MODULE_AI_BEHAVIOR_CONTROL_
