
                    ifndef _INPUT_KEYBOARD_PRESSED_KEY_STATE_
                    define _INPUT_KEYBOARD_PRESSED_KEY_STATE_
; -----------------------------------------
; получить Virtual Key нажатой клавиши  
; In:
; Out:
;   если была нажата клавиша флаг переполнения Carry установлен,
;   регистре E хранится Virtual Key, в противном случае флаг cброшен
; Corrupt:
;   DE, BC, AF, AF'
; Note:
;   SerdjukSVS (C)
; -----------------------------------------
GetPressedKey:  LD DE, #0500
                LD BC, #FEFE
.NextPort       IN A, (C)
                CPL
.NextBit        RRA
                RET C
                INC E
                DEC D
                JR NZ, .NextBit
                RLC B
                RET NC
                LD D, #05
                JR .NextPort
WaitPressedKey: HALT
                CALL GetPressedKey
                RET C
                JR WaitPressedKey
WaitReleasedKey HALT
                CALL GetPressedKey
                RET NC
                JR WaitReleasedKey

                endif ; ~_INPUT_KEYBOARD_PRESSED_KEY_STATE_
