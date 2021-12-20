
                    ifndef _MEMORY_COPY_
                    define _MEMORY_COPY_
Sprite:             
                    ADD A, A                                                    ; проверка бита FSSF_MASK_BIT
                    JP C, .Alternation

                    RestoreHL
                    EX DE, HL

                    ; ---------------------------------------------
                    ; B - Sx (ширина спрайта в знакоместах)
                    ; C - Sy (высота спрайта в пикселях)
                    ; ---------------------------------------------

                    ; Sx * Sy
                    XOR A
.Mult_SySx          ADD A, C
                    DJNZ .Mult_SySx

                    ; A = ((-A) << 1) + 144
                    NEG
                    ADD A, A
                    ADD A, 144
                    
                    LD L, A

                    ADD A, 192 - 144
                    LD (SpriteAdr), A

                    LD H, B
                    ADD HL, HL
                    LD BC, MemCopy._144
                    ADD HL, BC
                    LD (.MemCopyJump), HL
                    LD (MC_ContainerSP), SP

                    EX DE, HL
 
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

                    ; POP DE
                    ; LD (HL), E
                    ; INC L
                    ; INC L
                    ; LD (HL), D
                    ; INC L
                    ; INC L

                    ; LDI
                    ; INC E
                    ; LDI
                    ; INC E

                    ; POP DE
                    ; LD A, E
                    ; LD (0), A
                    ; LD A, E
                    ; LD (0), A

                    ; LDI
                    ; PUSH HL
                    ; INC C
                    ; LD L, C
                    ; LD H, B
                    ; LDI
                    ; POP HL
                    
                    ; EXX
                    ; LDI
                    ; EXX

                    ; POP DE
                    ; LD (IX + 0), E
                    ; LD (IX + 1), D


                    endif ; ~_MEMORY_COPY_