
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

                ifdef SHOW_FPS
	            include "../../Utils/FPS_Counter.asm"
                endif

                include "../../Input/Include.inc"
                include "../Display/TileMap.asm"
                include "../Display/TileMapEX.asm"
                include "../../Utils/CalculateAddressByPixel.asm"
                ; include "../Display/SpriteByPixel.asm"
                ; include "../Display/DrawSpriteByPixel.asm"
                include "../Display/BackgroundFill.asm"
                include "../Handler/Unit.asm"
                
MetodsDisplayBegin:
                ; ---------- 8 ----------
                include "../Display/Metods/8_0.asm"
                include "../Display/Metods/8_0_Shift.asm"
                include "../Display/Metods/8_0_LeftShift.asm"
                include "../Display/Metods/8_0_RightShift.asm"
                ; ---------- 16 ----------
                include "../Display/Metods/16_0.asm"
                include "../Display/Metods/16_0_Shift.asm"
                include "../Display/Metods/16_0_LeftShift.asm"
                include "../Display/Metods/16_0_RightShift.asm"
                include "../Display/Metods/16_1_Left.asm"
                include "../Display/Metods/16_1_Right.asm"
                include "../Display/Metods/16_1_LeftShift.asm"
                include "../Display/Metods/16_1_RightShift.asm"
                ; ---------- 24 ----------
                include "../Display/Metods/24_0.asm"
                include "../Display/Metods/24_0_Shift.asm"
                include "../Display/Metods/24_0_LeftShift.asm"
                include "../Display/Metods/24_0_RightShift.asm"
                include "../Display/Metods/24_1_Left.asm"
                include "../Display/Metods/24_1_Right.asm"
                include "../Display/Metods/24_1_LeftShift.asm"
                include "../Display/Metods/24_1_RightShift.asm"
                include "../Display/Metods/24_2_Left.asm"
                include "../Display/Metods/24_2_Right.asm"
                include "../Display/Metods/24_2_LeftShift.asm"
                include "../Display/Metods/24_2_RightShift.asm"
                ; ---------- 32 ----------                          ?
MetodsDisplayEnd:
                display "Metods Display :  ", /A, MetodsDisplayEnd - MetodsDisplayBegin
End:
                endmodule

                
SizePage_2:     EQU MemoryPage_2.End - MemoryPage_2.Start

                endif ; ~_CORE_MEMORY_PAGE_02_
