
                ifndef _MATH_BEZIER_CURVE_
                define _MATH_BEZIER_CURVE_

                module Math

                ; мат блок работы с кривыми
                include "Core/Module/Math/Mul/16x8_24.asm"
                include "Core/Module/Math/Lerp.asm"
                
; -----------------------------------------
; расчёт положения объекта по кривой Безье
; In :
;   IX - указывает на структуру FUnit
;       Start     - начальная точка
;       Target    - конечная точка
;       Animation - альфа
; Out :
; Corrupt :
; Note:
; -----------------------------------------
BezierCurve:    LD DE, (IX + FUnit.Start)
                LD HL, (IX + FUnit.Target)
                EXX
                LD E, (IX + FUnit.Animation)
                EXX

.DeltaX         ; расчёт дельты по горизонтали
                LD A, L
                SUB E
                SRA A
                LD C, A

.DeltaY         ; расчёт дельты по вертикали
                LD A, H
                SUB D
                SRA A
                LD B, A

.P1             ; -----------------------------------------
                ; P1 = (Start.X + DeltaX / 4, Start.Y + DeltaY - 150)
                ; -----------------------------------------
                ; HL - P3     (H - y, L - x)
                ; DE - P0     (D - y, E - x)
                ; BC - дельта (B - y, C - x)
                ; -----------------------------------------

                LD A, E
                ADD A, C
                LD (.P1_X), A
                LD (.P1_X_), A

                LD A, D
                SUB B
                ; SUB #02
                LD (.P1_Y), A
                LD (.P1_Y_), A

.P2             ; -----------------------------------------
                ; P2 = (Target.X - DeltaX / 8, Target.Y + DeltaY / 4 - 150)
                ; -----------------------------------------
                ; HL - P3     (H - y, L - x)
                ; DE - P1     (D - y, E - x)
                ; BC - дельта (B - y, C - x)
                ; -----------------------------------------

                SRA C
                LD A, L
                SUB C
                ; SUB #08
                LD E, A
                LD (.P2_X_), A

                LD A, H
                SRA A
                SUB B
                SUB #01
                LD (.P2_Y), A
                LD (.P2_Y_), A

.C              ; -----------------------------------------
                ; C = Lerp(P2, P3, Q)
                ; -----------------------------------------
                ;  E - P2 (     , E - x)    (A)
                ; HL - P3 (H - y, L - x)    (B)
                ; -----------------------------------------

                LD B, E                         ; A.X
                LD C, #00
                LD H, L                         ; B.X
                LD L, C
                CALL Lerp
                LD (.Lerp_CX), HL

.P2_Y           EQU $+2
                LD BC, #0000                    ; A.Y
                LD H, (IX + FUnit.Target.Y)     ; B.Y
                LD L, C
                CALL Lerp
                LD (.Lerp_CY), HL

.B              ; -----------------------------------------
                ; B = Lerp(P1, P2, Q)
                ; -----------------------------------------
                ; P1 (D - y, E - x)    (A)
                ; P2 (H - y, L - x)    (B)
                ; -----------------------------------------

.P1_X           EQU $+2
                LD BC, #0000    ; A.X
.P2_X_          EQU $+2
                LD HL, #0000    ; B.X
                CALL Lerp
                LD (.Lerp_BX), HL

.P1_Y           EQU $+2
                LD BC, #0000    ; A.X
.P2_Y_          EQU $+2
                LD HL, #0000    ; B.Y
                CALL Lerp
                LD (.Lerp_BY), HL

.A              ; -----------------------------------------
                ; A = Lerp(P0, P1, Q)
                ; -----------------------------------------
                ; P0 (D - y, E - x)    (A)
                ; P1 (H - y, L - x)    (B)
                ; -----------------------------------------

                LD B, (IX + FUnit.Start+0)  ; A.X
.P1_X_          EQU $+2
                LD HL, #0000                ; B.X
                LD C, L
                CALL Lerp
                LD (.Lerp_AX), HL

                LD B, (IX + FUnit.Start+1)  ; A.Y
.P1_Y_          EQU $+2
                LD HL, #0000                ; B.X
                LD C, L
                CALL Lerp
                LD (.Lerp_AY), HL

                ; -----------------------------------------
                ; D = Lerp(A, B, Q)
                ; -----------------------------------------
                
.Lerp_AX        EQU $+1
                LD BC, #0000    ; A.X
.Lerp_BX        EQU $+1
                LD HL, #0000    ; B.X
                PUSH HL
                CALL Lerp
                LD (.Lerp_DX), HL

.Lerp_AY        EQU $+1
                LD BC, #0000    ; A.Y
.Lerp_BY        EQU $+1
                LD HL, #0000    ; B.Y
                POP DE
                PUSH HL
                PUSH DE
                CALL Lerp
                LD (.Lerp_DY), HL

                ; -----------------------------------------
                ; E = Lerp(B, C, Q)
                ; -----------------------------------------
                
                POP BC          ; A.X
.Lerp_CX        EQU $+1
                LD HL, #0000    ; B.X
                CALL Lerp
                LD (.Lerp_EX), HL

                POP BC          ; A.Y
.Lerp_CY        EQU $+1
                LD HL, #0000    ; B.Y
                CALL Lerp
                LD (.Lerp_EY), HL

                ; -----------------------------------------
                ; R = Lerp(D, E, Q)
                ; -----------------------------------------

.Lerp_DX        EQU $+1
                LD BC, #0000    ; A.X
.Lerp_EX        EQU $+1
                LD HL, #0000    ; B.X
                CALL Lerp
                LD (IX + FUnit.Position.X), HL

.Lerp_DY        EQU $+1
                LD BC, #0000    ; A.Y
.Lerp_EY        EQU $+1
                LD HL, #0000    ; B.Y
                CALL Lerp
                LD (IX + FUnit.Position.Y), HL

                ; RET

                ; детект перехода в другой чанк
                LD A, H
                OR A
                RET M
                LD A, (IX + FUnit.Position.X.High)
                OR A
                RET M

                LD D, H
                LD E, A
                CALL Game.Unit.Utils.ChunkArray.GetChunkIdx                     ; новый чанк
                LD B, (IX + FUnit.Chunk)
                CP B
                RET Z                                                           ; выход, чанк не изменился

                LD (IX + FUnit.Chunk), A                                        ; сохранение нового чанка
                EX AF, AF'                                                      ; сохранение флагов относительно текущего чанка и номер чанка
                CALL Game.Unit.Utils.GetIndex                                   ; индекс юнита
                LD D, A
                LD H, HIGH Adr.Unit.UnitChank

                ; H  - старший байт адрес массива чанков
                ; D  - перемещяемое значение
                ; B  - порядковый номер чанка [0..127]
                ; A' - чанк в который перемещается [0..127]
                JP Game.Unit.Utils.ChunkArray.Move

                display " - Bezier Curve : \t\t\t\t\t", /A, BezierCurve, " = busy [ ", /D, $ - BezierCurve, " bytes  ]"

                endmodule

                endif ; ~_MATH_BEZIER_CURVE_
