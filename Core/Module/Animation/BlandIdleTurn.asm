
                ifndef _CORE_MODULE_ANIMATION_BLAND_IDLE_TURN_
                define _CORE_MODULE_ANIMATION_BLAND_IDLE_TURN_

; -----------------------------------------
; In:
;   IX - pointer to FUnitState (1)
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
Idle:               ;
                    CALL Utils.Math.Rand8
                    CP #10                                                      ; чем меньше тем чаще происходит поворот
                    RET NC
                    EX AF, AF'                                                  ; сохраним рандомное число

                    INC IXH                                                     ; FSpriteLocation   (2)
                    INC IXH                                                     ; FUnitTargets      (3)
                    INC IXH                                                     ; FUnitAnimation    (4)
                    
                    LD A, (IX + FUnitAnimation.CounterDown)
                    LD C, A
                    AND FUAF_IDLE_COUNT_MASK
                    SUB %00100000
                    JR C, .Turn

                    ;
                    LD A, C
                    SUB %00100000
                    LD (IX + FUnitAnimation.CounterDown), A

                    ; завершение работы
                    DEC IXH                                                     ; FUnitTargets      (3)
                    DEC IXH                                                     ; FSpriteLocation   (2)
                    DEC IXH                                                     ; FUnitState        (1)

                    RET
                    
.Turn               ;
                    LD A, C
                    AND FUAF_IDLE_COUNT_MASK_INV
                    OR FUAF_IDLE_COUNT_MASK
                    LD (IX + FUnitAnimation.CounterDown), A

                    ; завершение работы
                    DEC IXH                                                     ; FUnitTargets      (3)
                    DEC IXH                                                     ; FSpriteLocation   (2)
                    DEC IXH                                                     ; FUnitState        (1)
                    
                    ;
                    LD A, (IX + FUnitState.Direction)
                    RRA
                    RRA
                    RRA
                    AND %00000111
                    LD C, A                                                     ; сохраним текущий поворот

                    EX AF, AF'                                                  ; востановим рандомное число
                    RRA

                    SBC A, A                                                    ; < 4 = -1, > 4 = 0
                    CCF
                    ADC A, #00

                    CALL Animation.TurnDown

                    RET


                    endif ; ~_CORE_MODULE_ANIMATION_BLAND_IDLE_TURN_
