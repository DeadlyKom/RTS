
                ifndef _CORE_MEMORY_PAGE_02_
                define _CORE_MEMORY_PAGE_02_

                MMU 2, 2
                ORG Page_2
                
                module MemoryPage_2
Start:
;                 LD HL, Page_5                                   ; загружаем по адресу Page_5
; .Count          LD BC, Exit
;                 PUSH HL
;                 PUSH BC
;                 LD BC, .Count
;                 PUSH BC
;                 XOR A
;                 LD (#5CD6), A
;                 LD C, #5F
;                 LD BC, #2090
;                 PUSH BC
;                 LD BC, #17F
;                 JP #3D2F
; Exit:           DI
;                 POP HL
;                 LD A, (#5CD6)
;                 INC H
;                 JR Start.Count
;                 RET
; OUT1:           LD C, #1F
; OUTC:           LD IX, #2A53
; DOS:            PUSH IX
;                 JP #3D2F

                include "../Interrupt.asm"
                include "../../Input/Include.inc"
                include "../Display/TileMap.asm"
                include "../../Utils/CalculateAddressByPixel.asm"
                include "../Display/SpriteByPixel.asm"
                include "../Display/BackgroundFill.asm"
End:
                endmodule

                
SizePage_2:     EQU MemoryPage_2.End - MemoryPage_2.Start

                endif ; ~_CORE_MEMORY_PAGE_02_
