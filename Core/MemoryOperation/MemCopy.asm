
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

.SkipMult_YxSx      
                    ; A = ((-A) << 1) + 144
                    NEG
                    ADD A, A
                    ADD A, 144
                    
                    LD L, A

                    ADD A, 192 - 144
                    LD (SpriteAdr), A

                    LD H, #00
                    ADD HL, HL
                    ; ADD HL, HL
                    LD BC, MemCopy._144
                    ADD HL, BC
                    LD (.MemCopyJump), HL

                    EX DE, HL

                    LD (MC_ContainerSP), SP
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

                    LD (MC_ContainerSP), SP
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
                    LD	(.Count), HL
MC_ContainerSP      EQU $+1
                    LD SP, #0000
SpriteAdr           EQU $+1
                    LD HL, SharedBuffer
                    RET

                    endif ; ~_MEMORY_COPY_