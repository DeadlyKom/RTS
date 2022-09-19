
                ifndef _CORE_MODULE_DRAW_CHARBOUNDARY_DRAW_SPRITE_
                define _CORE_MODULE_DRAW_CHARBOUNDARY_DRAW_SPRITE_

                module Charboundary
; -----------------------------------------
; отрисовка спрайта с атрибутами
; In:
;   HL - адрес спрайта
;   DE - координаты в знакоместах (D - y, E - x)
;   BC - размер (B - y, C - x)
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawSpriteOne:  CALL PixelAddressC
    
.Box_0          PUSH DE
                PUSH BC
                LD B, C

.Box_1          PUSH DE
                CALL DrawCharOne
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
                RET
; -----------------------------------------
; отрисовка спрайта с атрибутами (в 2х экранах)
; In:
;   HL - адрес спрайта
;   DE - координаты в знакоместах (D - y, E - x)
;   BC - размер (B - y, C - x)
; Out:
; Corrupt:
; Note:
;   теневое окно должно находится в 3 банке
; -----------------------------------------
DrawSpriteTwo:  CALL PixelAddressC
    
.Box_0          PUSH DE
                PUSH BC
                LD B, C

.Box_1          PUSH DE
                CALL DrawCharTwo
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
                RET

                display " - Draw Sprite : \t\t\t", /A, DrawSpriteOne, " = busy [ ", /D, $ - DrawSpriteOne, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_CHARBOUNDARY_DRAW_SPRITE_
