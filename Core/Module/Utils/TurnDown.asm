
                ifndef _CORE_MODULE_UTILS_TURN_DOWN_
                define _CORE_MODULE_UTILS_TURN_DOWN_

                module Turn
; -----------------------------------------
; rotation of the bottom of the object/the whole object, 
; taking into account the current rotation to the required
; In:
;   A  - current turn (FUnitState.Direction)
;   DE - delta to target (D - dY, E - dX)
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
Down:           RRA
                RRA
                RRA
                AND %00000111
                LD C, A                 ; сохраним текущий поворот
                
                ; ---------------------------------------------
                ; D - dY
                ; E - dX
                ; ---------------------------------------------

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
                ; JR Z, .Adjustment       ; x = y
                JR C, .AngleTo45        ; x > y
                
                ; угол от 45 до 90
                RRA                     ; A = dY * 0.5
                CP E                    ; E = dX
                JR C, .Adjustment       ; угол от 45 до 63.5 (B = 1)
                DEC B                   ; угол от 63.5 до 90 (B = 0)
                JR .Adjustment

.AngleTo45      ; угол от 0 до 45
                SRL E                   ; dX *= 0.5
                CP E                    ; E = dX * 0.5
                JR NC, .Adjustment      ; угол от 26.5 до 45 (B = 1)
                INC B                   ; угол до 0 до 26.5  (B = 2)

.Adjustment     EX AF, AF'
.Instruction    NOP                     ; 'ADD A, B'/'SUB B'
                AND %00000111

                ; ---------------------------------------------
                ; сравнение напрвлений
                ; ---------------------------------------------

                SUB C                   ; A - A'
                JR Z, .Successful

                ;
                LD B, #3F               ; значение по умолчанию (по часовой)        CCF
                JR NC, .Clockwise       ; A > A'
                LD B, #00               ; значение по умолчанию (против часовой)    NOP

                ; A < A'    (вращение против часовой стрелки)
                NEG
.Clockwise      SUB #04
                JR NZ, .NotEqual

                ; выбор рандомного вращения
                LD A, R
                RRA
                ; SCF

.NotEqual       LD A, B
                LD (.Direction), A
.Direction      NOP                     ; NOP/CCF

.Rotation       SBC A, A                ; < 4 = -1, > 4 = 0
                CCF
                ADC A, #00

                CALL Animation.TurnDown

.Unsuccessful   OR A
                RET

.Successful     SCF
                RET

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_TURN_DOWN_