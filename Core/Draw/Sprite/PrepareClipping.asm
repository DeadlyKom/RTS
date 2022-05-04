
                ifndef _DRAW_SPRITE_PREPARE_CLIPPING_
                define _DRAW_SPRITE_PREPARE_CLIPPING_

                module Clipping
NOT_CLIP_VERT   EQU 0x00 * 4
CLIP_TOP        EQU 0x01 * 4
CLIP_BOTTOM     EQU 0x02 * 4
NOT_CLIP_HORIZ  EQU 0x00
CLIP_LEFT       EQU 0x01
CLIP_RIGHT      EQU 0x02

; -----------------------------------------
; подготовка перед отрисовкой спрайта
; In:
; Out:
; Corrupt:
; Note:
;   Lx, Ly   - позиция спрайта (в тайлах)
;   Vx, Vy   - позиция видимой области карты (в тайлах)
;   Ox, Oy   - смещение спрайта относительно тайла (в пикселах)
;   Sx, Sy   - размер спрайта (х - в знакоместах, y - в пикселах)
;   SOx, SOy - смещение спрайта (в пикселах)
; -----------------------------------------
Prepare:        
.Vertical       EQU $+1
                LD A, #00
.Horizontal     EQU $+1
                ADD A, #00
                LD (.Jump), A
.Jump           EQU $+1
                JR $
                
                JP .V0_H0
                DB #00                                                          ; dummy
                JP .V0_H1
                DB #00                                                          ; dummy
                JP .V0_H2
                DB #00                                                          ; dummy

                JP .V1_H0
                DB #00                                                          ; dummy
                JP .V1_H1
                DB #00                                                          ; dummy
                JP .V1_H2
                DB #00                                                          ; dummy

                JP .V2_H0
                DB #00                                                          ; dummy
                JP .V2_H1
                DB #00                                                          ; dummy
                JP .V2_H2
                DB #00                                                          ; dummy

; ---------------------------------------------
; спрайт видин полностью
; ---------------------------------------------
.V0_H0          RET
.V0_H1          RET
.V0_H2          RET
.V1_H0          RET
.V1_H1          RET
.V1_H2          RET
.V2_H0          RET
.V2_H1          RET
.V2_H2          RET

                endmodule

                endif ; ~_DRAW_SPRITE_PREPARE_CLIPPING_
