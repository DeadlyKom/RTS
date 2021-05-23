
                    ifndef _MEMORY_COPY_TILEMAP_
                    define _MEMORY_COPY_TILEMAP_

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
                    LD SP, SharedBuffer + 16 + .Offset
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

                    endif ; ~_MEMORY_COPY_TILEMAP_