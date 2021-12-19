
; -----------------------------------------
; display two rows (пропускает два левых байта, выровненый по знакоместу)
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
                        DW SBP_24_2_L_Backward
SBP_24_2_L:             EXX

                        ;- 1 byte -
                        POP DE                              ; skip 1 byte
                        ;~ 1 byte ~

                        ;- 2 byte -
                        POP DE                              ; skip 2 byte
                        ;~ 2 byte ~

                        ;- 3 byte -
                        LD A, (BC)
                        POP DE
                        OR E
                        XOR D
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
.Backward
                        ;- 1 byte -
                        LD A, (BC)
                        POP DE
                        OR E
                        XOR D
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

                        ; move to the next two row
                        EXX
                        INC HL
                        INC HL
                        JP (HL)
SBP_24_2_L_Backward:    ;
                        EX DE, HL
                        EXX
                        ; INC C
                        ; INC C
                        JP SBP_24_2_L.Backward
