
                ifndef _CORE_DRAW_TILE_MAP_
                define _CORE_DRAW_TILE_MAP_

; DrawTileMap:    DI
;                 LD (.ContainerSP), SP

;                 LD SP, #5B00 - #300
;                 LD H, HIGH SpritesA
;                 LD DE, ScreenMask
;                 LD BC, TileMapEnd-1

;                 EXX
;                 LD A, (BC)          ; 
;                 INC BC
;                 EXX
;                 LD L, A
;                 LD SP, HL
;                 EX DE, HL
;                 LD E, (HL)
;                 INC L
;                 LD D, (HL)
;                 INC L
;                 EX DE, HL
;                 POP BC

; .ContainerSP    EQU $+1
;                 LD SP, #0000
;                 EI

;                 RET

; CopyScreen:     DI
;                 LD (.ContainerSP), SP
;                 LD SP, HL

; .Offset         defl 0
;                 dup 8 ; 6912 / 16 * 26
;                 ; получение 16 байт
;                 LD SP, #4000 + .Offset
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
;                 ; сохранение 16 байт
;                 LD SP, #C000 + .Offset
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
; .Offset = .Offset + 16
;                 edup

; .ContainerSP    EQU $+1
;                 LD SP, #0000
;                 EI
;                 RET

; ScreenMask:     DB #C0, #C0, #C0, #C0, #C0, #C0, #C0, #C0, #C0, #C0, #C0, #C0, #C0, #C0, #C0, #C0

                endif ; ~_CORE_DRAW_TILE_MAP_
