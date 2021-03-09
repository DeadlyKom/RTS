
                ifndef _INPUT_KEYBOARD_CHECK_KEY_STATE_
                define _INPUT_KEYBOARD_CHECK_KEY_STATE_

; -----------------------------------------
; проверить состояние клавиши
; In :
;   A - virtual code
; Out :
;   флаг Z сброшен, если кнопка отжата
; Corrupt :
;   HL, AF
; -----------------------------------------
CheckKeyState:  LD HL, VirtualKeysTable
                ADD A, A
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H
                LD A, (HL)
                LD (.BIT), A
                INC HL
                LD A, (HL)
                IN A, (#FE)
.BIT            EQU $+1
                DB #CB, #00
                RET

                endif ; ~_INPUT_KEYBOARD_CHECK_KEY_STATE_