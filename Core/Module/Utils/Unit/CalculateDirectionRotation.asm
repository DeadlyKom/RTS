
                ifndef _CORE_MODULE_UTILS_TURN_DOWN_
                define _CORE_MODULE_UTILS_TURN_DOWN_

                module Turn
; -----------------------------------------
; расчёт направления поворота к цели
; In:
;   A  - текущее значение поворота [0..7]
;   DE - дельта до цели (D - dY, E - dX)
; Out:
;   A - направление поворота (-1/1)
;   флаг переполнения Carry сброшен, если поворот соответстует направлению цели
; Corrupt:
;   DE, BC, AF, AF'
; Note:
; -----------------------------------------
GetDirection:   LD C, A

                ; если dY < 0, то A' = 4, иначе 0
                LD A, D
                RLA
                SBC A, A
                CPL             ; Y инвертирован
                AND %00000100
                EX AF, AF'
                
                ; если 7 бит dY^dX, равен 0, то 'ADD A, B', иначе 'SUB B'
                LD A, D
                XOR E
                ADD A, A
                SBC A, A
                CPL             ; Y инвертирован
                AND %00010000
                OR %10000000
                LD (.Instruction), A

                ; смена знака если необходимо
                XOR A
                SUB D
                JP M, $+4
                LD D, A

                XOR A
                SUB E
                JP M, $+4
                LD E, A

                ; 
                LD B, #01

                ; ---------------------------------------------
                ; получение сектора
                ; ---------------------------------------------
                ; D - dY
                ; E - dX
                ; ---------------------------------------------

                LD A, D                 ; A = dY
                CP E                    ; E = dX
                ; JR Z, .Adjustment       ; x = y                                 ???
                JR C, .AngleTo45        ; x > y
                
                ; угол от 45 до 90
                RRA                     ; A = dY * 0.5
                CP E                    ; E = dX
                JR Z, .L2               ;                                       ???
                JR C, .Adjustment       ; угол от 45 до 63.5 (B = 1)
.L2             DEC B                   ; угол от 63.5 до 90 (B = 0)
                JR .Adjustment

.AngleTo45      ; угол от 0 до 45
                SRL E                   ; dX *= 0.5
                CP E                    ; E = dX * 0.5
                JR Z, .L1               ;                                       ???
                JR NC, .Adjustment      ; угол от 26.5 до 45 (B = 1)
.L1             INC B                   ; угол до 0 до 26.5  (B = 2)

.Adjustment     EX AF, AF'
.Instruction    NOP                     ; 'ADD A, B'/'SUB B'
                AND %00000111

                ; ---------------------------------------------
                ; сравнение напрвлений
                ; ---------------------------------------------

                SUB C                   ; A - A'
                RET Z                                                           ; выход, направление соответствует направлению к цели (флаг Carry сброшен)

                ;
                LD B, #3F               ; значение по умолчанию (по часовой)        CCF
                JR NC, .Clockwise       ; A > A'
                LD B, #00               ; значение по умолчанию (против часовой)    NOP

                ; A < A'    (вращение против часовой стрелки)
                NEG
.Clockwise      SUB #04
                JR NZ, .NotEqual

                ; выбор рандомного вращения
                ; LD A, R
                ; RRA
                SCF

.NotEqual       LD A, B
                LD (.Direction), A
.Direction      NOP                     ; NOP/CCF

.Rotation       SBC A, A                ; < 4 = -1, > 4 = 0
                CCF
                ADC A, #00

                ; выход, направление не соответствует направлению к цели
                SCF
                RET

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_TURN_DOWN_