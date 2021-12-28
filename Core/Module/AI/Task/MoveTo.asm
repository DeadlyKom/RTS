
                ifndef _CORE_MODULE_AI_TASK_MOVE_TO_
                define _CORE_MODULE_AI_TASK_MOVE_TO_

; -----------------------------------------
; перемещение к цели
; In:
;   IX - pointer to FUnitState (1)
; Out:
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
MoveTo:         SET FUSF_MOVE_BIT, (IX + FUnitState.State)                      ; установка состояния перемещения/поворота

                CALL Animation.MoveDown
                CCF
                RET C                                                           ; время ещё не вышло, но возвращаем успешное перемещение

                INC IXH                                                         ; FSpriteLocation     (2)

                LD E, IXL
                LD D, IXH
                INC E
                INC E
                LD (ShiftLocation.UnitOffset), DE
                
                INC IXH                                                         ; FUnitTargets      (3)

                CALL Utils.GetPerfectTargetDelta                                ; calculate direction delta
                JP NC, .Fail                                                    ; неудачая точка назначения

                ; ---------------------------------------------
                ; IX - pointer to FSpriteLocation (2)
                ; D = dY (signed)
                ; E = dX (signed)
                ; ---------------------------------------------

                INC IXH                                                         ; FUnitTargets      (3)

                LD A, E
                OR D
                JR Z, .Complite

                INC IXH                                                         ; FUnitAnimation    (4)

                ; проверить необходимость повторной инициализации счетчика после хода
                LD C, (IX + FUnitAnimation.Flags)
                RR C
                CALL NC, .Init                                                  ; переинициализировать, если флаг FUAF_TURN_MOVE сброшен

                ; при необходимости изменить знак dY
                XOR A
                LD B, A                                                         ; reset register B
                SUB D
                JP M, $+4
                LD D, A

                ; при необходимости изменить знак dX
                XOR A
                SUB E
                JP M, $+4
                LD E, A

                ; ---------------------------------------------
                ; D = |dY|
                ; E = |dX|
                ; ---------------------------------------------

                LD L, #2C

                ; dX < dY ?
                LD A, E
                CP D
                JR C, .SkipSwap_dX_dY                                           ; if dX < dY, then the base axis dY
                
                ; dX <=> dY (swap)
                LD E, D
                LD D, A

                LD L, B                                                         ; L = 0

                ; sing dX <=> sign dY (swap)
                SRL C
                RES 1, C
                JR NC, $+4
                SET 1, C
                  
.SkipSwap_dX_dY INC E

                ;
                LD A, (IX + FUnitAnimation.Delta)
                OR A
                JR NZ, $+3
                LD A, D
                EX AF, AF'

                LD A, L
                LD (ShiftLocation.dX_dY), A
                
                ;
                RR C
                SBC A, A
                CCF
                ADC A, B

                CALL ShiftLocation

                EX AF, AF'
                SUB E

                JR NC, .PreExit
                EX AF, AF'

                LD A, L
                XOR #2C
                LD (ShiftLocation.dX_dY), A

                ;
                RR C
                SBC A, A
                CCF
                ADC A, B

                CALL ShiftLocation

                EX AF, AF'
                ADD A, D
                
.PreExit        ;
                LD (IX + FUnitAnimation.Delta), A

                ; A - номер юнита
                LD A, IXL
                RRA
                RRA
                AND %00111111
                CALL Unit.RefUnitOnScr

.Exit           ; завершение работы
                DEC IXH                                                         ; FUnitTargets      (3)
                DEC IXH                                                         ; FSpriteLocation   (2)
                DEC IXH                                                         ; FUnitState        (1)

                ; LD A, (TickCounterRef)
                ; RRA
                ; JR NC, $+5
                INC (IX + FUnitState.Animation)
                ; INC A
                ; AND %00111000
                ; LD (IX + FUnitState.Animation), A

                SCF                                                             ; успешность выполнения
                RET

                ; ---------------------------------------------
                ; юнит дошёл до текущего Way Point
                ; ---------------------------------------------
                ; IX - pointer to FUnitTargets      (3)
                ; ---------------------------------------------
.Complite       DEC IXH                                                         ; FSpriteLocation   (2)
                LD HL, Utils.Tilemap.Radius_5
                CALL Utils.Tilemap.Reconnaissance
                INC IXH                                                         ; FUnitTargets      (3)

                INC IXH                                                         ; FUnitAnimation    (4)
                RES FUAF_TURN_MOVE, (IX + FUnitAnimation.Flags)                 ; необходимо переинициализировать анимацию перемещения
                DEC IXH                                                         ; FUnitTargets      (3)

                RES FUTF_VALID_WP_BIT, (IX + FUnitTargets.Data)                 ; сброс текущего Way Point
                DEC IXH                                                         ; FSpriteLocation   (2)
                DEC IXH                                                         ; FUnitState        (1)

                RES FUSF_MOVE_BIT, (IX + FUnitState.State)                      ; сброс состояния перемещения/поворота

                SCF                                                             ; успешность выполнения
                RET

.Fail           DEC IXH                                                         ; FUnitState        (1)
                RES FUSF_MOVE_BIT, (IX + FUnitState.State)                      ; сброс состояния перемещения/поворота
                JR $
                OR A                                                            ; неудачное выполнение
                RET

.Init           ; ---------------------------------------------
                ; IX - pointer to FUnitAnimation (4)
                ; D - dY
                ; E - dX
                ; ---------------------------------------------
                
                LD C, #00
                
                ; знак dX
                LD A, E
                RLA
                RL C                                                            ; FUAF_X

                ; знак dY
                LD A, D
                RLA
                RL C                                                            ; FUAF_Y

                ; FUAF_TURN_MOVE
                SCF                                                             ; установка бита принадлежности CounterDown (0 - поворот, 1 - перемещение)
                RL C

                ;
                LD A, FUAF_MOVE_MASK
                AND (IX + FUnitAnimation.Flags)
                OR C
                LD (IX + FUnitAnimation.Flags), A

                RR C                                                            ; skip FUAF_TURN_MOVE

                ; сброс дельты
                XOR A
                LD (IX + FUnitAnimation.Delta), A

                RET

; ---------------------------------------------
; A - delta move (-1/1)
; ---------------------------------------------
ShiftLocation:  ;
                EXX

.UnitOffset     EQU $+1
                LD HL, #0000

.dX_dY          NOP                                                             ; NOP/INC HL    (NOP - x, INC L - y)

                ADD A, (HL)
                JP M, .Negative

                CP 8
                JR NC, .NextCell
                
                LD (HL), A
                EXX
                RET

.NextCell       ;
                LD (HL), -8
                DEC L
                DEC L
                INC (HL)
                DEC IXH                                                         ; FUnitTargets      (3)
                DEC IXH                                                         ; FSpriteLocation     (2)
                LD HL, Utils.Tilemap.Radius_3
                CALL Utils.Tilemap.Reconnaissance
                INC IXH                                                         ; FUnitTargets      (3)
                INC IXH                                                         ; FUnitAnimation    (4)
                EXX

                RET

.Negative       CP -9
                JR Z, .PrevCell
                
                LD (HL), A
                EXX
                RET

.PrevCell       ;
                LD (HL), 7
                DEC L
                DEC L
                DEC (HL)
                DEC IXH                                                         ; FUnitTargets      (3)
                DEC IXH                                                         ; FSpriteLocation     (2)
                LD HL, Utils.Tilemap.Radius_3
                CALL Utils.Tilemap.Reconnaissance
                INC IXH                                                         ; FUnitTargets      (3)
                INC IXH                                                         ; FUnitAnimation    (4)
                EXX

                RET

                endif ; ~_CORE_MODULE_AI_TASK_MOVE_TO_
