
                ifndef _CORE_MODULE_ANIMATION_SPRITE_
                define _CORE_MODULE_ANIMATION_SPRITE_
; ----------------------------------------------------------------------------------------
; расчёт адреса спрайта (для юнитов из 2х частей)
; In:
;   IX - указывает на структуру FUnit
;   флаг переполнения Carry:
;       false - для нижней части юнита
;       true  - для верхней части юнита
; Out:
;   HL - указывает на адрес информации о спрайте
; Corrupt:
;   HL, DE, BC, AF
; Note:
;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
;   | 15 | 14 | 13 | 12 | 11 | 10 |  9 |  8 |   |  7 |  6 |  5 |  4 |  3 |  2 |  1 |  0 |
;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
;   |  0 |  0 |  0 |  0 | T4 | T3 | T2 | T1 |   | T0 | D2 | D1 | D0 | S2 | S1 | S0 |  0 |
;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
;
;   T4-T0 - unit type:
;           000 - Infantry
;           001 - Tank
;           010 -
;   D2-D0 - unit direction:
;           000 - up
;           001 - up-right
;           010 - right
;           011 - down-right
;           100 - down
;           101 - down-left
;           110 - left
;           111 - up-left
;   S2-S0 - unit state:
;           000 - UNIT_STATE_IDLE
;           001 - UNIT_STATE_MOVE
;           010 - UNIT_STATE_ATTACK
;           011 - UNIT_STATE_DEAD
;           100 - UNIT_STATE_MOVE_ATTACK
;           101 - 
;           110 - 
;           111 - 
;
;   анимация идет по порядку, с расчитаного адреса
;
; ----------------------------------------------------------------------------------------
SpriteInfo:     GetUnitState                                                    ; A - хранит состояние юнита
                LD C, A

.Down           ; состояние хранится в рег. С
                LD A, (IX + FUnit.Direction)
                AND DF_DOWN_MASK
                JP .Merger

.Composite      ; конверсия состояния для нижнего/верхнего спрайта
                CALL Utils.Unit.State.GetState                                  ; A - хранит состояние юнита

                RR L
                JR NC, .Down
                
                ; состояние хранится в рег. С
                LD A, (IX + FUnit.Direction)
                AND DF_UP_MASK
                
                ADD A, A        ; << 1
                ADD A, A        ; << 1
                ADD A, A        ; << 1

.Merger         ; слияние состояния и направоление
                ADD A, A        ; << 1
                OR C
                ADD A, A        ; << 1
                LD C, A
                
                ; расчёт смещения по типу
                LD A, (IX + FUnit.Type)
                RRA
                AND IDX_UNIT_TYPE >> 1
                RRA
                RR C
                LD B, A
                LD HL, SpritesTable
                ADD HL, BC                                                      ; HL - указатель структуры спрайта FSprite
                
                ; получение адреса FSprite + Animation
                LD C, (HL)
                INC HL
                LD B, (HL)
                LD A, (IX + FUnit.Animation)
                DEC A
                AND FUAF_ANIMATION_MASK

                LD L, A
                LD H, #00

                ; HL *= 8
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, BC

                RET

                endif ; ~_CORE_MODULE_ANIMATION_SPRITE_
