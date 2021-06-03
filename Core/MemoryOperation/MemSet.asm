
                    ifndef _MEMORY_SET_
                    define _MEMORY_SET_

; -----------------------------------------
; fill block of memory
; In:
;   HL  - pointer to the block of memory to fill
;   DE  - value to be set
; Corrupt:
;   AF
; -----------------------------------------
SafeFill_192:       ; fill 192 byts
                    RestoreDE
                    LD (MS_ContainerSP), SP
                    LD SP, HL
                    JP MemSet_192
SafeFill_Screen:    RestoreDE
                    LD (.ContainerSP), SP
                    LD SP, HL
                    LD A, #23
                    LD (MS_ContainerSP - 1), A
                    LD (MS_ContainerSP + 0), A
                    LD A, #E9
                    LD (MS_ContainerSP + 1), A
                    LD IX, MemSet_768
                    LD HL, .Jumps
.Jumps              dup 8
                    JP (IX)
                    edup
.ContainerSP        EQU $+1
                    LD SP, #0000
                    LD A, #31
                    LD (MS_ContainerSP - 1), A
                    RET
SafeFill_768:       ; fill 768 byts
                    RestoreDE
                    LD (MS_ContainerSP), SP
                    LD SP, HL

MemSet_768:         dup	96 * 3
                    PUSH DE
                    edup

MemSet_192:         dup	96 * 1
                    PUSH DE
                    edup
MS_ContainerSP:     EQU $+1
                    LD SP, #0000
                    RET



                    endif ; ~_MEMORY_SET_