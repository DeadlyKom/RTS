
                ifndef _CORE_MODULE_AI_TASK_MOVE_TO_
                define _CORE_MODULE_AI_TASK_MOVE_TO_

; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
MoveTo:         
                ; JR $
                ; RET
                
                INC IXH                                     ; FUnitLocation     (2)

                LD E, IXL
                LD D, IXH
                INC DE
                INC DE
                ; INC DE
                LD (ShiftLocation.UnitOffset), DE

                ; LD E, IXL
                ; LD D, IXH
                ; LD HL, #0003
                ; ADD HL, DE
                ; LD (ShiftLocation.UnitOffset), HL
                
                INC IXH                                     ; FUnitTargets      (3)

                ;
                CALL AI.Utils.GetDeltaTarget                ; calculate direction delta
                
                ; ---------------------------------------------
                ; IX - pointer to FUnitLocation (2)
                ; D = dY (signed)
                ; E = dX (signed)
                ; ---------------------------------------------

                LD A, E
                OR D
                JR Z, .Complite

                INC IXH                                     ; FUnitTargets      (3)
                INC IXH                                     ; FUnitAnimation    (4)

                ; check for the need to reinitialize the counter after move
                LD C, (IX + FUnitAnimation.Flags)
                RR C
                CALL NC, .Init                              ; reinitialize if the FUAF_TURN_MOVE flag is set

                ; LD A, C
                ; CPL
                ; AND 3
                ; LD C, A

                ; if necessary, change the sign of dY
                XOR A
                LD B, A                                     ; reset register B`
                SUB D
                JP M, $+4
                LD D, A

                ; if necessary, change the sign of dX
                XOR A
                SUB E
                JP M, $+4
                LD E, A

                ; ---------------------------------------------
                ; D = |dY|
                ; E = |dX|
                ; ---------------------------------------------

                LD L, #23

                ; dX < dY ?
                LD A, E
                CP D
                JR C, .SkipSwap_dX_dY                       ; if dX < dY, then the base axis dY
                
                ; dX <=> dY (swap)
                LD E, D
                LD D, A

                LD L, #00

                

                ; LD HL, ShiftLocation.UnitOffset
                ; DEC (HL)
                  
.SkipSwap_dX_dY ;


                ; LD A, L
                ; OR A
                ; JR Z, $+8

                ; LD A, C
                ; OR A
                ; JR Z, $+4
                ; CPL
                ; LD C, A

                LD A, (IX + FUnitAnimation.Delta)
                OR A
                JR NZ, $+3
                LD A, D
                INC E
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

                ; LD HL, ShiftLocation.UnitOffset
                ; INC (HL)

                LD A, L
                OR A
                LD A, #00
                JR NZ, $+4
                LD A, #23

                LD (ShiftLocation.dX_dY), A

                ;
                RR C
                SBC A, A
                CCF
                ADC A, B

                CALL ShiftLocation

                EX AF, AF'
                ADD A, D
                


;                 LD HL, $
;                 PUSH HL
;                 LD HL, $
;                 ; dX < dY ?
;                 CP D
;                 JR C, .SkipSwap_dX_dY                       ; если dX < dY то считаем основной координатой dY
;                 ; иначе меняем dX и dY местами (swap dX, dY)
;                 LD E, D
;                 LD D, A
;                 EX (SP), HL                                 ; swap address
; .SkipSwap_dX_dY LD A, #1C                                   ; INC/DEC E
;                 RR C
;                 ADC A, B
;                 LD (HL), A
;                 POP HL              
;                 LD A, #14                                   ; INC/DEC D
;                 RR C
;                 ADC A, B
;                 LD (HL), A
;                 ;
;                 LD A, (IX + FUnitAnimation.Delta)
;                 OR A
;                 JR NZ, $+3
;                 LD A, D
;                 INC E
.PreExit        ;
                LD (IX + FUnitAnimation.Delta), A

                ; A - номер юнита
                LD A, IXL
                RRA
                RRA
                AND %00111111
                CALL Unit.RefUnitOnScr

.Exit           ; завершение работы
                DEC IXH                                     ; FUnitTargets      (3)
                DEC IXH                                     ; FUnitLocation     (2)
                DEC IXH                                     ; FUnitState        (1)

                OR A
                RET

.Complite       ;
                DEC IXH                                     ; FUnitState        (1)
                SCF
                RET

.Init           ; ---------------------------------------------
                ; IX - pointer to FUnitAnimation (4)
                ; D - dY
                ; E - dX
                ; ---------------------------------------------
                
                LD C, #00

                ; знак dY
                LD A, D
                RLA
                ; CCF
                RL C                                        ; FUAF_Y

                ; знак dX
                LD A, E
                RLA
                RL C                                        ; FUAF_X

                ; FUAF_TURN_MOVE
                SCF                                         ; установка бита принадлежности CounterDown (0 - поворот, 1 - перемещение)
                RL C

                ;
                LD A, FUAF_MOVE_MASK
                AND (IX + FUnitAnimation.Flags)
                OR C
                LD (IX + FUnitAnimation.Flags), A

                RR C                                        ; skip FUAF_TURN_MOVE

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

.dX_dY          NOP                                         ; NOP/INC HL    (NOP - x, INC HL - y)


                ADD A, (HL)
                JP M, .Negative

                CP 8
                JR NC, .NextCell
                
                LD (HL), A
                EXX
                RET

.NextCell       ;
                LD (HL), -8
                DEC HL
                DEC HL
                INC (HL)
                EXX
                RET

.Negative       CP -9
                JR Z, .PrevCell
                
                LD (HL), A
                EXX
                RET

.PrevCell       ;
                LD (HL), 7
                DEC HL
                DEC HL
                DEC (HL)
                EXX
                RET

                endif ; ~_CORE_MODULE_AI_TASK_MOVE_TO_
