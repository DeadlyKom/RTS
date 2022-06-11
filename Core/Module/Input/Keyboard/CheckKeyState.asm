
                    ifndef _INPUT_KEYBOARD_CHECK_KEY_STATE_
                    define _INPUT_KEYBOARD_CHECK_KEY_STATE_
; -----------------------------------------
; проверить состояние клавиши
; In :
;   A  - virtual code
;   HL - return address
; Out :
;   флаг Z сброшен, если кнопка отжата
; Corrupt :
;   BC, AF
; -----------------------------------------
CheckKeyState:      LD BC, VirtualKeysTable
                    ADD A, A
                    ADD A, C
                    LD C, A
                    JR NC, $+3
                    INC B
                    LD A, (BC)
                    LD (.BIT), A
                    INC BC
                    LD A, (BC)
                    IN A, (#FE)
.BIT                EQU $+1                 ; BIT n, A
                    DB #CB, #00
                    JP (HL)

                    endif ; ~_INPUT_KEYBOARD_CHECK_KEY_STATE_
