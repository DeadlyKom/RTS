
                ifndef _MODULE_TILEMAP_ANIMATION_UPDATE_RENDER_BUFFER_
                define _MODULE_TILEMAP_ANIMATION_UPDATE_RENDER_BUFFER_
; -----------------------------------------
; обновление анимации участка карты находящиеся в рендер буфере
; In:
;    HL - указывает на переменную Animation.Tilemap.Countdown
; Out:
; Corrupt:
; Note:
; -----------------------------------------
AnimTile        ; установка обртного счётчика
                LD (HL), DURATION_TILE_ANIM

                CALL TileSampling
                RET

.Size           DB #00
.Array          FAnimTile = $
                DS FAnimTile * ANIMATED_TILES

;                 ; инициализация
;                 LD HL, .Counter
;                 LD DE, RenderBuffer
;                 LD B, RenderBufSize
;                 LD C, RENDER_INC

; .Loop           ; основной цикл обновления рендер буфера
;                 LD A, (DE)
;                 ADD A, A
;                 JR C, .NextCell
;                 JR Z, .Sampling

;                 RRA
;                 ADD A, C
;                 BIT RENDER_INC_BIT, A
;                 JR Z, .SetUpdate
                
;                 INC (HL)
;                 XOR A

; .SetUpdate      ; установка обновления тайла
;                 OR RENDER_TILE
;                 LD (DE), A

; .NextCell       INC E
;                 DJNZ .Loop

;                 RET

; .Sampling       
; .Counter        EQU $+1
;                 LD A, #08
;                 DEC A
;                 JP M, .NextCell

;                 EXX
;                 CALL Math.Rand8
;                 EXX

;                 CP #0F                                                          ; чем меньше тем реже
;                 JR NC, .NextCell

;                 CP #10                                                          ; чем меньше тем реже
;                 JR NC, .L1
;                 DEC (HL)
;                 LD A, %00010000
;                 JR .SetUpdate

; .L1             CP #10                                                          ; чем меньше тем реже
;                 JR NC, .NextCell
;                 DEC (HL)
;                 LD A, %00110000
;                 JR .SetUpdate

                display " - Anim Tile : \t\t", /A, AnimTile, " = busy [ ", /D, $ - AnimTile, " bytes  ]"

                endif ; ~_MODULE_TILEMAP_ANIMATION_UPDATE_RENDER_BUFFER_
