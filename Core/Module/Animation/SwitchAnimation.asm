
                ifndef _CORE_MODULE_ANIMATION_SWITCH_ANIMATION_
                define _CORE_MODULE_ANIMATION_SWITCH_ANIMATION_

; -----------------------------------------
; получение начальный кадр анимации
; In:
;   IX - указывает на структуру FUnit
; Out:
;   A - начальный кадр анимации
;   +----+----+----+----+----+----+----+----+
;   |  7 |  6 |  5 |  4 |  3 |  2 |  1 |  0 |
;   +----+----+----+----+----+----+----+----+
;   | .. | .. | .. | .. | SD | SI | C1 | C0 |
;   +----+----+----+----+----+----+----+----+
;
;   SD    - стоп бит декркмента
;   SI    - стоп бит инкремента
;   C1,C0 - количество анимаций
;            * 00 - две анимации 
;            * 01 - три анимации
;            * 10 - четыре анимации
;            * 11 - количество анимации не определено
; Corrupt:
; Note:
; -----------------------------------------
GetDefault:     GetUnitState                                                    ;   A  - хранит состояние юнита
                RRA
                LD C, A
                
                LD A, (IX + FUnit.Type)
                ADD A, A
                ADD A, A
                XOR C
                AND IDX_UNIT_TYPE << 1
                XOR C
                LD C, A
                RRA

                ;   +----+----+----+----+----+----+----+----+
                ;   |  7 |  6 |  5 |  4 |  3 |  2 |  1 |  0 |
                ;   +----+----+----+----+----+----+----+----+
                ;   | T4 | T3 | T2 | T1 | T0 | S2 | S1 | S0 |
                ;   +----+----+----+----+----+----+----+----+
                ;
                ;   T4-T0: тип юнита
                ;           0 - Infantry
                ;           1 - Tank
                ;           2 -
                ;           3 -
                ;   S2-S0: состояние юнита:
                ;           0 - UNIT_STATE_IDLE
                ;           1 - UNIT_STATE_MOVE
                ;           2 - UNIT_STATE_ATTACK
                ;           3 - UNIT_STATE_DEAD
                ;           4 -
                ;           5 -
                ;           6 - 
                ;           7 -

                LD HL, AnimCountTable
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H
                LD A, (HL)

                RR C
                RET NC

                RRA
                RRA
                RRA
                RRA

                RET

; -----------------------------------------
; переключится на следующую анимацию
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
IncrementDown:  LD A, (IX + FUnit.Animation)
                DEC A
                JR NZ, .Set

                CALL GetDefault
                
                BIT STOP_INC_BIT, A
                RET NZ

                AND FUAF_ANIMATION_MASK
                ADD A, #02
.Set            LD (IX + FUnit.Animation), A

                RET
; -----------------------------------------
; установка начального кадра анимации
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Default:        ; получение начальный кадр анимации
                CALL GetDefault
                AND FUAF_ANIMATION_MASK
                ADD A, #02
                LD (IX + FUnit.Animation), A

                RET

                endif ; ~_CORE_MODULE_ANIMATION_SWITCH_ANIMATION_