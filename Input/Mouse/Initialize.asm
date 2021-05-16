
                ifndef _MOUSE_INIT_
                define _MOUSE_INIT_
Initialzie:     CALL GetMouseXY
                INC E
                JR Z, .Error
                INC D
                JR Z, .Error

                CALL GetMouseXY
                LD HL, LastValueFromMousePortX
                LD (HL), E
                INC HL
                LD (HL), D
                ;
                LD HL, 1024 << 3
                LD (MousePositionX), HL
                LD HL, 768 << 3
                LD (MousePositionY), HL
                ;
                OR A
                RET
.Error          SCF
                RET
                
                endif ; ~_MOUSE_INIT_