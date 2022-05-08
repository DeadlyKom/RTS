
                ifndef _CORE_MODULE_AI_TASK_MOVE_TO_
                define _CORE_MODULE_AI_TASK_MOVE_TO_

; -----------------------------------------
; перемещение к цели
; In:
;   IX - указывает на структуру FUnit
; Out:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
MoveTo:         CALL Utils.Unit.State.SetMOVE                                   ; установка состояния перемещения/поворота

                ; вызов счётчика анимации перемещения
                CALL Animation.MoveDown
                CCF
                JR C, .Progress                                                 ; время ещё не вышло, но возвращаем успешное перемещение

                ; расчёт смещения в структуре FUnit.Offset
                LD A, IXL
                ADD A, FUnit.Offset
                LD E, A
                LD D, IXH
                LD (ShiftLocation.UnitOffset), DE

                ; расчёт дельты направления
                CALL Utils.GetPerfectTargetDelta
                JP NC, .Fail                                                    ; неудачая точка назначения

                ; ---------------------------------------------
                ; D = dY (signed)
                ; E = dX (signed)
                ; ---------------------------------------------

                LD A, E
                OR D
                JR Z, .Complite

                ; проверить необходимость повторной инициализации счетчика после хода
                LD C, (IX + FUnit.Flags)
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
                LD A, (IX + FUnit.Delta)
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
                LD (IX + FUnit.Delta), A

                SET FUSE_RECONNAISSANCE_BIT, (IX + FUnit.State)                 ; необходимо произвести разведку
                CALL Unit.RefUnitOnScr                                          ; обновление облости
                CALL Animation.IncrementDown                                    ; увеличение счётчика анимации (нижний)
.Progress       JP AI.SetBTS_RUNNING                                            ; в процессе выполнения

.Complite       ; ---------------------------------------------
                ; юнит дошёл до текущего Way Point
                ; ---------------------------------------------

                LD HL, Utils.Unit.Tilemap.Radius_5
                CALL Utils.Unit.Tilemap.ConstReconnaissance

                RES FUAF_TURN_MOVE_BIT, (IX + FUnit.Flags)                      ; необходимо переинициализировать анимацию перемещения
                RES FUTF_VALID_WP_BIT, (IX + FUnit.Data)                        ; сброс текущего Way Point
                ; CALL Utils.Unit.State.SetIDLE                                   ; установка состояния юнита в Idle

.Success        ; успешность выполнения
                JP AI.SetBTS_SUCCESS

.Fail           CALL Utils.Unit.State.SetIDLE                                   ; установка состояния юнита в Idle
                CALL SFX.BEEP.Fail                                              ; неудачая точка назначения

                ; неудачное выполнение
                JP AI.SetBTS_FAILURE

.Init           ; ---------------------------------------------
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
                AND (IX + FUnit.Flags)
                OR C
                LD (IX + FUnit.Flags), A

                RR C                                                            ; skip FUAF_TURN_MOVE

                ; сброс дельты
                XOR A
                LD (IX + FUnit.Delta), A

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
                LD HL, Utils.Unit.Tilemap.Radius_3
                CALL Utils.Unit.Tilemap.ConstReconnaissance
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
                LD HL, Utils.Unit.Tilemap.Radius_3
                CALL Utils.Unit.Tilemap.ConstReconnaissance
                EXX

                RET

                endif ; ~_CORE_MODULE_AI_TASK_MOVE_TO_
