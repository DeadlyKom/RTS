
                ifndef _PROJECTILE_DIRECTION_
                define _PROJECTILE_DIRECTION_
; -----------------------------------------
; In:
; Out:
; Corrupt:
; -----------------------------------------
Direction:      ; инициализация
                LD BC, #0101                                                    ; смещение по осям X и Y +1

                EXX
                LD HL, PositionY
                LD DE, PositionX
                EXX

                ; расчёт dY = StartY - EndY
.StartY         EQU $+1
                LD HL, #0000
.EndY           EQU $+1
                LD DE, #0000
                OR A
                SBC HL, DE
                JR NC, .PositiveY

                ; изменить знак HL
                LD A, H
                CPL
                LD H, A
                LD A, L
                CPL
                LD L, A
                INC HL

                LD B, #FF                                                       ; смещение по оси Y -1

.PositiveY      ; dY положительный
                PUSH HL                                                         ; сохранение dY

                ; расчёт dX = StartX - EndX
.StartX         EQU $+1
                LD HL, #0000
.EndX           EQU $+1
                LD DE, #0000
                OR A
                SBC HL, DE
                JR NC, .PositiveX

                ; изменить знак HL
                LD A, H
                CPL
                LD H, A
                LD A, L
                CPL
                LD L, A
                INC HL

                LD C, #FF                                                       ; смещение по оси X -1

.PositiveX      ; dX положительный
                POP DE                                                          ; востановим dY

                ; сравнение dX и dY
                OR A
                SBC HL, DE
                EX AF, AF'
                ADD HL, DE                                                      ; востановление dX
                EX AF, AF'
                JR C, .dY_More_dX                                               ; переход, если dY больше dX

                EX DE, HL                                                       ; меняем местави dX и dY
                
                ; меняем местави смещения по осям
                LD A, B
                LD B, C
                LD C, A

                ;
                EXX
                EX DE, HL
                EXX

.dY_More_dX     ; 
                EXX
                LD (Move.Less), HL
                LD (Move.More), DE
                EXX

                ;
                INC HL
                LD (Delta), HL
                LD (Error), DE
                LD (DeltaError), DE
                INC DE
                LD (Loop), DE
                LD A, C
                RLA
                SBC A, A
                LD H, A
                LD L, C
                LD (DeltaX), HL
                LD A, B
                RLA
                SBC A, A
                LD H, A
                LD L, B
                LD (DeltaY), HL

                ;
                LD HL, (.EndX)
                LD (PositionX), HL
                LD HL, (.EndY)
                LD (PositionY), HL
                
                RET
Move:           ; проверка завершения цикла
                LD HL, (Loop)
                DEC HL
                LD A, H
                OR L
                RET Z
                LD (Loop), HL

                ;
.Less           EQU $+1
                LD HL, #0000
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                LD C, (HL)
                INC HL
                LD B, (HL)
                DEC HL
                DEC HL
                EX DE, HL
                ADD HL, BC
                EX DE, HL
                LD (HL), D
                DEC HL
                LD (HL), E

                LD HL, (Error)
                LD DE, (Delta)
                OR A
                SBC HL, DE
                LD (Error), HL
                RET NC

                LD DE, (DeltaError)
                ADD HL, DE
                LD (Error), HL

                ;
.More           EQU $+1
                LD HL, #0000
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                LD C, (HL)
                INC HL
                LD B, (HL)
                DEC HL
                DEC HL
                EX DE, HL
                ADD HL, BC
                EX DE, HL
                LD (HL), D
                DEC HL
                LD (HL), E
                
                RET

PositionX       DW #0000
DeltaX          DW #0000
PositionY       DW #0000
DeltaY          DW #0000
Delta           DW #0000
Error           DW #0000
DeltaError      DW #0000
Loop            DW #0000

                endif ; ~_PROJECTILE_DIRECTION_