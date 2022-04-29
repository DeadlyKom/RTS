
                ifndef _CORE_MODULE_UTILS_UNIT_GET_STATE_
                define _CORE_MODULE_UTILS_UNIT_GET_STATE_

                module State
; -----------------------------------------
; проверить состояние юнита
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Check:          RET
; -----------------------------------------
; проверить что юнит в состояние бездействия
; In:
;   IX - указывает на структуру FUnit
; Out:
;   если флаг нуля Z сброшен, юнитв в состоянии бездействия
; Corrupt:
;   AF
; Note:
; -----------------------------------------
IsIDLE:         LD A, (IX + FUnit.State)
                AND UNIT_STATE_MASK
                CP UNIT_STATE_IDLE
                RET
; -----------------------------------------
; проверить что юнит в состояние перемещения
; In:
;   IX - указывает на структуру FUnit
; Out:
;   если флаг нуля Z сброшен, юнитв в состоянии перемещения
; Corrupt:
;   AF
; Note:
; -----------------------------------------
IsMOVE:         LD A, (IX + FUnit.State)
                AND UNIT_STATE_MASK
                CP UNIT_STATE_MOVE
                RET
; -----------------------------------------
; проверить что юнит в состояние мёртв
; In:
;   IX - указывает на структуру FUnit
; Out:
;   если флаг нуля Z сброшен, юнитв в состоянии мёртв
; Corrupt:
;   AF
; Note:
; -----------------------------------------
IsDEAD:         LD A, (IX + FUnit.State)
                AND UNIT_STATE_MASK
                CP UNIT_STATE_DEAD
                RET
; -----------------------------------------
; проверить что юнит в состояние атаки
; In:
;   IX - указывает на структуру FUnit
; Out:
;   если флаг нуля Z сброшен, юнитв в состоянии атаки
; Corrupt:
;   AF
; Note:
; -----------------------------------------
IsATTACK:       LD A, (IX + FUnit.State)
                AND UNIT_STATE_MASK
                CP UNIT_STATE_ATTACK
                RET
; -----------------------------------------
; макрос получения состояния юнита
; In:
;   IX - указывает на структуру FUnit
; Out:
;   A  - хранит состояние юнита
;   +----+----+----+----+----+----+----+----+
;   |  7 |  6 |  5 |  4 |  3 |  2 |  1 |  0 |
;   +----+----+----+----+----+----+----+----+
;   |  0 |  0 |  0 |  0 | S2 | S1 | S0 |  0 |
;   +----+----+----+----+----+----+----+----+
;
;   S2-S0 - unit state:
;       000 - UNIT_STATE_IDLE
;       001 - UNIT_STATE_MOVE
;       010 - UNIT_STATE_ATTACK
;       011 - UNIT_STATE_DEAD
;       100 - UNIT_STATE_MOVE_ATTACK
;       101 - 
;       110 - 
;       111 - 
; Corrupt:
;   AF
; Note:
; -----------------------------------------
GetUnitState:   macro
                LD A, (IX + FUnit.State)
                AND UNIT_STATE_MASK
                endm

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_UNIT_GET_STATE_