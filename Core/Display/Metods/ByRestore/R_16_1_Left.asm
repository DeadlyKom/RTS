
; -----------------------------------------
; display two rows (пропускает левый байт, выровненый по знакоместу)
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
                        DW SBPR_16_1_L_Restore
                        DW SBPR_16_1_L_Backward
SBPR_16_1_L:            EXX

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
SBPR_16_1_L_Backward:   ;
                        EX DE, HL
                        EXX
                        JP SBPR_16_1_L.Backward
SBPR_16_1_L_Restore:    EXX

                        POP DE
                        LD (HL), E

                        ; classic method "DOWN_HL" 25/59
                        INC H
                        LD A, H
                        AND #07
                        JP NZ, $+19
                        LD A, L
                        SUB #E0
                        LD L, A
                        SBC A, A
                        AND #F8
                        ADD A, H
                        LD H, A

                        ; - костыль (чтобы не рисовать в атрибутах)
                        LD A, H
                        AND %00011000
                        ADD A, #E8
                        JR Z, .NextRow

                        LD (HL), D

                        ; classic method "DOWN_HL" 25/59
                        INC H
                        LD A, H
                        AND #07
                        JP NZ, $+12
                        LD A, L
                        SUB #E0
                        LD L, A
                        SBC A, A
                        AND #F8
                        ADD A, H
                        LD H, A                     

.NextRow                ; move to the next two row
                        EXX
                        INC HL
                        INC HL
                        JP (HL)
