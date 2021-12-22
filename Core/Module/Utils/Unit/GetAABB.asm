
                ifndef _CORE_MODULE_UTILS_AABB_GET_RECT_
                define _CORE_MODULE_UTILS_AABB_GET_RECT_

                module AABB
; -----------------------------------------
; получить описывающий прямоугольник указанного юнита
; In:

; Out:
; Corrupt:
; Note:

; -----------------------------------------
GetRect:        
                ; JR $

                CALL Sprite.FastClipping
                RET C
                
                ; получение адреса хранения информации о спрайте
                DEC D                                                           ; DE = FUnitState.Animation
                DEC E
                CALL Animation.SpriteInfo

                INC D

                ; ---------------------------------------------
                CALL Sprite.Clipping.Vertical
                RET C
                ; ---------------------------------------------
                CALL Sprite.Clipping.Horizontal
                RET C

                RET
                
                

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_AABB_GET_RECT_