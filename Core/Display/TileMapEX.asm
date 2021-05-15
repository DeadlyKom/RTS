  
                ifndef _CORE_DISPLAY_TILE_MAP_EX_
                define _CORE_DISPLAY_TILE_MAP_EX_

                defarray TileAddressTableEx #4000, #4040, #4080, #40C0, #4800, #4840, #4880, #48C0, #5000, #5040, #5080, #50C0

; -----------------------------------------
; display row tiles
; In:
;   SP  - !
;   HL  - return addres
;   DE  - !
;   BC  - tile buffer
;   HL' - !
;   DE' - !
;   BC' - screen address
; Out:
; Corrupt:
;   SP, HL, DE, BC, HL', DE', BC'
; -----------------------------------------
DisplayTileRowEx: ;
                LD A, (BC)                              ; read tile index
                EXX

                ; calculation sprite address
                ADD A, A                                ; shift left (7 bit - fog of war)
                JP C, .NextTile                         ; move to next column (if 7 bit is set)
                LD H, HIGH MemoryPage_0.TableSprites
                LD L, A
                LD E, (HL)
                INC L
                LD D, (HL)
                EX DE, HL                               ; HL - address current sprite

                ; protection data corruption during interruption
                LD E, (HL)
                INC L
                LD D, (HL)
                INC L
                LD SP, HL
                LD H, B
                LD L, C

                ; draw the sprite top part
                LD (HL), E
                INC L
                LD (HL), D
                INC H
                POP DE
                LD (HL), D
                DEC L
                LD (HL), E
                INC H
                rept 2
                POP DE
                LD (HL), E
                INC L
                LD (HL), D
                INC H
                POP DE
                LD (HL), D
                DEC L
                LD (HL), E
                INC H
                endr

                POP DE
                LD (HL), E
                INC L
                LD (HL), D
                INC H
                POP DE
                LD (HL), D
                DEC L
                LD (HL), E

                ; calculation to the sprite bottom part
                LD A, #20
                ADD A, L
                LD L, A

                ; draw the sprite bottom part
                rept 3
                POP DE
                LD (HL), E
                INC L
                LD (HL), D
                DEC H
                POP DE
                LD (HL), D
                DEC L
                LD (HL), E
                DEC H
                endr
                POP DE
                LD (HL), E
                INC L
                LD (HL), D
                DEC H
                POP DE
                LD (HL), D
                DEC L
                LD (HL), E

                LD SP, (DisplayTileMapEx.ContainerSP)

                ; move to next column
.NextTile       INC C
                INC C

                ; move to the next cell in a tile
                EXX
                INC BC
                INC HL
                INC HL
                JP (HL)
DisplayTileMapEx:; toggle to memory page with tile sprites
                SeMemoryPage MemoryPage_TilemapSprite

                ; initialize execute blocks
                LD IX, DisplayTileRowEx
                LD BC, MemoryPage_5.TileMapBuffer
                LD (.ContainerSP), SP
                ;
.Row            defl 0
                dup TileAddressTableEx[#]
                EXX
                LD BC, TileAddressTableEx[.Row]
                EXX
                LD HL, $+3
                rept 16                                                 ; number of columns per row
                JP (IX)
                endr
.Row = .Row + 1
                edup

                ; exit
.ContainerSP    EQU $+1
                LD SP, #0000
                RET

                endif ; ~_CORE_DISPLAY_TILE_MAP_EX_
