
; -----------------------------------------
; display two rows (выровненый по знакоместу)
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
                        DW SBP_16_0_Restore
                        DW SBP_16_0_Backward
SBP_16_0:               EXX

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

                        INC C                               ; next screen character cell (1)

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

                        DEC C                               ; next screen character cell (1)

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
SBP_16_0_Backward:      ;
                        EX DE, HL
                        EXX
                        INC C
                        JP SBP_16_0.Backward
SBP_16_0_Restore:       JP SBP_16_0_LS_Restore
                        
;                         EXX

; .NextRow                ; move to the next two row
;                         EXX
;                         INC HL
;                         INC HL
;                         JP (HL)