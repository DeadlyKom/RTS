
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
                    LD (ContainerSP), SP
                    LD SP, HL
                    JP MemSet_192
SafeFill_768:       ; fill 768 byts
                    RestoreDE
                    LD (ContainerSP), SP
                    LD SP, HL

MemSet_768:         dup	96 * 3
                    PUSH DE
                    edup

MemSet_192:         dup	96 * 1
                    PUSH DE
                    edup
ContainerSP:        EQU $+1
                    LD SP, #0000
                    RET

                    endif ; ~_MEMORY_SET_