
; -----------------------------------------
; display two rows (сдвиг)
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
                        DW SBP_16_0_S_Backward
SBP_16_0_S:             EXX

                        ;- 1 byte -
                        ; modify the left side of a byte
                        LD A, (DE)

                        POP BC
                        LD L, C     ; OR
                        OR (HL)
                        LD L, B     ; XOR
                        XOR (HL)
                        LD (DE), A

                        INC E                               ; next screen character cell (1)

                        ; modify the right side of a byte
                        LD A, (DE)

                        INC H                               ; calculate right shift address
                        LD L, C     ; OR
                        OR (HL)
                        LD L, B     ; XOR
                        XOR (HL)
                        ;~ 1 byte ~

                        DEC H                               ; calculate left shift address

                        ;- 2 byte -
                        ; modify the left side of a byte
                        POP BC
                        LD L, C     ; OR
                        OR (HL)
                        LD L, B     ; XOR
                        XOR (HL)
                        LD (DE), A

                        INC E                               ; next screen character cell (2)

                        ; modify the right side of a byte
                        LD A, (DE)
                        
                        INC H                               ; calculate right shift address
                        LD L, C     ; OR
                        OR (HL)
                        LD L, B     ; XOR
                        XOR (HL)
                        LD (DE), A
                        ;~ 2 byte ~

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
                        ; modify the right side of a byte
                        LD A, (DE)

                        POP BC
                        LD L, C     ; OR
                        OR (HL)
                        LD L, B     ; XOR
                        XOR (HL)
                        LD (DE), A

                        DEC E                               ; next screen character cell (2)

                        ; modify the left side of a byte
                        LD A, (DE)

                        DEC H                               ; calculate left shift address
                        LD L, C     ; OR
                        OR (HL)
                        LD L, B     ; XOR
                        XOR (HL)
                        ;~ 1 byte ~

                        INC H                               ; calculate right shift address

                        ;- 2 byte -
                        ; modify the right side of a byte
                        POP BC
                        LD L, C     ; OR
                        OR (HL)
                        LD L, B     ; XOR
                        XOR (HL)
                        LD (DE), A

                        DEC E                               ; next screen character cell (1)

                        ; modify the left side of a byte
                        LD A, (DE)

                        DEC H                               ; calculate left shift address
                        LD L, C     ; OR
                        OR (HL)
                        LD L, B     ; XOR
                        XOR (HL)
                        LD (DE), A
                        ;~ 2 byte ~

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
SBP_16_0_S_Backward:    ;
                        EX DE, HL
                        EXX
                        INC E
                        INC E
                        INC H                               ; calculate right shift address
                        JP SBP_16_0_S.Backward
