
; -----------------------------------------
; display two rows (пропускает левые два байта и левый сдвиг)
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
                        DW SBP_24_2_LS_Backward
SBP_24_2_LS:            EXX
                        
                        ;- 1 byte -
                        POP DE                              ; skip 1 byte
                        ;~ 1 byte ~

                        ;- 2 byte -
                        POP DE                              ; skip 2 byte
                        ;~ 2 byte ~

                        ;- 3 byte -
                        ; modify the right side of a byte
                        LD A, (BC)
                        POP DE
                        ; INC H                              ; calculate right shift address
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
                        SBC A
                        AND #F8
                        ADD A, B
                        LD B, A
.Backward
                        ;- 1 byte -
                        ; modify the right side of a byte
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
                        SBC A
                        AND #F8
                        ADD A, B
                        LD B, A

                        ; move to the next two row
                        EXX
                        INC HL
                        INC HL
                        JP (HL)
SBP_24_2_LS_Backward:   ;
                        EX DE, HL
                        EXX
                        INC C
                        INC C
                        JP SBP_24_2_LS.Backward
