
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
; Corrupt:
; Note:
; -----------------------------------------
IsIDLE:         LD A, (IX + FUnit.State)
                AND UNIT_STATE_MASK
                CP UNIT_STATE_IDLE << 1
                RET

; -----------------------------------------
; проверить что юнит в состояние перемещения
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
IsMOVE:         LD A, (IX + FUnit.State)
                AND UNIT_STATE_MASK
                CP UNIT_STATE_MOVE << 1
                RET

; -----------------------------------------
; проверить что юнит в состояние атаки
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
IsATTACK:       LD A, (IX + FUnit.State)
                AND UNIT_STATE_MASK
                CP UNIT_STATE_ATTACK << 1
                RET

                endmodule

GetUnitState:   macro
                LD A, (IX + FUnit.State)
                AND UNIT_STATE_MASK
                endm

                endif ; ~ _CORE_MODULE_UTILS_UNIT_GET_STATE_