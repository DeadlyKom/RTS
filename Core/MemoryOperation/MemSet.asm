
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
SafeFill_256:       ; fill 256 bytes
                    RestoreDE
                    LD (MS_ContainerSP), SP
                    LD SP, HL
                    JP MemSet_256
SafeFill_192:       ; fill 192 bytes
                    RestoreDE
                    LD (MS_ContainerSP), SP
                    LD SP, HL
                    JP MemSet_192
SafeFill_128:       ; fill 128 bytes
                    RestoreDE
                    LD (MS_ContainerSP), SP
                    LD SP, HL
                    JP MemSet_128
SafeFill_32:        ; fill 32 bytes
                    RestoreDE
                    LD (MS_ContainerSP), SP
                    LD SP, HL
                    JP MemSet_32
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
SafeFill_4096:      RestoreDE
                    LD (.ContainerSP), SP
                    LD SP, HL
                    LD A, #23
                    LD (MS_ContainerSP - 1), A
                    LD (MS_ContainerSP + 0), A
                    LD A, #E9
                    LD (MS_ContainerSP + 1), A
                    LD IX, MemSet_512
                    LD HL, .Jumps
.Jumps              dup 8
                    JP (IX)
                    edup
.ContainerSP        EQU $+1
                    LD SP, #0000
                    LD A, #31
                    LD (MS_ContainerSP - 1), A
                    RET
SafeFill_2048:      RestoreDE
                    LD (.ContainerSP), SP
                    LD SP, HL
                    LD A, #23
                    LD (MS_ContainerSP - 1), A
                    LD (MS_ContainerSP + 0), A
                    LD A, #E9
                    LD (MS_ContainerSP + 1), A
                    LD IX, MemSet_512
                    LD HL, .Jumps
.Jumps              dup 4
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

MemSet_768:         dup	128                                                     ; 128 * 2 = 256 bytes
                    PUSH DE
                    edup
MemSet_512:         dup	128                                                     ; 128 * 2 = 256 bytes
                    PUSH DE
                    edup
MemSet_256:         dup	32                                                      ; 32 * 2  = 64 bytes
                    PUSH DE
                    edup
MemSet_192:         dup	32                                                      ; 32 * 2  = 64 bytes
                    PUSH DE
                    edup
MemSet_128:         dup 48                                                      ; 48 * 2  = 96 bytes
                    PUSH DE
                    edup
MemSet_32:          dup	16                                                      ; 16 * 2  = 32 bytes
                    PUSH DE
                    edup
MS_ContainerSP:     EQU $+1
                    LD SP, #0000
                    RET

                    endif ; ~_MEMORY_SET_