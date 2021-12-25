
                        ifndef _CORE_DISPLAY_SPRITE_BY_PIXEL_
                        define _CORE_DISPLAY_SPRITE_BY_PIXEL_

; -----------------------------------------
; display two rows
; In:
;   HL - sprite address
;   DE - shift table
;   BC - row screen address
; Out:
; Corrupt:
; -----------------------------------------
SBP_24_0:               ; HL' - shift table
                        ; HL  - exit address
                        ; D   - const value
                        ; BC  - row screen address

                        ;- 1 byte -
                        LD A, (BC)
                        EXX
                        POP DE
                        OR E
                        XOR D
                        EXX
                        LD (BC), A
                        ;~ 1 byte ~

                        INC C                               ; next screen character cell (1)

                        ;- 2 byte -
                        LD A, (BC)
                        EXX
                        POP DE
                        OR E
                        XOR D
                        EXX
                        LD (BC), A
                        ;~ 2 byte ~

                        INC C                               ; next screen character cell (2)

                        ;- 3 byte -
                        LD A, (BC)
                        EXX
                        POP DE
                        OR E
                        XOR D
                        EXX
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
                        
                        ;- 1 byte -
                        LD A, (BC)
                        EXX
                        POP DE
                        OR E
                        XOR D
                        EXX
                        LD (BC), A
                        ;~ 1 byte ~

                        DEC C                               ; next screen character cell (1)

                        ;- 2 byte -
                        LD A, (BC)
                        EXX
                        POP DE
                        OR E
                        XOR D
                        EXX
                        LD (BC), A
                        ;~ 2 byte ~

                        DEC C                               ; next screen character cell (0)

                        ;- 3 byte -
                        LD A, (BC)
                        EXX
                        POP DE
                        OR E
                        XOR D
                        EXX
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

                        ; move to the next two row
                        INC HL
                        INC HL
                        JP (HL)
SBP_24_0_S:             ; HL' - shift table
                        ; HL  - exit address
                        ; D   - const value
                        ; BC  - row screen address

                        ;- 1 byte -
                        ; modify the left side of a byte
                        LD A, (BC)
                        EXX
                        POP DE
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        EXX
                        LD (BC), A

                        INC C                               ; next screen character cell (1)

                        ; modify the right side of a byte
                        LD A, (BC)
                        EXX
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
                        EXX
                        LD (BC), A

                        INC C                               ; next screen character cell (2)

                        ; modify the right side of a byte
                        LD A, (BC)
                        EXX
                        INC H                               ; calculate right shift address
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        ;~ 2 byte ~

                        DEC H                               ; calculate left shift address

                        ;- 3 byte -
                        ; modify the left side of a byte
                        POP DE
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        EXX
                        LD (BC), A

                        INC C                               ; next screen character cell (3)
                        
                        ; modify the right side of a byte
                        LD A, (BC)
                        EXX
                        INC H                               ; calculate right shift address
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        EXX
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
                        
                        ;- 1 byte -
                        ; modify the right side of a byte
                        LD A, (BC)
                        EXX
                        POP DE
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        EXX
                        LD (BC), A

                        DEC C                               ; next screen character cell (2)

                        ; modify the left side of a byte
                        LD A, (BC)
                        EXX
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
                        EXX
                        LD (BC), A

                        DEC C                               ; next screen character cell (1)

                        ; modify the left side of a byte
                        LD A, (BC)
                        EXX
                        DEC H                               ; calculate left shift address
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        ;~ 2 byte ~

                        INC H                               ; calculate right shift address

                        ;- 3 byte -
                        ; modify the right side of a byte
                        POP DE
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        EXX
                        LD (BC), A

                        DEC C                               ; next screen character cell (0)
                        
                        ; modify the left side of a byte
                        LD A, (BC)
                        EXX
                        DEC H                               ; calculate left shift address
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        EXX
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

                        ; move to the next two row
                        INC HL
                        INC HL
                        JP (HL)
SBP_24_0_LS:            ; HL' - shift table
                        ; HL  - exit address
                        ; D   - const value
                        ; BC  - row screen address

                        ;- 1 byte -
                        ; modify the right side of a byte
                        LD A, (BC)
                        EXX
                        POP DE
                        ; INC H                               ; calculate right shift address
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
                        EXX
                        LD (BC), A

                        INC C                               ; next screen character cell (2)

                        ; modify the right side of a byte
                        LD A, (BC)
                        EXX
                        INC H                               ; calculate right shift address
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        ;~ 2 byte ~

                        DEC H                               ; calculate left shift address

                        ;- 3 byte -
                        ; modify the left side of a byte
                        POP DE
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        EXX
                        LD (BC), A

                        INC C                               ; next screen character cell (3)
                        
                        ; modify the right side of a byte
                        LD A, (BC)
                        EXX
                        INC H                               ; calculate right shift address
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        EXX
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
                        
                        ;- 1 byte -
                        ; modify the right side of a byte
                        LD A, (BC)
                        EXX
                        POP DE
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        EXX
                        LD (BC), A

                        DEC C                               ; next screen character cell (2)

                        ; modify the left side of a byte
                        LD A, (BC)
                        EXX
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
                        EXX
                        LD (BC), A

                        DEC C                               ; next screen character cell (1)

                        ; modify the left side of a byte
                        LD A, (BC)
                        EXX
                        DEC H                               ; calculate left shift address
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        ;~ 2 byte ~

                        INC H                               ; calculate right shift address

                        ;- 3 byte -
                        ; modify the right side of a byte
                        POP DE
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        EXX
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

                        ; move to the next two row
                        INC HL
                        INC HL
                        JP (HL)
SBP_24_1_L:             ; HL' - shift table
                        ; HL  - exit address
                        ; D   - const value
                        ; BC  - row screen address

                        ;- 1 byte -
                        ; skip
                        ;~ 1 byte ~

                        ;- 2 byte -
                        LD A, (BC)
                        EXX
                        POP DE
                        POP DE
                        OR E
                        XOR D
                        EXX
                        LD (BC), A
                        ;~ 2 byte ~

                        INC C                               ; next screen character cell (2)

                        ;- 3 byte -
                        LD A, (BC)
                        EXX
                        POP DE
                        OR E
                        XOR D
                        EXX
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
                        
                        ;- 1 byte -
                        LD A, (BC)
                        EXX
                        POP DE
                        OR E
                        XOR D
                        EXX
                        LD (BC), A
                        ;~ 1 byte ~

                        DEC C                               ; next screen character cell (1)

                        ;- 2 byte -
                        LD A, (BC)
                        EXX
                        POP DE
                        OR E
                        XOR D
                        POP DE          ; skip 3 byte
                        EXX
                        LD (BC), A
                        ;~ 2 byte ~

                        ;- 3 byte -
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
                        INC HL
                        INC HL
                        JP (HL)
SBP_24_1_LS:            ; HL' - shift table
                        ; HL  - exit address
                        ; D   - const value
                        ; BC  - row screen address

                        ;- 1 byte -
                        ; skip
                        ;~ 1 byte ~

                        ;- 2 byte -
                        ; modify the right side of a byte
                        LD A, (BC)
                        EXX
                        POP DE                              ; skip 1 byte
                        POP DE
                        ;INC H                               ; calculate right shift address
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        ;~ 2 byte ~

                        DEC H                               ; calculate left shift address

                        ;- 3 byte -
                        ; modify the left side of a byte
                        POP DE
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        EXX
                        LD (BC), A

                        INC C                               ; next screen character cell (3)
                        
                        ; modify the right side of a byte
                        LD A, (BC)
                        EXX
                        INC H                               ; calculate right shift address
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        EXX
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
                        
                        ;- 1 byte -
                        ; modify the right side of a byte
                        LD A, (BC)
                        EXX
                        POP DE
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        EXX
                        LD (BC), A

                        DEC C                               ; next screen character cell (2)

                        ; modify the left side of a byte
                        LD A, (BC)
                        EXX
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
                        POP DE                              ; skip 1 byte
                        EXX
                        LD (BC), A
                        ;~ 2 byte ~

                        ;- 3 byte -
                        ; skip
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
                        INC HL
                        INC HL
                        JP (HL)
SBP_24_2_L:             ; HL' - shift table
                        ; HL  - exit address
                        ; D   - const value
                        ; BC  - row screen address

                        ;- 1 byte -
                        ; skip
                        ;~ 1 byte ~

                        ;- 2 byte -
                        ; skip
                        ;~ 2 byte ~

                        ;- 3 byte -
                        LD A, (BC)
                        EXX
                        POP DE      ; skip 1 byte
                        POP DE      ; skip 2 byte
                        POP DE
                        OR E
                        XOR D
                        EXX
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
                        
                        ;- 1 byte -
                        LD A, (BC)
                        EXX
                        POP DE
                        OR E
                        XOR D
                        POP DE      ; skip 2 byte
                        POP DE      ; skip 3 byte
                        EXX
                        LD (BC), A
                        ;~ 1 byte ~

                        ;- 2 byte -
                        ; skip
                        ;~ 2 byte ~

                        ;- 3 byte -
                        ; skip
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
                        INC HL
                        INC HL
                        JP (HL)

SBP_24_2_LS:            ; HL' - shift table
                        ; HL  - exit address
                        ; D   - const value
                        ; BC  - row screen address
                        
                        ;- 1 byte -
                        ; skip
                        ;~ 1 byte ~

                        ;- 2 byte -
                        ; skip
                        ;~ 2 byte ~

                        ;- 3 byte -
                        ; modify the right side of a byte
                        LD A, (BC)
                        EXX
                        POP DE                              ; skip 1 byte
                        POP DE                              ; skip 2 byte
                        POP DE
                        ;INC H                               ; calculate right shift address
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        EXX
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
                        
                        ;- 1 byte -
                        ; modify the right side of a byte
                        LD A, (BC)
                        EXX
                        POP DE
                        LD L, E     ; OR
                        OR (HL)
                        LD L, D     ; XOR
                        XOR (HL)
                        POP DE                              ; skip 2 byte
                        POP DE                              ; skip 1 byte
                        EXX
                        LD (BC), A
                        ;~ 1 byte ~

                        ;- 2 byte -
                        ; skip
                        ;~ 2 byte ~

                        ;- 3 byte -
                        ; skip
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
                        INC HL
                        INC HL
                        JP (HL)

                        endif ; ~_CORE_DISPLAY_SPRITE_BY_PIXEL_