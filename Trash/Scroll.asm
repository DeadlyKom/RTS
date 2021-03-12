
                ifndef _CORE_SCROLL_
                define _CORE_SCROLL_

; Scroll:
;                 DI
;                 LD (.ContainerSP), SP

; .Offset         defl 0
;                 dup 8
;                 LD SP, #4000 + .Offset + #0040
;                 POP HL
;                 POP DE
;                 POP BC
;                 POP AF
;                 EX AF, AF'
;                 POP AF
;                 EXX
;                 POP HL
;                 POP DE
;                 POP BC

;                 LD SP, #4000 + .Offset + 8 * 2
;                 PUSH BC
;                 PUSH DE
;                 PUSH HL
;                 EXX
;                 PUSH AF
;                 EX AF, AF'
;                 PUSH AF
;                 PUSH BC
;                 PUSH DE
;                 PUSH HL

; .Offset = .Offset + #0100
;                 edup

; .Offset         defl 0
;                 dup 8
;                 LD SP, #4000 + .Offset + #0060
;                 POP HL
;                 POP DE
;                 POP BC
;                 POP AF
;                 EX AF, AF'
;                 POP AF
;                 EXX
;                 POP HL
;                 POP DE
;                 POP BC

;                 LD SP, #4020 + .Offset + 8 * 2
;                 PUSH BC
;                 PUSH DE
;                 PUSH HL
;                 EXX
;                 PUSH AF
;                 EX AF, AF'
;                 PUSH AF
;                 PUSH BC
;                 PUSH DE
;                 PUSH HL

; .Offset = .Offset + #0100
;                 edup


; .ContainerSP    EQU $+1
;                 LD SP, #0000
;                 EI
;                 RET

; ScrollEx:       
;                 DI
;                 LD (.ContainerSP), SP
;                 LD SP, HL

;                 dup 7
;                 POP HL
;                 POP DE
;                 POP BC
;                 POP AF
;                 EX AF, AF'
;                 POP IY
;                 EXX
;                 POP IX
;                 POP DE
;                 POP BC

;                 LD HL, #FFC0
;                 ADD HL, SP
;                 LD SP, HL

;                 PUSH BC
;                 PUSH DE
;                 PUSH IX
;                 EXX
;                 PUSH IY
;                 EX AF, AF'
;                 PUSH AF
;                 PUSH BC
;                 PUSH DE
;                 PUSH HL

;                 LD HL, #0140
;                 ADD HL, SP
;                 LD SP, HL
;                 edup

;                 POP HL
;                 POP DE
;                 POP BC
;                 POP AF
;                 EX AF, AF'
;                 POP IY
;                 EXX
;                 POP IX
;                 POP DE
;                 POP BC

;                 LD HL, #FFC0
;                 ADD HL, SP
;                 LD SP, HL

;                 PUSH BC
;                 PUSH DE
;                 PUSH IX
;                 EXX
;                 PUSH IY
;                 EX AF, AF'
;                 PUSH AF
;                 PUSH BC
;                 PUSH DE
;                 PUSH HL

; .ContainerSP    EQU $+1
;                 LD SP, #0000
;                 EI

;                 RET

; ScrollExx:      
;                 DI
;                 LD (.ContainerSP), SP
;                 LD SP, HL

;                 dup 7
;                 POP HL
;                 POP DE
;                 POP BC
;                 POP AF
;                 EX AF, AF'
;                 POP IY
;                 EXX
;                 POP IX
;                 POP DE
;                 POP BC

;                 LD HL, #FFC0
;                 ADD HL, SP
;                 LD SP, HL

;                 PUSH BC
;                 PUSH DE
;                 PUSH IX
;                 EXX
;                 PUSH IY
;                 EX AF, AF'
;                 PUSH AF
;                 PUSH BC
;                 PUSH DE
;                 PUSH HL

;                 LD HL, #0140
;                 ADD HL, SP
;                 LD SP, HL
;                 edup

;                 POP HL
;                 POP DE
;                 POP BC
;                 POP AF
;                 EX AF, AF'
;                 POP IY
;                 EXX
;                 POP IX
;                 POP DE
;                 POP BC

;                 LD HL, #FFC0
;                 ADD HL, SP
;                 LD SP, HL

;                 PUSH BC
;                 PUSH DE
;                 PUSH IX
;                 EXX
;                 PUSH IY
;                 EX AF, AF'
;                 PUSH AF
;                 PUSH BC
;                 PUSH DE
;                 PUSH HL

;                 LD HL, #F960
;                 ADD HL, SP
;                 LD SP, HL
                
;                 dup 7
;                 POP HL
;                 POP DE
;                 POP BC
;                 POP AF
;                 EX AF, AF'
;                 POP IY
;                 EXX
;                 POP IX
;                 POP DE
;                 POP BC

;                 LD HL, #FFC0
;                 ADD HL, SP
;                 LD SP, HL

;                 PUSH BC
;                 PUSH DE
;                 PUSH IX
;                 EXX
;                 PUSH IY
;                 EX AF, AF'
;                 PUSH AF
;                 PUSH BC
;                 PUSH DE
;                 PUSH HL

;                 LD HL, #0140
;                 ADD HL, SP
;                 LD SP, HL
;                 edup

;                 POP HL
;                 POP DE
;                 POP BC
;                 POP AF
;                 EX AF, AF'
;                 POP IY
;                 EXX
;                 POP IX
;                 POP DE
;                 POP BC

;                 LD HL, #FFC0
;                 ADD HL, SP
;                 LD SP, HL

;                 PUSH BC
;                 PUSH DE
;                 PUSH IX
;                 EXX
;                 PUSH IY
;                 EX AF, AF'
;                 PUSH AF
;                 PUSH BC
;                 PUSH DE
;                 PUSH HL

; .ContainerSP    EQU $+1
;                 LD SP, #0000
;                 EI
;                 RET
; Scroll_Up:      
;                 LD HL, #4040 + #40 + #40
;                 CALL ScrollExx
;                 ; LD HL, #4040 + #40 + #40
;                 ; CALL ScrollEx
;                 ; LD HL, #4060 + #40 + #40
;                 ; CALL ScrollEx
;                 RET
; Table:          DW #4040

                endif ; ~_CORE_SCROLL_
