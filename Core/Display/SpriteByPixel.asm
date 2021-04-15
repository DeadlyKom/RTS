  
                        ifndef _CORE_DISPLAY_SPRITE_BY_PIXEL_
                        define _CORE_DISPLAY_SPRITE_BY_PIXEL_

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
                        ; calculate left shift address
                        DEC A
                        ADD A, A
                        ADD A, HIGH .ShiftTable
                        LD D, A

                        ; HL - sprite
                        ; DE - table
                        ; BC - screen

                        rept 12

                        ; rept 2

                        ; LD A, (BC)
                        ; LD E, (HL)
                        ; EX DE, HL
                        ; OR (HL)
                        ; EX DE, HL
                        ; INC HL
                        ; LD E, (HL)
                        ; EX DE, HL
                        ; XOR (HL)
                        ; LD (BC), A
                        ; EX DE, HL

                        ; INC C                               ; next screen character cell
                        ; DEC HL                              ; previous sprite address
                        ; INC D                               ; calculate right shift address
                        
                        ; LD A, (BC)
                        ; LD E, (HL)
                        ; EX DE, HL
                        ; OR (HL)
                        ; EX DE, HL
                        ; INC HL
                        ; LD E, (HL)
                        ; EX DE, HL
                        ; XOR (HL)
                        ; LD (BC), A
                        ; EX DE, HL

                        ; INC HL                              ; next sprite address
                        ; DEC D                               ; calculate left shift address

                        ; endr

                        ;- 1 byte
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
                        ;~ 1 byte

                        ;- 2 byte
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
                        ;~ 2 byte

                        ;- 3 byte
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
                        ;~ 3 byte

                        ; DOWN_BC 25/59
                        INC B
                        LD A, B
                        AND #07
                        JP NZ, $+12 ;.NextLine
                        LD A, C
                        SUB #E0
                        LD C, A
                        SBC A
                        AND #F8
                        ADD A, B
                        LD B, A
                        
;`.NextLine             

                        ; rept 2

                        ; LD A, (BC)
                        ; LD E, (HL)
                        ; EX DE, HL
                        ; OR (HL)
                        ; EX DE, HL
                        ; INC HL
                        ; LD E, (HL)
                        ; EX DE, HL
                        ; XOR (HL)
                        ; LD (BC), A
                        ; EX DE, HL

                        ; DEC C                               ; next screen character cell !
                        ; DEC HL                              ; previous sprite address
                        ; DEC D                               ; calculate right shift address
                        
                        ; LD A, (BC)
                        ; LD E, (HL)
                        ; EX DE, HL
                        ; OR (HL)
                        ; EX DE, HL
                        ; INC HL
                        ; LD E, (HL)
                        ; EX DE, HL
                        ; XOR (HL)
                        ; LD (BC), A
                        ; EX DE, HL

                        ; INC HL                              ; next sprite address
                        ; INC D                               ; calculate left shift address

                        ; endr
                        
                        ;- 1 byte
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
                        DEC D                               ; calculate right shift address
                        
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
                        INC D                               ; calculate left shift address
                        ;~ 1 byte

                        ;- 2 byte
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
                        DEC D                               ; calculate right shift address
                        
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
                        INC D                               ; calculate left shift address
                        ;~ 2 byte

                        ;- 3 byte
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
                        DEC D                               ; calculate right shift address
                        
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
                        ;~ 3 byte

                        ; DOWN_BC 25/59
                        INC B
                        LD A, B
                        AND #07
                        JP NZ, $+12 ;.NextLine
                        LD A, C
                        SUB #E0
                        LD C, A
                        SBC A
                        AND #F8
                        ADD A, B
                        LD B, A
                        
;`.NextLine             
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