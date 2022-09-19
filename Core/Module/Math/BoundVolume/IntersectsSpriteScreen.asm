
                ifndef _MATH_INTERSECTS_AABB_SPITE_SCREEN_
                define _MATH_INTERSECTS_AABB_SPITE_SCREEN_

                module Math
; -----------------------------------------
; проверка пересечения AABB спрайта с экранов
; In :
;   IX - указывает на структуру FUnit
; Out :
;   флаг переполнения установлен, если спрайт вне экрана
;   иначе :
;       HL' - дельты значение между краями оси Y    (H - dB.Y, L - dA.Y)
;       DE' - дельты значение между краями оси X    (D - dB.X, E - dA.X)
;       BC' - размер спрайта                        (B - высота, C - ширина)
; Corrupt :
;    HL, DE, BC, AF, HL', DE', BC', AF'
; Note:
;   a.maxX < b.minX || a.minX > b.maxX
;   a.maxY < b.minY || a.minY > b.maxY
;
;   dA.X = a.maxX - b.minX
;   dB.X = b.maxX - a.minX
;   dA.Y = a.maxY - b.minY
;   dB.Y = b.maxY - a.minY
; -----------------------------------------
IntersectScr:   ; инициализация
                LD HL, GameVar.TilemapOffset
                LD A, (HL)                                                      ; b.minX
                INC HL
                LD B, (HL)                                                      ; b.minY
                EX AF, AF'

                LD H, #00
                LD C, H                                                         ; обнуление регистра C

                ; -----------------------------------------
                ; a.maxY < b.minY
                ; -----------------------------------------

                ; приведение к форме хранения позиции юнита (12.4)
                LD A, (IX + FUnit.AABB.MAX.Y)
                EXX
                LD B, A                                                         ; сохранение a.maxY
                EXX
                ADD A, A
                ADD A, A
                ADD A, A
                RL H
                LD L, A

                ; расчёт максимального значения по оси Y (a.maxY)
                LD DE, (IX + FUnit.Position.Y)
                ADD HL, DE

                ; сравнение a.maxY, b.minY
                SBC HL, BC
                RET C                                                           ; выход, если a.maxY < b.minY

                ; сохранение dA.Y
                LD A, L
                EXX
                LD L, A                                                         ; dA.Y
                EXX

                ; -----------------------------------------
                ; a.minY > b.maxY
                ; -----------------------------------------

                ; приведение к форме хранения позиции юнита (12.4)
                LD H, C
                LD A, (IX + FUnit.AABB.MIN.Y)
                
                ; B' = a.minY +  a.maxY
                EXX
                LD C, A
                ADD A, B
                LD B, A
                SUB C
                EXX

                ADD A, A
                ADD A, A
                ADD A, A
                RL H
                LD L, A

                ; расчёт минимального значения по оси Y (a.minY)
                EX DE, HL
                SBC HL, DE

                ; сравнение a.minY, b.maxY
                EX DE, HL
                LD A, SCREEN_TILE_Y
                ADD A, B
                LD B, A
                SBC HL, BC
                RET C                                                           ; выход, если a.minY > b.maxY

                ; сохранение dB.Y
                LD A, L
                EXX
                LD H, A                                                         ; dB.Y
                EXX

                ; инициализация
                EX AF, AF'
                LD B, A

                ; -----------------------------------------
                ; a.maxX < b.minX
                ; -----------------------------------------

                ; приведение к форме хранения позиции юнита (12.4)
                LD H, C
                LD A, (IX + FUnit.AABB.MAX.X)
                EXX
                LD C, A                                                         ; сохранение a.maxX
                EXX
                ADD A, A
                ADD A, A
                ADD A, A
                RL H
                LD L, A

                ; расчёт максимального значения по оси X (a.maxX)
                LD DE, (IX + FUnit.Position.X)
                ADD HL, DE

                ; сравнение a.maxX, b.minX
                SBC HL, BC
                RET C                                                           ; выход, если a.maxX < b.minX

                ; сохранение dA.X
                LD A, L
                EXX
                LD E, A                                                         ; dA.X
                EXX

                ; -----------------------------------------
                ; a.minX > b.maxX
                ; -----------------------------------------

                ; приведение к форме хранения позиции юнита (12.4)
                LD H, C
                LD A, (IX + FUnit.AABB.MIN.X)

                ; C' = a.minX +  a.maxX
                EXX
                LD D, A
                ADD A, C
                LD C, A
                SUB D
                EXX

                ADD A, A
                ADD A, A
                ADD A, A
                RL H
                LD L, A

                ; расчёт минимального значения по оси X (a.minX)
                EX DE, HL
                SBC HL, DE

                ; сравнение a.minX, b.maxX
                EX DE, HL
                LD A, SCREEN_TILE_X
                ADD A, B
                LD B, A
                SBC HL, BC
                RET C                                                           ; выход, если a.minX > b.maxX

                ; сохранение dB.X
                LD A, L
                EXX
                LD D, A                                                         ; dB.X
                EXX

                RET

                display " - Intersects AABB spr and scr : \t", /A, IntersectScr, " = busy [ ", /D, $ - IntersectScr, " bytes  ]"

                endmodule

                endif ; ~_MATH_INTERSECTS_AABB_SPITE_SCREEN_
