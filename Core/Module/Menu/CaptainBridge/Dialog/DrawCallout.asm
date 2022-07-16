
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_CALLOUT_
                define _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_CALLOUT_

BACKGROUND      EQU ((0 << 7) | (0 << 6) | (CYAN << 3) | BLACK)
; -----------------------------------------
; отображение выноски
; In:
;   HL - адрес экрана
;   BC - размеры выноски (B - y (+ 2 вверх/низ), C - x (-2 лево/право))
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawCallout:    ; инициализация
                EXX
                LD DE, #FF01
                LD BC, #0080
                EXX

                LD A, B                                                         ; сохранение высоты рамки
                LD E, L                                                         ; сохранение смещение по горизонтали

                ; отображение верхней части выноски
                LD B, C
                CALL Up

                ; переход к следующей линии
                EX AF, AF'
                LD A, E
                ADD A, #20
                LD L, A
                LD E, A
                EX AF, AF'

.LineLoop       ; отображение центральной части выноски
                LD B, C
                CALL Center

                ; переход к следующей линии
                EX AF, AF'
                LD A, E
                ADD A, #20
                LD L, A
                LD E, A
                EX AF, AF'

                ; переход к следующей центровой части
                DEC A
                JR NZ, .LineLoop

                ; отображение нижней части выноски
                LD B, C
                JP Down
Up:             ; отобрадение верхней части выноски
                PUSH HL
                EXX
                POP HL

                LD (HL), D
                INC H
                rept 6
                LD (HL), C
                INC H
                endr
                LD (HL), C

                CALL SetATTR
                EXX

.RowLoop        INC L

                PUSH HL
                EXX
                POP HL

                LD (HL), D
                INC H
                rept 6
                LD (HL), B
                INC H
                endr
                LD (HL), B

                CALL SetATTR
                EXX

                DJNZ .RowLoop

                INC L

                PUSH HL
                EXX
                POP HL

                LD (HL), D
                INC H
                rept 6
                LD (HL), E
                INC H
                endr
                LD (HL), E

                CALL SetATTR
                EXX

                RET
Center:         ; отобрадение средней части выноски
                PUSH HL
                EXX
                POP HL

                rept 7
                LD (HL), C
                INC H
                endr
                LD (HL), C

                CALL SetATTR
                EXX

.RowLoop        INC L
                
                PUSH HL
                EXX
                POP HL

                rept 7
                LD (HL), B
                INC H
                endr
                LD (HL), B

                CALL SetATTR
                EXX

                DJNZ .RowLoop

                INC L

                PUSH HL
                EXX
                POP HL

                rept 7
                LD (HL), E
                INC H
                endr
                LD (HL), E

                CALL SetATTR
                EXX

                RET
Down:           ; отобрадение нижней части выноски
                PUSH HL
                EXX
                POP HL

                rept 7
                LD (HL), C
                INC H
                endr
                LD (HL), D

                CALL SetATTR
                EXX

.RowLoop        INC L

                PUSH HL
                EXX
                POP HL

                rept 7
                LD (HL), B
                INC H
                endr
                LD (HL), D

                CALL SetATTR
                EXX

                DJNZ .RowLoop

                INC L

                PUSH HL
                EXX
                POP HL

                rept 7
                LD (HL), E
                INC H
                endr
                LD (HL), D

                CALL SetATTR
                EXX

                RET
SetATTR:        EX AF, AF'
                LD A, H
                RRA
                RRA
                RRA
                AND %00000011
                OR %01011000
                LD H, A
                LD (HL), BACKGROUND
                EX AF, AF'
                RET

                display " - DrawCallout : \t\t", /A, DrawCallout, " = busy [ ", /D, $ - DrawCallout, " bytes  ]"

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_CALLOUT_
