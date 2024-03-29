
                ifndef _CORE_MODULE_ANIMATION_SWITCH_ANIMATION_
                define _CORE_MODULE_ANIMATION_SWITCH_ANIMATION_

; -----------------------------------------
; установка начального кадра анимации
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
;   DE, C, AF
; Note:
; -----------------------------------------
Default:        ; получение начальный кадр анимации
                CALL GetDefault
                AND FUAF_ANIM_DOWN_MASK
                
                ; дублирование состояние для верхней анимации (мб излишне)
                LD C, A
                ADD A, A
                ADD A, A
                OR C
                LD (IX + FUnit.Animation), A

                RET
; ; -----------------------------------------
; ; установка начального кадра анимации
; ; In:
; ;   IX - указывает на структуру FUnit
; ; Out:
; ; Corrupt:
; ;   DE, C, AF
; ; Note:
; ; -----------------------------------------
; DefaultUp:      ; получение начальный кадр анимации
;                 CALL GetDefault
;                 AND FUAF_ANIM_DOWN_MASK
                
;                 ; дублирование состояние для верхней анимации (мб излишне)
;                 ADD A, A
;                 ADD A, A
;                 LD C, A

;                 LD A, (IX + FUnit.Animation)
;                 XOR C
;                 AND FUAF_ANIM_DOWN_MASK
;                 XOR C
;                 LD (IX + FUnit.Animation), A

;                 RET
; ; -----------------------------------------
; ; установка начального кадра анимации
; ; In:
; ;   IX - указывает на структуру FUnit
; ; Out:
; ; Corrupt:
; ;   DE, C, AF
; ; Note:
; ; -----------------------------------------
; DefaultDown:    ; получение начальный кадр анимации
;                 CALL GetDefault
;                 AND FUAF_ANIM_DOWN_MASK
;                 LD C, A
;                 LD A, (IX + FUnit.Animation)
;                 XOR C
;                 AND FUAF_ANIM_UP_MASK
;                 XOR C
;                 LD (IX + FUnit.Animation), A

;                 RET
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
;   DE, C, AF
; Note:
; -----------------------------------------
GetDefault:     GetUnitState                                                    ;   A  - хранит состояние юнита
                RRA
                LD C, A
                
                LD A, (IX + FUnit.Type)
                ADD A, A
                ADD A, A
                XOR C
                AND IDX_UNIT_TYPE << 2
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

                LD DE, AnimCountTable
                ADD A, E
                LD E, A
                JR NC, $+3
                INC D
                LD A, (DE)

                ; проверка чётности адресу (если нечётный сдвигаем на 4 бита вправо)
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
;   включенный флаг переполнения Carry сигнализирует, завершения цикла анимации
; Corrupt:
;   DE, BC, AF
; Note:
; -----------------------------------------
Increment:      BIT COMPOSITE_UNIT_BIT, (IX + FUnit.Type)
                JR NZ, Animation.IncrementUp                                    ; юнит является составным
; -----------------------------------------
; переключится на следующую анимацию
; In:
;   IX - указывает на структуру FUnit
; Out:
;   включенный флаг переполнения Carry сигнализирует, завершения цикла анимации
; Corrupt:
;   DE, BC, AF
; Note:
; -----------------------------------------
IncrementDown:  LD B, (IX + FUnit.Animation)
                LD A, B
                AND FUAF_ANIM_DOWN_MASK
                SUB FUAF_ANIM_DOWN_DECREMENT
                JR NC, .Set

                ; получение первой анимации
                CALL GetDefault
                BIT STOP_INC_BIT, A
                SCF
                RET NZ                                                          ; выход если установлен флаг конечного инкремента анимации

.Set            XOR B
                AND FUAF_ANIM_DOWN_MASK
                XOR B
                LD (IX + FUnit.Animation), A

                OR A
                RET
; -----------------------------------------
; переключится на следующую анимацию
; In:
;   IX - указывает на структуру FUnit
; Out:
;   включенный флаг переполнения Carry сигнализирует, завершения цикла анимации
; Corrupt:
;   DE, BC, AF
; Note:
; -----------------------------------------
IncrementUp:    LD B, (IX + FUnit.Animation)
                LD A, B
                AND FUAF_ANIM_UP_MASK
                SUB FUAF_ANIM_UP_DECREMENT
                JR NC, .Set

                ; получение первой анимации
                CALL GetDefault
                BIT STOP_INC_BIT, A
                SCF
                RET NZ                                                          ; выход если установлен флаг конечного инкремента анимации

                ; A << 2
                ADD A, A
                ADD A, A

.Set            XOR B
                AND FUAF_ANIM_UP_MASK
                XOR B
                LD (IX + FUnit.Animation), A

                OR A
                RET

                endif ; ~_CORE_MODULE_ANIMATION_SWITCH_ANIMATION_
