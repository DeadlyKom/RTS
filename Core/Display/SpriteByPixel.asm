  
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

DrawTwoRow_OR_XOR:      EXX
                        ;- 1 byte -
                        ; modify the left side of a byte
                        LD A, (BC)
                        LD E, (HL)
                        EX DE, HL
                        OR (HL)
                        EX DE, HL
                        INC HL
                        LD E, (HL)
                        EX DE, HL
                        XOR (HL)
                        LD (BC), A
                        EX DE, HL

                        INC C                               ; next screen character cell
                        DEC HL                              ; previous sprite address
                        INC D                               ; calculate right shift address
                        
                        ; modify the right side of a byte
                        LD A, (BC)
                        LD E, (HL)
                        EX DE, HL
                        OR (HL)
                        EX DE, HL
                        INC HL
                        LD E, (HL)
                        EX DE, HL
                        XOR (HL)
                        ;LD (BC), A
                        EX DE, HL

                        INC HL                              ; next sprite address
                        DEC D                               ; calculate left shift address
                        ;~ 1 byte ~

                        ;- 2 byte -
                        ; modify the left side of a byte
                        ;LD A, (BC)
                        LD E, (HL)
                        EX DE, HL
                        OR (HL)
                        EX DE, HL
                        INC HL
                        LD E, (HL)
                        EX DE, HL
                        XOR (HL)
                        LD (BC), A
                        EX DE, HL

                        INC C                               ; next screen character cell
                        DEC HL                              ; previous sprite address
                        INC D                               ; calculate right shift address
                        
                        ; modify the right side of a byte
                        LD A, (BC)
                        LD E, (HL)
                        EX DE, HL
                        OR (HL)
                        EX DE, HL
                        INC HL
                        LD E, (HL)
                        EX DE, HL
                        XOR (HL)
                        ;LD (BC), A
                        EX DE, HL

                        INC HL                              ; next sprite address
                        DEC D                               ; calculate left shift address
                        ;~ 2 byte ~

                        ;- 3 byte -
                        ; modify the left side of a byte
                        ;LD A, (BC)
                        LD E, (HL)
                        EX DE, HL
                        OR (HL)
                        EX DE, HL
                        INC HL
                        LD E, (HL)
                        EX DE, HL
                        XOR (HL)
                        LD (BC), A
                        EX DE, HL

                        INC C                               ; next screen character cell
                        DEC HL                              ; previous sprite address
                        INC D                               ; calculate right shift address
                        
                        ; modify the right side of a byte
                        LD A, (BC)
                        LD E, (HL)
                        EX DE, HL
                        OR (HL)
                        EX DE, HL
                        INC HL
                        LD E, (HL)
                        EX DE, HL
                        XOR (HL)
                        LD (BC), A
                        EX DE, HL

                        INC HL                              ; next sprite address
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
                        LD E, (HL)
                        EX DE, HL
                        OR (HL)
                        EX DE, HL
                        INC HL
                        LD E, (HL)
                        EX DE, HL
                        XOR (HL)
                        LD (BC), A
                        EX DE, HL

                        DEC C                               ; next screen character cell !
                        DEC HL                              ; previous sprite address
                        DEC D                               ; calculate left shift address
                        
                        ; modify the left side of a byte
                        LD A, (BC)
                        LD E, (HL)
                        EX DE, HL
                        OR (HL)
                        EX DE, HL
                        INC HL
                        LD E, (HL)
                        EX DE, HL
                        XOR (HL)
                        ;LD (BC), A
                        EX DE, HL

                        INC HL                              ; next sprite address
                        INC D                               ; calculate right shift address
                        ;~ 1 byte ~

                        ;- 2 byte -
                        ; modify the right side of a byte
                        ;LD A, (BC)
                        LD E, (HL)
                        EX DE, HL
                        OR (HL)
                        EX DE, HL
                        INC HL
                        LD E, (HL)
                        EX DE, HL
                        XOR (HL)
                        LD (BC), A
                        EX DE, HL

                        DEC C                               ; next screen character cell !
                        DEC HL                              ; previous sprite address
                        DEC D                               ; calculate left shift address
                        
                        ; modify the left side of a byte
                        LD A, (BC)
                        LD E, (HL)
                        EX DE, HL
                        OR (HL)
                        EX DE, HL
                        INC HL
                        LD E, (HL)
                        EX DE, HL
                        XOR (HL)
                        ;LD (BC), A
                        EX DE, HL

                        INC HL                              ; next sprite address
                        INC D                               ; calculate right shift address
                        ;~ 2 byte ~

                        ;- 3 byte -
                        ; modify the right side of a byte
                        ;LD A, (BC)
                        LD E, (HL)
                        EX DE, HL
                        OR (HL)
                        EX DE, HL
                        INC HL
                        LD E, (HL)
                        EX DE, HL
                        XOR (HL)
                        LD (BC), A
                        EX DE, HL

                        DEC C                               ; next screen character cell !
                        DEC HL                              ; previous sprite address
                        DEC D                               ; calculate left shift address
                        
                        ; modify the left side of a byte
                        LD A, (BC)
                        LD E, (HL)
                        EX DE, HL
                        OR (HL)
                        EX DE, HL
                        INC HL
                        LD E, (HL)
                        EX DE, HL
                        XOR (HL)
                        LD (BC), A
                        EX DE, HL

                        INC HL                              ; next sprite address
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

DrawTwoRows_OR_XOR:     ; HL' - shift table
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
                        ;EXX
                        INC HL
                        INC HL
                        JP (HL)

; -----------------------------------------
; display sprite by pixel
; In:
;   HL - address sprite
;   DE - coordinates in pixels (C - x, B - y)
; Out:
; Corrupt:
; -----------------------------------------
DisplaySBP_Ex:          CALL CalcAddrByPixel_BC                 ; A - storage the shifts count
                        JP Z, .DisplayWithoutShift
                        
                        ; initialize execute blocks
                        DI
                        LD (.ContainerSP), SP
                        LD SP, HL

                        EXX
                        ; calculate address of shift table
                        DEC A
                        ADD A, A
                        ADD A, HIGH DisplaySBP.ShiftTable
                        LD H, A
                        EXX

                        LD IX, DrawTwoRows_OR_XOR

                        LD HL, $+3
                        rept 12                                                 ; number of columns per row
                        JP (IX)
                        endr

.ContainerSP            EQU $+1
                        LD SP, #0000
                        EI
                        RET
.DisplayWithoutShift
                        RET


; -----------------------------------------
; display sprite by pixel
; In:
;   HL - address sprite
;   DE - coordinates in pixels (C - x, B - y)
; Out:
; Corrupt:
; -----------------------------------------
DisplaySBP:             CALL CalcAddrByPixel_BC                 ; A - storage the shifts count
                        JP Z, .DisplayWithoutShift
                        ; calculate address of shift table
                        DEC A
                        ADD A, A
                        ADD A, HIGH .ShiftTable
                        LD D, A
                        ;
                        LD IX, DrawTwoRow_OR_XOR

                        ; HL - sprite address
                        ; DE - shift table
                        ; BC - row screen address

                        EXX
                        LD HL, $+3
                        rept 12                                                 ; number of columns per row
                        JP (IX)
                        endr
                        
                        RET

.DisplayWithoutShift
                        RET

.Shift                  defl 7
.Count                  defl 0

                        align 256
.ShiftTable
                        dup 7
.Count = 0
                        dup 256
                        DB ((.Count << .Shift) >> 8) & 0xFF
.Count = .Count + 1
                        edup

.Count = 0
                        dup 256
                        DB ((.Count << .Shift) >> 0) & 0xFF
.Count = .Count + 1
                        edup
.Shift = .Shift - 1
                        edup

                        endif ; ~_CORE_DISPLAY_SPRITE_BY_PIXEL_