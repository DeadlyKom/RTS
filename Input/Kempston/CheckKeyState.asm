
                    ifndef _INPUT_KEMPSTON_CHECK_KEY_STATE_
                    define _INPUT_KEMPSTON_CHECK_KEY_STATE_

; -----------------------------------------
; проверить состояние клавиш Kemston
; In :
;   A  - virtual code
;   HL - return address
; Out :
;   флаг Z сброшен, если кнопка отжата
; Corrupt :
;   BC, AF
; -----------------------------------------
CheckKeyState:      RLA
                    RLA
                    RLA
                    AND %00111000
                    OR INSTRUCTION_BIT
                    LD (.BIT), A
                    IN A, (#1F)
                    CPL
.BIT                EQU $+1                 ; BIT n, A
                    DB #CB, #00
                    JP (HL)

                    endif ; ~_INPUT_KEMPSTON_CHECK_KEY_STATE_