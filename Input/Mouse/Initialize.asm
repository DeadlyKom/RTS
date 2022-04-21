
                ifndef _MOUSE_INIT_
                define _MOUSE_INIT_
Initialize:     ; set default value cursor position
                LD HL, 128 + 10 | (96 - 20) <<8;(192 >> 1) << 8 | (256 >> 1)
                LD (Position), HL

                ; detected kempston mouse
                CALL GetMouseXY
                INC E
                JR Z, .Error
                INC D
                JR Z, .Error

                CALL GetMouseXY
                LD HL, LastValueFromMousePortX
                LD (HL), E
                INC HL
                LD (HL), D

                OR A
                RET

.Error          SCF
                RET
                
                endif ; ~_MOUSE_INIT_