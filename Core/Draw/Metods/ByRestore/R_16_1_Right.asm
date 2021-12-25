
; -----------------------------------------
; display two rows (пропускает правый байт, выровненый по знакоместу)
; In:
;   SP  - sprite address
;   HL  - return addres
;   DE  - 
;   BC  - buffer address
;   H'  - high byte of the shift table
;   DE' -
;   BC' - row screen address
; Out:
; Corrupt:
;   SP, HL, BC, DE', BC'
; -----------------------------------------
                        DW SBPR_16_1_R_Restore
                        DW SBPR_16_1_R_Backward
SBPR_16_1_R:            EXX

                        ;- 1 byte -
                        LD A, (BC)

                        ; - save background 
                        EXX
                        LD (BC), A
                        INC BC
                        EXX
                        ; ~ save background 
                        
                        POP DE
                        OR E
                        XOR D
                        LD (BC), A
                        ;~ 1 byte ~

                        ;- 2 byte -
                        POP DE                              ; skip 2 byte
                        ;~ 2 byte ~

                        ; classic method "DOWN_BC" 25/59
                        INC B
                        LD A, B
                        AND #07
                        JP NZ, $+19
                        LD A, C
                        SUB #E0
                        LD C, A
                        SBC A, A
                        AND #F8
                        ADD A, B
                        LD B, A

                        ; - костыль (чтобы не рисовать в атрибутах)
                        LD A, B
                        AND %00011000
                        ADD A, #E8
                        JR Z, .NextRow
.Backward
                        ;- 1 byte -
                        POP DE                              ; skip 1 byte
                        ;~ 1 byte ~

                        ;- 2 byte -
                        LD A, (BC)

                        ; - save background 
                        EXX
                        LD (BC), A
                        INC BC
                        EXX
                        ; ~ save background 
                        
                        POP DE
                        OR E
                        XOR D
                        LD (BC), A
                        ;~ 2 byte ~

                        ; classic method "DOWN_BC" 25/59
                        INC B
                        LD A, B
                        AND #07
                        JP NZ, $+12
                        LD A, C
                        SUB #E0
                        LD C, A
                        SBC A, A
                        AND #F8
                        ADD A, B
                        LD B, A

.NextRow                ; move to the next two row
                        EXX
                        INC HL
                        INC HL
                        JP (HL)
SBPR_16_1_R_Backward:   ;
                        EX DE, HL
                        EXX
                        JP SBPR_16_1_R.Backward
SBPR_16_1_R_Restore:    JP SBPR_16_1_L_Restore
