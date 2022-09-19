
                ifndef _CORE_MODULE_DRAW_SPRITE_PIXEL_PREPARE_SPRITE_
                define _CORE_MODULE_DRAW_SPRITE_PIXEL_PREPARE_SPRITE_

; -----------------------------------------
; подготовка спрайта перед выводм на экран
; In:
;   IX  - указывает на структуру FUnit
;   HL  - 
;   HL' - дельты значение между краями оси Y    (H - dB.Y, L - dA.Y)
;   DE' - дельты значение между краями оси X    (D - dB.X, E - dA.X)
;   BC' - размер спрайта                        (B - высота, C - ширина)
; Out:
; Corrupt:
; Note:
;   dA.X = a.maxX - b.minX
;   dB.X = b.maxX - a.minX
;   dA.Y = a.maxY - b.minY
;   dB.Y = b.maxY - a.minY
; -----------------------------------------
Prepare:        EXX
                LD A, L
                CP B
                JR C, .ClipTop
                LD A, H
                CP B
                JR C, .ClipBottom
                EXX

                

.ClipTop
.ClipBottom
                RET

                display " - Prepare Sprite : \t\t\t", /A, Prepare, " = busy [ ", /D, $ - Prepare, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_SPRITE_PIXEL_PREPARE_SPRITE_
