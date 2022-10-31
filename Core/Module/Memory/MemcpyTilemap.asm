
                    ifndef _MEMORY_COPY_TILEMAP_
                    define _MEMORY_COPY_TILEMAP_

                    module Memcpy
EDGE_BYTE_VALUE     EQU #00
EDGE_WORD_VALUE     EQU #0000

; -----------------------------------------
; копирование видимой части тайловой карты в буфер
; In:
;   HL  - начальный адрес видимого части тайловой карты
; Corrupt:
;   HL, DE, BC, AF, HL', DE', BC', AF'
; Note:
;   прерывание должно быть отключено
; -----------------------------------------
Buffer:             ;
                    LD (.ContainerSP), SP
                    LD A, (Map.Width)
                    LD E, A
                    LD D, #00
                    
                    ; copy 192 byte (16 * 12)
.Offset             defl 0
                    dup 12
                    LD SP, HL
                    POP IX
                    POP IY
                    POP BC
                    POP AF
                    EX AF, AF'
                    POP AF
                    EXX
                    POP HL
                    POP DE
                    POP BC
                    ; сохранение 16 байт
                    LD SP, TilemapBuffer + 16 + .Offset
                    PUSH BC
                    PUSH DE
                    PUSH HL
                    EXX
                    PUSH AF
                    EX AF, AF'
                    PUSH AF
                    PUSH BC
                    PUSH IY
                    PUSH IX
                    ADD HL, DE
.Offset             = .Offset + 16
                    edup

.Top                ; top
                    LD A, (Tilemap.Offset.Y)
                    OR A
                    JP Z, .TopEdge

                    LD HL, (Tilemap.CachedAddress)
                    SBC HL, DE

                    LD SP, HL
                    POP HL
                    POP IX
                    POP BC
                    POP AF
                    EX AF, AF'
                    POP AF
                    EXX
                    POP HL
                    POP DE
                    POP BC

                    ; сохранение 16 байт
                    LD SP, TilemapBuffer + Game.FOW.ROW_UP + 16
                    PUSH BC
                    PUSH DE
                    PUSH HL
                    EXX
                    PUSH AF
                    EX AF, AF'
                    PUSH AF
                    PUSH BC
                    PUSH IX
                    PUSH HL
                    
.Bottom             ; bottom
                    LD HL, Tilemap.Offset.Y
.BottomClamp        EQU $+1
                    LD A, #00
                    ADD A, (HL)
                    JP C, .BottomEdge

                    LD HL, (Tilemap.CachedAddress)
.BottomOffset       EQU $+1
                    LD BC, #0000
                    ADD HL, BC

                    LD SP, HL
                    POP HL
                    POP IX
                    POP BC
                    POP AF
                    EX AF, AF'
                    POP AF
                    EXX
                    POP HL
                    POP DE
                    POP BC

                    ; сохранение 16 байт
                    LD SP, TilemapBuffer + Game.FOW.ROW_DOWN + 16
                    PUSH BC
                    PUSH DE
                    PUSH HL
                    EXX
                    PUSH AF
                    EX AF, AF'
                    PUSH AF
                    PUSH BC
                    PUSH IX
                    PUSH HL

.Left               ; left
                    LD A, (Tilemap.Offset.Y)
                    OR A
                    JP Z, .LeftEdge

                    LD HL, (Tilemap.CachedAddress)
                    DEC HL
                    LD A, (HL)
                    LD (TilemapBuffer + Game.FOW.ROW_0 + 0), A
                    ADD HL, DE
                    LD A, (HL)
                    LD (TilemapBuffer + Game.FOW.ROW_1 + 0), A
                    ADD HL, DE
                    LD A, (HL)
                    LD (TilemapBuffer + Game.FOW.ROW_2 + 0), A
                    ADD HL, DE
                    LD A, (HL)
                    LD (TilemapBuffer + Game.FOW.ROW_3 + 0), A
                    ADD HL, DE
                    LD A, (HL)
                    LD (TilemapBuffer + Game.FOW.ROW_4 + 0), A
                    ADD HL, DE
                    LD A, (HL)
                    LD (TilemapBuffer + Game.FOW.ROW_5 + 0), A
                    ADD HL, DE
                    LD A, (HL)
                    LD (TilemapBuffer + Game.FOW.ROW_6 + 0), A
                    ADD HL, DE
                    LD A, (HL)
                    LD (TilemapBuffer + Game.FOW.ROW_7 + 0), A
                    ADD HL, DE
                    LD A, (HL)
                    LD (TilemapBuffer + Game.FOW.ROW_8 + 0), A
                    ADD HL, DE
                    LD A, (HL)
                    LD (TilemapBuffer + Game.FOW.ROW_9 + 0), A
                    ADD HL, DE
                    LD A, (HL)
                    LD (TilemapBuffer + Game.FOW.ROW_A + 0), A
                    ADD HL, DE
                    LD A, (HL)
                    LD (TilemapBuffer + Game.FOW.ROW_B + 0), A

.Right              ; right
                    LD HL, Tilemap.Offset.Y
.RightClamp         EQU $+1
                    LD A, #00
                    ADD A, (HL)
                    JP C, .RightEdge

                    LD HL, (Tilemap.CachedAddress)
                    LD BC, SCREEN_TILE_X
                    ADD HL, BC
                    LD A, (HL)
                    LD (TilemapBuffer + Game.FOW.ROW_0 + 1), A
                    ADD HL, DE
                    LD A, (HL)
                    LD (TilemapBuffer + Game.FOW.ROW_1 + 1), A
                    ADD HL, DE
                    LD A, (HL)
                    LD (TilemapBuffer + Game.FOW.ROW_2 + 1), A
                    ADD HL, DE
                    LD A, (HL)
                    LD (TilemapBuffer + Game.FOW.ROW_3 + 1), A
                    ADD HL, DE
                    LD A, (HL)
                    LD (TilemapBuffer + Game.FOW.ROW_4 + 1), A
                    ADD HL, DE
                    LD A, (HL)
                    LD (TilemapBuffer + Game.FOW.ROW_5 + 1), A
                    ADD HL, DE
                    LD A, (HL)
                    LD (TilemapBuffer + Game.FOW.ROW_6 + 1), A
                    ADD HL, DE
                    LD A, (HL)
                    LD (TilemapBuffer + Game.FOW.ROW_7 + 1), A
                    ADD HL, DE
                    LD A, (HL)
                    LD (TilemapBuffer + Game.FOW.ROW_8 + 1), A
                    ADD HL, DE
                    LD A, (HL)
                    LD (TilemapBuffer + Game.FOW.ROW_9 + 1), A
                    ADD HL, DE
                    LD A, (HL)
                    LD (TilemapBuffer + Game.FOW.ROW_A + 1), A
                    ADD HL, DE
                    LD A, (HL)
                    LD (TilemapBuffer + Game.FOW.ROW_B + 1), A

.Exit
.ContainerSP        EQU $+1
                    LD SP, #0000
                    RET

.TopEdge            LD SP, TilemapBuffer + Game.FOW.ROW_UP + 16
                    LD HL, EDGE_WORD_VALUE
                    dup	8
                    PUSH HL
                    edup
                    JP .Bottom

.BottomEdge         LD SP, TilemapBuffer + Game.FOW.ROW_DOWN + 16
                    LD HL, EDGE_WORD_VALUE
                    dup	8
                    PUSH HL
                    edup
                    JP .Left

.LeftEdge           LD A, EDGE_BYTE_VALUE
                    LD (TilemapBuffer + Game.FOW.ROW_0 + 0), A
                    LD (TilemapBuffer + Game.FOW.ROW_1 + 0), A
                    LD (TilemapBuffer + Game.FOW.ROW_2 + 0), A
                    LD (TilemapBuffer + Game.FOW.ROW_3 + 0), A
                    LD (TilemapBuffer + Game.FOW.ROW_4 + 0), A
                    LD (TilemapBuffer + Game.FOW.ROW_5 + 0), A
                    LD (TilemapBuffer + Game.FOW.ROW_6 + 0), A
                    LD (TilemapBuffer + Game.FOW.ROW_7 + 0), A
                    LD (TilemapBuffer + Game.FOW.ROW_8 + 0), A
                    LD (TilemapBuffer + Game.FOW.ROW_9 + 0), A
                    LD (TilemapBuffer + Game.FOW.ROW_A + 0), A
                    LD (TilemapBuffer + Game.FOW.ROW_B + 0), A
                    JP .Right

.RightEdge          LD A, EDGE_BYTE_VALUE
                    LD (TilemapBuffer + Game.FOW.ROW_0 + 1), A
                    LD (TilemapBuffer + Game.FOW.ROW_1 + 1), A
                    LD (TilemapBuffer + Game.FOW.ROW_2 + 1), A
                    LD (TilemapBuffer + Game.FOW.ROW_3 + 1), A
                    LD (TilemapBuffer + Game.FOW.ROW_4 + 1), A
                    LD (TilemapBuffer + Game.FOW.ROW_5 + 1), A
                    LD (TilemapBuffer + Game.FOW.ROW_6 + 1), A
                    LD (TilemapBuffer + Game.FOW.ROW_7 + 1), A
                    LD (TilemapBuffer + Game.FOW.ROW_8 + 1), A
                    LD (TilemapBuffer + Game.FOW.ROW_9 + 1), A
                    LD (TilemapBuffer + Game.FOW.ROW_A + 1), A
                    LD (TilemapBuffer + Game.FOW.ROW_B + 1), A
                    JP .Exit

                    display " - Memory Copy Tilemap : \t\t\t\t", /A, Buffer, " = busy [ ", /D, $ - Buffer, " bytes  ]"

                    endmodule

                    endif ; ~_MEMORY_COPY_TILEMAP_
