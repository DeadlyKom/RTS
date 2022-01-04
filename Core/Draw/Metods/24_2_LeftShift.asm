
; -----------------------------------------
; display two rows (пропускает два левых байта и левый сдвиг)
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
                        DW SBP_24_2_LS_Backward
SBP_24_2_LS:            EXX
                        
                        ;- 1 byte -
                        POP BC                                                  ; skip 1 byte
                        ;~ 1 byte ~

                        ;- 2 byte -
                        POP BC                                                  ; skip 2 byte
                        ;~ 2 byte ~

                        ;- 3 byte -
                        ; modify the right side of a byte
                        LD A, (DE)
                        POP BC
                        ; INC H                                                   ; calculate right shift address
                        LD L, C     ; OR
                        OR (HL)
                        LD L, B     ; XOR
                        XOR (HL)
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
                        ; modify the right side of a byte
                        LD A, (DE)
                        POP BC
                        LD L, C     ; OR
                        OR (HL)
                        LD L, B     ; XOR
                        XOR (HL)
                        LD (DE), A
                        ;~ 1 byte ~

                        ;- 2 byte -
                        POP BC                                                  ; skip 2 byte
                        ;~ 2 byte ~

                        ;- 3 byte -
                        POP BC                                                  ; skip 3 byte
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

.NextRow                ; move to the next two row
                        EXX
                        INC HL
                        INC HL
                        JP (HL)
SBP_24_2_LS_Backward:   ;
                        EX DE, HL
                        EXX
                        ; INC E
                        ; INC E
                        JP SBP_24_2_LS.Backward
