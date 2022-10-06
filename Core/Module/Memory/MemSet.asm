
                ifndef _MEMORY_SET_
                define _MEMORY_SET_

                module Memset
Begin:          EQU $
; -----------------------------------------
; заполнение блока памяти
; In:
;   HL  - адрес блока памяти для заполнения
;   DE  - значение для заполнения
; Out:
; Corrupt:
;   HL, DE, AF, IX
; Note:
;   адрес блока должен учитываться с размером заполняемой области
;   т.к. заполнение происходит используя стек и PUSH
; -----------------------------------------
SafeFill_256:   RestoreDE
                LD (MS_ContainerSP), SP
                LD SP, HL
                JP MemSet_256
SafeFill_192:   RestoreDE
                LD (MS_ContainerSP), SP
                LD SP, HL
                JP MemSet_192
SafeFill_128:   RestoreDE
                LD (MS_ContainerSP), SP
                LD SP, HL
                JP MemSet_128
SafeFill_32:    RestoreDE
                LD (MS_ContainerSP), SP
                LD SP, HL
                JP MemSet_32
SafeFill_Screen RestoreDE
                LD (.ContainerSP), SP
                LD SP, HL
                LD A, #23
                LD (MS_ContainerSP - 1), A
                LD (MS_ContainerSP + 0), A
                LD A, #E9
                LD (MS_ContainerSP + 1), A
                LD IX, MemSet_768
                LD HL, .Jumps
.Jumps          dup 8
                JP (IX)
                edup
.ContainerSP    EQU $+1
                LD SP, #0000
                LD A, #31
                LD (MS_ContainerSP - 1), A
                RET
SafeFill_4096:  RestoreDE
                LD (.ContainerSP), SP
                LD SP, HL
                LD A, #23
                LD (MS_ContainerSP - 1), A
                LD (MS_ContainerSP + 0), A
                LD A, #E9
                LD (MS_ContainerSP + 1), A
                LD IX, MemSet_512
                LD HL, .Jumps
.Jumps          dup 8
                JP (IX)
                edup
.ContainerSP    EQU $+1
                LD SP, #0000
                LD A, #31
                LD (MS_ContainerSP - 1), A
                RET
SafeFill_2048:  RestoreDE
                LD (.ContainerSP), SP
                LD SP, HL
                LD A, #23
                LD (MS_ContainerSP - 1), A
                LD (MS_ContainerSP + 0), A
                LD A, #E9
                LD (MS_ContainerSP + 1), A
                LD IX, MemSet_512
                LD HL, .Jumps
.Jumps          dup 4
                JP (IX)
                edup
.ContainerSP    EQU $+1
                LD SP, #0000
                LD A, #31
                LD (MS_ContainerSP - 1), A
                RET
SafeFill_768:   ; 768
                RestoreDE
                LD (MS_ContainerSP), SP
                LD SP, HL

MemSet_768:     dup 128                                                         ; 128 * 2 = 256 bytes
                PUSH DE
                edup
MemSet_512:     dup 128                                                         ; 128 * 2 = 256 bytes
                PUSH DE
                edup
MemSet_256:     dup 32                                                          ; 32 * 2  = 64 bytes
                PUSH DE
                edup
MemSet_192:     dup 32                                                          ; 32 * 2  = 64 bytes
                PUSH DE
                edup
MemSet_128:     dup 48                                                          ; 48 * 2  = 96 bytes
                PUSH DE
                edup
MemSet_32:      dup 16                                                          ; 16 * 2  = 32 bytes
                PUSH DE
                edup
MS_ContainerSP: EQU $+1
                LD SP, #0000
                RET

                display " - Memory Set : \t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~_MEMORY_SET_