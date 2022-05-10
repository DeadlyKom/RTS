
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
SetIDLE:        LD C, (IX + FUnit.State)

                ; проверка установки этого же состояния
                LD A, C
                AND UNIT_STATE_MASK
                CP UNIT_STATE_IDLE
                RET Z

                ; смена состояния
                LD A, C
                AND UNIT_STATE_INV_MASK
                OR UNIT_STATE_IDLE
                LD (IX + FUnit.State), A
                RET
                ; JP Animation.Default

; -----------------------------------------
; установить состояние перемещения юнита
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
;   AF
; Note:
; -----------------------------------------
SetMOVE:        LD C, (IX + FUnit.State)
                
                ; проверка установки этого же состояния
                LD A, C
                AND UNIT_STATE_MASK
                CP UNIT_STATE_MOVE
                RET Z

                ; смена состояния
                LD A, C
.Set            AND UNIT_STATE_INV_MASK
                OR UNIT_STATE_MOVE
                LD (IX + FUnit.State), A
                ; JP Animation.Default
                RET

; AddMOVE:        LD C, (IX + FUnit.State)
;                 LD A, C
;                 XOR UNIT_STATE_ATTACK
;                 AND UNIT_STATE_MASK
;                 LD A, C
;                 JR NZ, SetMOVE.Set
;                 AND UNIT_STATE_INV_MASK
;                 OR UNIT_STATE_MOVE_ATTACK
;                 LD (IX + FUnit.State), A
;                 RET

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
SetATTACK:      ; проверка установки этого же состояния
                LD C, (IX + FUnit.State)
                LD A, C
                AND UNIT_STATE_MASK
                CP UNIT_STATE_ATTACK
                RET Z

                ; смена состояния
                LD A, C
                AND UNIT_STATE_INV_MASK
                OR UNIT_STATE_ATTACK
                LD (IX + FUnit.State), A
                ; JP Animation.Default
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
SetDEAD:        ; проверка установки этого же состояния
                LD C, (IX + FUnit.State)
                LD A, C
                AND UNIT_STATE_MASK
                CP UNIT_STATE_DEAD
                RET Z

                ; смена состояния
                LD A, C
                AND UNIT_STATE_INV_MASK
                OR UNIT_STATE_DEAD
                LD (IX + FUnit.State), A
                ; JP Animation.Default
                RET

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_UNIT_SET_STATE_