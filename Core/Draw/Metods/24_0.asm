
; -----------------------------------------
; display two rows (выровненый по знакоместу)
; In:
;   SP  - sprite address
;   HL  - return addres
;   DE  - 
;   BC  - 'intermediate'
;   H'  - high byte of the shift table
;   DE' - row screen address
;   BC' - 
; Out:
; Corrupt:
;   SP, HL, BC, L', DE', BC'
; -----------------------------------------
                        DW SBP_24_0_Backward
SBP_24_0:               EXX

                        ;- 1 byte -
                        LD A, (DE)
                        POP BC
                        OR C
                        XOR B
                        LD (DE), A
                        ;~ 1 byte ~

                        INC E                                                   ; next screen character cell (1)

                        ;- 2 byte -
                        LD A, (DE)
                        POP BC
                        OR C
                        XOR B
                        LD (DE), A
                        ;~ 2 byte ~

                        INC E                                                   ; next screen character cell (2)

                        ;- 3 byte -
                        LD A, (DE)
                        POP BC
                        OR C
                        XOR B
                        LD (DE), A
                        ;~ 3 byte ~

                        ; classic method "DOWN_DE" 25/59
                        INC D
                        LD A, D
                        AND #07
                        JP NZ, $+18
                        LD A, E
                        SUB #E0
                        LD E, A
                        SBC A, A
                        AND #F8
                        ADD A, D
                        LD D, A

                        ; - костыль (чтобы не рисовать в атрибутах)
                        AND %00011000
                        ADD A, #E8
                        JR Z, .NextRow
.Backward
                        ;- 1 byte -
                        LD A, (DE)
                        POP BC
                        OR C
                        XOR B
                        LD (DE), A
                        ;~ 1 byte ~

                        DEC E                                                   ; next screen character cell (1)

                        ;- 2 byte -
                        LD A, (DE)
                        POP BC
                        OR C
                        XOR B
                        LD (DE), A
                        ;~ 2 byte ~

                        DEC E                                                   ; next screen character cell (0)

                        ;- 3 byte -
                        LD A, (DE)
                        POP BC
                        OR C
                        XOR B
                        LD (DE), A
                        ;~ 3 byte ~

                        ; classic method "DOWN_DE" 25/59
                        INC D
                        LD A, D
                        AND #07
                        JP NZ, $+12
                        LD A, E
                        SUB #E0
                        LD E, A
                        SBC A, A
                        AND #F8
                        ADD A, D
                        LD D, A

                        ; move to the next two row
.NextRow                EXX
                        INC HL
                        INC HL
                        JP (HL)
SBP_24_0_Backward:      ;
                        EX DE, HL
                        EXX
                        INC E
                        INC E
                        JP SBP_24_0.Backward
