
                ifndef _CORE_MODULE_ANIMATION_SPRITE_
                define _CORE_MODULE_ANIMATION_SPRITE_

; ----------------------------------------------------------------------------------------
; sprite address calculation
; In:
;   IX - указывает на структуру FUnit
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
;             0 - Infantry
;             1 - 
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
;           00 - idle
;           01 - move
;           10 - attack
;           11 - ?
;
;   the animation goes in order, from the current address
;
; ----------------------------------------------------------------------------------------
SpriteInfo:     ; расчёт только нижнего (верхний не учитывается)
                
                ; LD A, (IX + FUnit.State)
                ; AND FUSF_MOVE | FUSF_ATTACK
                ; GetUnitState
                LD A, (IX + FUnit.State)
                AND UNIT_STATE_MASK

                LD C, A

                LD A, (IX + FUnit.Direction)
                AND DF_DOWN_MASK
                ADD A, A        ; << 1
                OR C
                ADD A, A        ; << 1
                LD C, A
                
                LD A, (IX + FUnit.Type)
                RRA
                AND IDX_UNIT_TYPE >> 1
                RRA
                RR C
                ; RRA
                ; OR A
                ; RRA
                ; RR C
                ; RRA
                ; RR C
                LD B, A
                LD HL, SpritesTable
                ADD HL, BC                                                      ; HL - указатель структуры спрайта FSprite

                ToDo "SpriteInfo", "make 2 levels of animation indices"
                
                ; получение адреса FSprite + Animation
                LD C, (HL)
                INC HL
                LD B, (HL)
                LD A, (IX + FUnit.Animation)
                AND %00000011
                LD L, A
                LD H, #00

                ; HL *= 8
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, BC

                RET

                endif ; ~_CORE_MODULE_ANIMATION_SPRITE_
