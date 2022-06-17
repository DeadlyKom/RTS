
                ifndef _CORE_MODULE_DRAW_ATTRIBUTE_DRAW_STENCIL_SPRITE_
                define _CORE_MODULE_DRAW_ATTRIBUTE_DRAW_STENCIL_SPRITE_

                module Attribute
; -----------------------------------------
; отрисовка спрайта с атрибутами
; In:
;   HL - адрес спрайта
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawStencilSpr: LD E, (HL)
                INC HL
                LD D, (HL)

                LD A, E
                OR D
                RET Z

                INC HL
                LD C, (HL)
                INC HL
                LD B, (HL)
                INC HL

                CALL PixelAddressC
    
.Box_0          PUSH DE
                PUSH BC
                LD B, C

.Box_1          PUSH DE
                CALL DrawCharBoundary
                INC HL
                POP DE
                INC E
                DJNZ .Box_1
                POP BC
                POP DE

                ; DOWN DE
                LD A, E
                ADD A, #20
                LD E, A
                JR NC, .Box_2
                LD A, D
                ADD A, #08
                LD D, A

.Box_2          DJNZ .Box_0
                JR DrawStencilSpr

                display " - Draw Stencil Sprite : \t", /A, DrawStencilSpr, " = busy [ ", /D, $ - DrawStencilSpr, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_ATTRIBUTE_DRAW_STENCIL_SPRITE_
