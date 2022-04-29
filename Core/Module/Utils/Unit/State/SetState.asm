
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
                OR UNIT_STATE_IDLE
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
.Set            AND UNIT_STATE_INV_MASK
                OR UNIT_STATE_MOVE
                LD (IX + FUnit.State), A
                RET
AddMOVE:        LD C, (IX + FUnit.State)
                LD A, C
                XOR UNIT_STATE_ATTACK
                AND UNIT_STATE_MASK
                LD A, C
                JR NZ, SetMOVE.Set
                AND UNIT_STATE_INV_MASK
                OR UNIT_STATE_MOVE_ATTACK
                LD (IX + FUnit.State), A
                RET

                ; ; проверка что юнит составной
                ; BIT COMPOSITE_UNIT_BIT, (IX + FUnit.Type)
                ; JR Z, .NotComposite                                             ; юнит не является составным

                ; BIT FUAF_TURN_MOVE_BIT, (IX + FUnit.Flags)                      ; бит принадлежности CounterDown (0 - поворот, 1 - перемещение)
                ; JR NZ, .IsMoveTo                                                ; счётчик указывает на перемещение

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
                OR UNIT_STATE_ATTACK
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
                OR UNIT_STATE_DEAD
                LD (IX + FUnit.State), A
                RET

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_UNIT_SET_STATE_