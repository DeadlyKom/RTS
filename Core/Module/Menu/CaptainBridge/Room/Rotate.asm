
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_ROOM_ROTATE_
                define _CORE_MODULE_CAPTAIN_BRIDGE_ROOM_ROTATE_

LeftRotate:     LD HL, Flags
                RES ROTATE_BIT, (HL)
                SET REQ_ROTATE_BIT, (HL)
                RET

RightRotate:    LD HL, Flags
                SET ROTATE_BIT, (HL)
                SET REQ_ROTATE_BIT, (HL)
                RET

NextFrame:      LD HL, Flags
                BIT COMPLETED_BIT, (HL)
                RET Z

                BIT ROTATE_BIT, (HL)
                JR NZ, .RightRotate

.LeftRotate     LD HL, Frame
                DEC (HL)
                JP P, .IsPositive

                INC (HL)

                LD A, LEFT
                LD (Number), A

                RET

.IsPositive     ; ограничение
                LD A, (HL)

                CP FRAME_CENTER
                LD A, CENTER
                JR Z, StopRotate

                JR SetCountdown

.RightRotate    LD HL, Frame
                INC (HL)
                LD A, (HL)
                CP FRAME_MAX
                JR NZ, .IsLess

                DEC (HL)

                LD A, RIGHT
                LD (Number), A

                RET

                ; ограничение
.IsLess         CP FRAME_CENTER
                LD A, CENTER
                JR Z, StopRotate
                
SetCountdown:   ;
                LD A, ROTATE
                LD (Number), A

                ;
                LD HL, Flags
                SET COUNTDOWN_BIT, (HL)
                
                JP DrawFrame

StopRotate:     LD (Number), A

                LD HL, Flags
                RES REQ_ROTATE_BIT, (HL)
                JP DrawFrame

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_ROOM_ROTATE_
