
                    ifndef _MEMORY_COPY_
                    define _MEMORY_COPY_
_192_bytes:         ;
                    RestoreHL
                    LD (.ContainerSP), SP
                    LD E, (HL)
                    INC HL
                    LD D, (HL)
                    INC HL
                    LD (.ContainerSP_), HL
                    EX DE, HL
.ContainerSP_       EQU $+1
                    LD SP, #0000
                    JP .MemCopy_192

.Count              defl SharedBuffer
.MemCopy_192        dup	96
                    LD	(.Count), HL
.Count              = .Count + 2
                    POP HL
                    edup

.ContainerSP        EQU $+1
                    LD SP, #0000
                    RET

                    endif ; ~_MEMORY_COPY_