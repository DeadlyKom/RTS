
                    ifndef _MEMORY_COPY_
                    define _MEMORY_COPY_

                    module MEMCPY
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
; -----------------------------------------
; copy visible tilemap block
; In:
;   HL  - starting address of the visible tilemap block
; Corrupt:
;   HL, DE, BC, AF, HL', DE', BC', AF'
; Note:
;   interruption must be disabled
; -----------------------------------------
Tilemap:            ;
                    LD (.ContainerSP), SP
                    LD A, (TilemapWidth)
                    LD E, A
                    LD D, #00
                    
                    ; copy 192 byte (16 * 12)
.Offset             defl 0
                    dup 16
                    LD SP, HL
                    POP IX
                    POP IY
                    POP BC
                    POP AF
                    EX AF, AF'
                    POP AF
                    EXX
                    POP HL
                    POP DE
                    POP BC
                    ; сохранение 16 байт
                    LD SP, SharedBuffer + .Offset
                    PUSH BC
                    PUSH DE
                    PUSH HL
                    EXX
                    PUSH AF
                    EX AF, AF'
                    PUSH AF
                    PUSH BC
                    PUSH IY
                    PUSH IX
                    ADD HL, DE
.Offset             = .Offset + 16
                    edup
.ContainerSP        EQU $+1
                    LD SP, #0000
                    RET

                    endmodule

                    endif ; ~_MEMORY_COPY_