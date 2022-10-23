
                ifndef _INPUT_MOUSE_INITIALIZE_
                define _INPUT_MOUSE_INITIALIZE_
; -----------------------------------------
; инициализация кемпстон мыши
; In :
; Out :
;   флаг переполнения Carry сброшен, если считываются данные из портов
; Corrupt :
;   HL, E, BC, AF
; -----------------------------------------
Initialize:     ; установке значений по умолчанию (центр экрана)
                LD HL, (96 << 8) | 128
                LD (Position), HL

                ;проверка наличия мыши
                CALL GetMouseXY
                INC E
                JR Z, .Error
                INC D
                JR Z, .Error

                CALL GetMouseXY
                LD HL, LastValue.FromMousePortX
                LD (HL), E
                INC HL
                LD (HL), D

                OR A
                RET

.Error          SCF
                RET
                
                endif ; ~_INPUT_MOUSE_INITIALIZE_