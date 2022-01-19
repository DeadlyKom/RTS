
                ifndef _CORE_MODULE_UTILS_UNIT_SET_STATE_
                define _CORE_MODULE_UTILS_UNIT_SET_STATE_

                module State
; -----------------------------------------
; установить состояние юнита
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Set:            RET

; -----------------------------------------
; установить состояние бездействия юнита
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
;   AF
; Note:
; -----------------------------------------
SetIDLE:        LD A, (IX + FUnit.State)
                AND UNIT_STATE_INV_MASK
                OR UNIT_STATE_IDLE << 1
                LD (IX + FUnit.State), A
                RET

; -----------------------------------------
; установить состояние перемещения юнита
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
;   AF
; Note:
; -----------------------------------------
SetMOVE:        LD A, (IX + FUnit.State)
                AND UNIT_STATE_INV_MASK
                OR UNIT_STATE_MOVE << 1
                LD (IX + FUnit.State), A
                RET
; -----------------------------------------
; установить состояние атаки юнита
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
;   AF
; Note:
; -----------------------------------------
SetATTACK:      LD A, (IX + FUnit.State)
                AND UNIT_STATE_INV_MASK
                OR UNIT_STATE_ATTACK << 1
                LD (IX + FUnit.State), A
                RET
; -----------------------------------------
; установить состояние атаки мёртв
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
;   AF
; Note:
; -----------------------------------------
SetDEAD:        LD A, (IX + FUnit.State)
                AND UNIT_STATE_INV_MASK
                OR UNIT_STATE_DEAD << 1
                LD (IX + FUnit.State), A
                RET

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_UNIT_SET_STATE_