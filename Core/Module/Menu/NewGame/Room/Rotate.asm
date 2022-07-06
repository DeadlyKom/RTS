
                ifndef _CORE_MODULE_MENU_MAIN_NEW_GAME_ROOM_ROTATE_
                define _CORE_MODULE_MENU_MAIN_NEW_GAME_ROOM_ROTATE_

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
                RET

.IsPositive     ; ограничение
                LD A, (HL)

                CP FRAME_CENTER
                JR Z, StopRotate

                JR SetCountdown

.RightRotate    LD HL, Frame
                INC (HL)
                LD A, (HL)
                CP FRAME_MAX
                JR NZ, .IsLess

                DEC (HL)
                RET

                ; ограничение
.IsLess         CP FRAME_CENTER
                JR Z, StopRotate
                
SetCountdown:   LD HL, Flags
                SET COUNTDOWN_BIT, (HL)
                JP DrawFrame

StopRotate:     LD HL, Flags
                RES REQ_ROTATE_BIT, (HL)
                JP DrawFrame

                endif ; ~ _CORE_MODULE_MENU_MAIN_NEW_GAME_ROOM_ROTATE_
