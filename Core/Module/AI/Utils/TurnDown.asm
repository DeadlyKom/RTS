
                ifndef _CORE_MODULE_AI_UTILS_TURN_DOWN_
                define _CORE_MODULE_AI_UTILS_TURN_DOWN_

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
Down:           
                EX AF, AF'
                
                LD DE, #3964

                ; ratio dY/dX
                LD A, D
                LD D, #FF
                SUB E
                JR Z, .Deg45                    ; angle 45 degrees
                JR C, .Div
                SUB E
                JR NC, .Deg60                   ; angle more 63 degrees
                CCF
.Div            RL D
                ADD A, E
                ADD A, A
                CP E
                JR C, .Div_1
                SUB E
.Div_1          RL D
                ADD A, A
                CP E
                JR C, .Div_2
                SUB E
.Div_2          RL D
                ADD A, A
                CP E
                JR C, .Div_3
                SUB E
.Div_3          RL D
                ADD A, A
                CP E
                JR C, .Div_4
                SUB E
.Div_4          RL D
                LD A, D
                CPL                             ; A - stores the ratio of 1.4 fixed numbers dY/dX
                

                ; ---------------------------------------------
                ; D - dY
                ; E - dX
                ; ---------------------------------------------

                LD A, D                 ; A = dY
                CP E                    ; E = dX
                JR C, .AngleTo45        ; x > y

                ; угол от 45 до 90
                RRA                     ; A = dY * 0.5
                CP E                    ; E = dX
                JR NC, $                ; угол от 63.5 до 90
                                        ; угол от 45 до 63.5

.AngleTo45      ; угол от 0 до 45
                SRL E                   ; dX *= 0.5
                CP E                    ; E = dX * 0.5
                JR C, $                 ; угол до 0 до 26.5
                                        ; угол от 26.5 до 45

.Deg45      
.Deg60
                OR A
                RET

                endmodule

                endif ; ~ _CORE_MODULE_AI_UTILS_TURN_DOWN_