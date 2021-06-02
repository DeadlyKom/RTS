
                    ifndef _MEMORY_COPY_
                    define _MEMORY_COPY_
Sprite:             RestoreHL

                    JP NZ, .Alternation

                    EX DE, HL

                    ; ---------------------------------------------
                    ; B - Sx (ширина спрайта в знакоместах)
                    ; C - Sy (высота спрайта в пикселях)
                    ; ---------------------------------------------

                    ; Sx * Sy
                    LD A, C
                    DEC B
                    JR Z, .SkipMult_YxSx
.Mult_YxSx          ADD A, C
                    DEC B
                    JR NZ, .Mult_YxSx

.SkipMult_YxSx      ; A = ((-A) << 1) + 144
                    NEG
                    ADD A, A
                    ADD A, 144

                    LD L, A
                    LD H, #00
                    ADD HL, HL
                    ADD HL, HL
                    LD BC, MemCopy._144
                    ADD HL, BC
                    LD (.MemCopyJump), HL

                    EX DE, HL

                    LD (ContainerSP), SP
                    LD E, (HL)
                    INC HL
                    LD D, (HL)
                    INC HL
                    LD (.ContainerSP_), HL
                    EX DE, HL

.ContainerSP_       EQU $+1
                    LD SP, #0000

.MemCopyJump        EQU $+1
                    JP #0000

.Alternation        
                    RET

_192_bytes:         RestoreHL

                    LD (ContainerSP), SP
                    LD E, (HL)
                    INC HL
                    LD D, (HL)
                    INC HL
                    LD (.ContainerSP_), HL
                    EX DE, HL
.ContainerSP_       EQU $+1
                    LD SP, #0000
                    JP MemCopy._192
MemCopy:
.Count              defl SharedBuffer
._192               dup 96 - 72
                    LD	(.Count), HL
.Count              = .Count + 2
                    POP HL
                    edup

._144               dup	72
                    LD	(.Count), HL
.Count              = .Count + 2
                    POP HL
                    edup

ContainerSP         EQU $+1
                    LD SP, #0000
                    RET

                    endif ; ~_MEMORY_COPY_