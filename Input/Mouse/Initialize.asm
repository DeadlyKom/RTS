
                ifndef _MOUSE_INIT_
                define _MOUSE_INIT_
Initialize:     CALL GetMouseXY
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
                LD HL, 256 >> 1
                LD (MousePositionX), HL
                LD HL, 192 >> 1
                LD (MousePositionY), HL
                ;
                OR A
                RET
.Error          SCF
                RET
                
                endif ; ~_MOUSE_INIT_