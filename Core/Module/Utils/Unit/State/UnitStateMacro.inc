
                ifndef _CORE_MODULE_UTILS_UNIT_STATE_MACRO_
                define _CORE_MODULE_UTILS_UNIT_STATE_MACRO_

; -----------------------------------------
; проверка состояния объекта "бездействие"
; In:
;   IX - указывает на структуру FUnit
; Out:
;   флаг нуля Z сброшен, если объект бездействует
; Corrupt:
;   AF
; Note:
; -----------------------------------------
UNIT_IsIdle:    macro
                LD A, (IX + FUnit.State)                                        ; чтение флагов
                AND UNIT_STATE_MASK
                endm

; -----------------------------------------
; проверка состояния объекта "в движении"
; In:
;   IX - указывает на структуру FUnit
; Out:
;   флаг нуля Z установлен, если объект движется
; Corrupt:
;   AF
; Note:
; -----------------------------------------
UNIT_IsMove:    macro Reg?
                BIT UNIT_STATE_MOVE_FLY_BIT, Reg?                               ; проверка флага перемещения 
                endm
; -----------------------------------------
; проверка состояния объекта "атакует"
; In:
;   IX - указывает на структуру FUnit
; Out:
;   флаг нуля Z установлен, если объект атакует
; Corrupt:
;   AF
; Note:
; -----------------------------------------
UNIT_IsAttack:  macro Reg?
                BIT UNIT_STATE_ATTACK_BIT, Reg?                                 ; проверка флага атаки 
                endm

                endif ; ~ _CORE_MODULE_UTILS_UNIT_STATE_MACRO_
