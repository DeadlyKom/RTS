
; -----------------------------------------
; display two rows (пропускает два правых байта и правый сдвиг)
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
;   SP, HL, BC, L', DE', BC'
; -----------------------------------------
                        DW SBP_24_2_RS_Backward
SBP_24_2_RS:            EXX

                        ;- 1 byte -
                        ; modify the left side of a byte
                        LD A, (BC)
                        POP DE
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        LD (BC), A
                        ;~ 1 byte ~

                        ;- 2 byte -
                        POP DE                              ; skip 2 byte
                        ;~ 2 byte ~

                        ;- 3 byte -
                        POP DE                              ; skip 3 byte
                        ;~ 3 byte ~

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
.Backward
                        ;- 1 byte -
                        POP DE                              ; skip 1 byte
                        ;~ 1 byte ~

                        ;- 2 byte -
                        POP DE                              ; skip 2 byte
                        ;~ 2 byte ~

                        ;- 3 byte -
                        ; modify the left side of a byte
                        LD A, (BC)
                        POP DE
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        LD (BC), A
                        ;~ 3 byte ~

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

                        ; move to the next two row
                        EXX
                        INC HL
                        INC HL
                        JP (HL)
SBP_24_2_RS_Backward:   ;
                        EX DE, HL
                        EXX
                        JP SBP_24_2_RS.Backward
