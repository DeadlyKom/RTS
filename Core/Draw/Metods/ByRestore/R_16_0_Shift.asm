
; -----------------------------------------
; display two rows (сдвиг)
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
                        DW SBPR_16_0_S_Restore
                        DW SBPR_16_0_S_Backward
SBPR_16_0_S:            EXX

                        ;- 1 byte -
                        ; modify the left side of a byte
                        LD A, (BC)

                        ; - save background 
                        EXX
                        LD (BC), A
                        INC BC
                        EXX
                        ; ~ save background 

                        POP DE
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        LD (BC), A

                        INC C                               ; next screen character cell (1)

                        ; modify the right side of a byte
                        LD A, (BC)

                        ; - save background 
                        EXX
                        LD (BC), A
                        INC BC
                        EXX
                        ; ~ save background 

                        INC H                               ; calculate right shift address
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        ;~ 1 byte ~

                        DEC H                               ; calculate left shift address

                        ;- 2 byte -
                        ; modify the left side of a byte
                        POP DE
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        LD (BC), A

                        INC C                               ; next screen character cell (2)

                        ; modify the right side of a byte
                        LD A, (BC)

                        ; - save background 
                        EXX
                        LD (BC), A
                        INC BC
                        EXX
                        ; ~ save background 
                        
                        INC H                               ; calculate right shift address
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
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
                        ; modify the right side of a byte
                        LD A, (BC)

                        ; - save background 
                        EXX
                        LD (BC), A
                        INC BC
                        EXX
                        ; ~ save background 

                        POP DE
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        LD (BC), A

                        DEC C                               ; next screen character cell (2)

                        ; modify the left side of a byte
                        LD A, (BC)

                        ; - save background 
                        EXX
                        LD (BC), A
                        INC BC
                        EXX
                        ; ~ save background 

                        DEC H                               ; calculate left shift address
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        ;~ 1 byte ~

                        INC H                               ; calculate right shift address

                        ;- 2 byte -
                        ; modify the right side of a byte
                        POP DE
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        LD (BC), A

                        DEC C                               ; next screen character cell (1)

                        ; modify the left side of a byte
                        LD A, (BC)

                        ; - save background 
                        EXX
                        LD (BC), A
                        INC BC
                        EXX
                        ; ~ save background 

                        DEC H                               ; calculate left shift address
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
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

                        ; move to the next two row
.NextRow                EXX
                        INC HL
                        INC HL
                        JP (HL)
SBPR_16_0_S_Backward:   ;
                        EX DE, HL
                        EXX
                        INC C
                        INC C
                        INC H                               ; calculate right shift address
                        JP SBPR_16_0_S.Backward
SBPR_16_0_S_Restore:    EXX

                        POP DE
                        LD (HL), E
                        INC L
                        LD (HL), D
                        INC L
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
                        DEC L
                        POP DE
                        LD (HL), E
                        DEC L
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