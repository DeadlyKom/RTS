
                    ifndef _MEMORY_COPY_
                    define _MEMORY_COPY_
; -----------------------------------------
; копирование спрайта в общий буфер
; In:
;   HL - начальный адрес спрайта (мб со смещением)
;   BС - размер спрайта (B - ширина в знакоместах, C - высота в пикселях)
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Sprite:             
                    ADD A, A                                                    ; проверка бита FSSF_MASK_BIT
                    JP C, .SharedMask

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

.SharedMask        ;

                    RET

; _192_bytes:         RestoreHL

;                     LD (MC_ContainerSP), SP
;                     LD E, (HL)
;                     INC HL
;                     LD D, (HL)
;                     INC HL
;                     LD (.ContainerSP_), HL
;                     EX DE, HL
; .ContainerSP_       EQU $+1
;                     LD SP, #0000
;                     JP MemCopy._192
MemCopy:
.Count              defl SharedBuffer + 48
; ._192               dup 96 - 72
;                     LD	(.Count), HL
; .Count              = .Count + 2
;                     POP HL
;                     edup

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

                    ; ; копирование в 1 массив 
                    ; ; SP - адрес спрайта
                    ; ; HL - буфер
                    ; ; DE - адрес маски
                    ; POP BC
                    ; LD (HL), C
                    ; INC L
                    ; LD A, (DE)
                    ; LD (HL), A
                    ; INC L
                    ; INC DE
                    ; LD (HL), B
                    ; LD A, (DE)
                    ; LD (HL), A
                    ; INC L
                    ; INC DE

                    ; ; HL - спрайт
                    ; ; DE - буфер
                    ; ; BC - маска
                    ; LD A, (BC)
                    ; LDI
                    ; LD (DE), A
                    ; INC DE

                    endif ; ~_MEMORY_COPY_
