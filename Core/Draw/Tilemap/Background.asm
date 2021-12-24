
                ifndef _CORE_DISPLAY_TILEMAP_BACKGROUND_
                define _CORE_DISPLAY_TILEMAP_BACKGROUND_

                ; defarray TileAddressTable4000 #4000, #4040, #4080, #40C0, #4800, #4840, #4880, #48C0, #5000, #5040, #5080, #50C0
                ; defarray TileAddressTableC000 #C000, #C040, #C080, #C0C0, #C800, #C840, #C880, #C8C0, #D000, #D040, #D080, #D0C0
Prepare:        ; show debug border
                ifdef SHOW_DEBUG_BORDER_SCROLL_PREPARE
                BEGIN_DEBUG_BORDER_COL SCROLL_COLOR
                endif
                ; JR $
                ; toggle to memory page with tilemap
                CALL Memory.SetPage1

                ; copy the visible block of the tilemap
                LD HL, (TilemapRef)
                CALL MEMCPY.Tilemap

                ; SetFrameFlag RENDER_FINISHED

                ; set update all visible screen
                LD HL, RenderBuffer + 0xC0
                LD DE, WORD_RENDER_ALL_FLAGS
                CALL MEMSET.SafeFill_192

                ;
                LD A, #03
                LD (FrameUnitsFlagRef), A
                
                BEGIN_DEBUG_BORDER_DEF

                RET

; можно заменить!
SafePrepare:    DI
                CALL Prepare
                EI
                RET

                ; LD HL, (TilemapRef)
                ; ; toggle to memory page with tile sprites
                ; SeMemoryPage MemoryPage_Tilemap
                ; ; copy the visible block of the tilemap
                ; LD DE, SharedBuffer
                ; rept 11
                ; rept 16
                ; LDI
                ; endr
                ; LD BC, #0030
                ; ADD HL, BC
                ; endr
                ; rept 16
                ; LDI
                ; endr
                ; RET

ForceScreen:    ;LD HL, RenderBuffer
                ; SCF
                ; RR (HL)
                ; set update all visible screen
                LD HL, RenderBuffer + 0xC0
                LD DE, WORD_RENDER_ALL_FLAGS
                CALL MEMSET.SafeFill_192
                
                ;
                LD A, #03
                LD (FrameUnitsFlagRef), A

                RET

; -----------------------------------------
; display row tiles
; In:
;   SP  - "intermediate"
;   HL  - return address
;   DE  - render tile / tile buffer
;   BC  - -
;   HL' - "intermediate"
;   DE' - "intermediate"
;   BC' - screen address
; Out:
; Corrupt:
;   SP, HL, DE, BC, HL', DE', BC'
; -----------------------------------------
DisplayTileRow: ;
                EX DE, HL
                SLA (HL)
                JP NC, .NextTile_

                INC H
                LD A, (HL)                              ; read tile index
                EXX

                ifdef DEBUG
                EX AF, AF'
                CheckDebugFlag DISPLAY_COLLISION_FLAG
                JR Z, .DrawTile

                ; calculation sprite address
                LD A, (HighSurfacePropertyRef)
                LD H, A
                EX AF, AF'
                AND %01111111
                LD L, A
                PUSH BC
                ; toggle to memory page with tile sprites
                CALL Memory.SetPage1

                LD A, (HL)
                AND %01111111
                ADD A, A
                LD H,  HIGH MemoryPage_7.DebugSpritesTable
                LD L, A

                ; toggle to memory page with tile sprites
                CALL Memory.SetPage7                       ; SeMemoryPage MemoryPage_ShadowScreen, DEBUG_SURFACE_SPR_ID
                POP BC
                LD E, (HL)
                INC L
                LD D, (HL)
                EX DE, HL                               ; HL - address current sprite

                JR .Draw
.DrawTile       EX AF, AF'
                ; calculation sprite address
                ADD A, A                                ; shift left (7 bit - fog of war)
                ifdef ENABLE_FOW
                JP C, .NextTile                         ; move to next column (if 7 bit is set)
                endif
                LD H, HIGH MemoryPage_7.SpritesTable
                LD L, A
                LD E, (HL)
                INC L
                LD D, (HL)
                EX DE, HL                               ; HL - address current sprite

                else

                ; calculation sprite address
                ADD A, A                                ; shift left (7 bit - fog of war)
                ifdef ENABLE_FOW
                JP C, .NextTile                         ; move to next column (if 7 bit is set)
                endif
                LD H, HIGH MemoryPage_7.SpritesTable
                LD L, A
                LD E, (HL)
                INC L
                LD D, (HL)
                EX DE, HL                               ; HL - address current sprite

                endif
.Draw
                ; protection data corruption during interruption
                LD E, (HL)
                INC L                                   ; ---------- (my be INC HL) ----------
                LD D, (HL)
                INC L                                   ; ---------- (my be INC HL) ----------
                LD SP, HL

                ; HL - stores the screen address of the output
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
                SET 5, L

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

                ;
.ContainerSP    EQU $+1
                LD SP, #0000

.NextTile       ; move to next column
                INC C
                INC C

                ; move to the next cell in a tile
                EXX
                DEC H                                               ; aligned to 256 bytes
                INC L                                               ; next cell of the render buffer
                EX DE, HL
                
                INC HL
                INC HL
                JP (HL)

.NextTile_      ; move to next column
                EXX
                INC C
                INC C

                ; move to the next cell in a tile
                EXX
                INC L                                               ; next cell of the render buffer
                EX DE, HL
                
                INC HL
                INC HL
                JP (HL)
; -----------------------------------------
; display fog of war
; Corrupt:
;   HL, DE, BC, AF, HL', DE', BC', AF', IX
; Note:
;   requires included memory page 7 (MemoryPage_TilSprites)
; -----------------------------------------
Display:        ; initialize execute blocks
                LD IX, DisplayTileRow
                LD DE, RenderBuffer
                LD (.ContainerSP), SP
                LD (DisplayTileRow.ContainerSP), SP
                RestoreDE
;                 GetCurrentScreen
;                 JP Z, .Display_C000

;                 ; draw on the screen at #4000
; .Row            defl 0
;                 dup TileAddressTable4000[#]
;                 EXX
;                 LD BC, TileAddressTable4000[.Row]
;                 EXX
;                 LD HL, $+3

;                 rept 16                                                 ; number of columns per row
;                 JP (IX)
;                 endr
; .Row            = .Row + 1
;                 edup

; .Exit           ; exit
; .ContainerSP    EQU $+1
;                 LD SP, #0000

;                 RET

; .Display_C000   ; draw on the screen at #C000
; .Row            = 0
;                 dup TileAddressTableC000[#]
;                 EXX
;                 LD BC, TileAddressTableC000[.Row]
;                 EXX
;                 LD HL, $+3

;                 rept 16                                                 ; number of columns per row
;                 JP (IX)
;                 endr
; .Row            = .Row + 1
;                 edup

;                 JP .Exit

                GetCurrentScreen
                LD A, #C0
                JR Z, $+4
                LD A, #40
                LD (.Row0), A
                LD (.Row1), A
                LD (.Row2), A
                LD (.Row3), A
                ADD A, #08
                LD (.Row4), A
                LD (.Row5), A
                LD (.Row6), A
                LD (.Row7), A
                ADD A, #08
                LD (.Row8), A
                LD (.Row9), A
                LD (.RowA), A
                LD (.RowB), A

.DrawRows       ; draw on the screen

                ; ---------------------------------------------
                ; Row 0
                ; ---------------------------------------------
                EXX
.Row0           EQU $+2
                LD BC, #4000
                EXX
                LD HL, $+3

                rept 16                                                         ; number of columns per row
                JP (IX)
                endr

                ; ---------------------------------------------
                ; Row 1
                ; ---------------------------------------------
                EXX
.Row1           EQU $+2
                LD BC, #4040
                EXX
                LD HL, $+3

                rept 16                                                         ; number of columns per row
                JP (IX)
                endr

                ; ---------------------------------------------
                ; Row 2
                ; ---------------------------------------------
                EXX
.Row2           EQU $+2
                LD BC, #4080
                EXX
                LD HL, $+3

                rept 16                                                         ; number of columns per row
                JP (IX)
                endr

                ; ---------------------------------------------
                ; Row 3
                ; ---------------------------------------------
                EXX
.Row3           EQU $+2
                LD BC, #40C0
                EXX
                LD HL, $+3

                rept 16                                                         ; number of columns per row
                JP (IX)
                endr

                ; ---------------------------------------------
                ; Row 4
                ; ---------------------------------------------
                EXX
.Row4           EQU $+2
                LD BC, #4800
                EXX
                LD HL, $+3

                rept 16                                                         ; number of columns per row
                JP (IX)
                endr

                ; ---------------------------------------------
                ; Row 5
                ; ---------------------------------------------
                EXX
.Row5           EQU $+2
                LD BC, #4840
                EXX
                LD HL, $+3

                rept 16                                                         ; number of columns per row
                JP (IX)
                endr

                ; ---------------------------------------------
                ; Row 6
                ; ---------------------------------------------
                EXX
.Row6           EQU $+2
                LD BC, #4880
                EXX
                LD HL, $+3

                rept 16                                                         ; number of columns per row
                JP (IX)
                endr

                ; ---------------------------------------------
                ; Row 7
                ; ---------------------------------------------
                EXX
.Row7           EQU $+2
                LD BC, #48C0
                EXX
                LD HL, $+3

                rept 16                                                         ; number of columns per row
                JP (IX)
                endr

                ; ---------------------------------------------
                ; Row 8
                ; ---------------------------------------------
                EXX
.Row8           EQU $+2
                LD BC, #5000
                EXX
                LD HL, $+3

                rept 16                                                         ; number of columns per row
                JP (IX)
                endr

                ; ---------------------------------------------
                ; Row 9
                ; ---------------------------------------------
                EXX
.Row9           EQU $+2
                LD BC, #5040
                EXX
                LD HL, $+3

                rept 16                                                         ; number of columns per row
                JP (IX)
                endr

                ; ---------------------------------------------
                ; Row 10
                ; ---------------------------------------------
                EXX
.RowA           EQU $+2
                LD BC, #5080
                EXX
                LD HL, $+3

                rept 16                                                         ; number of columns per row
                JP (IX)
                endr

                ; ---------------------------------------------
                ; Row 11
                ; ---------------------------------------------
                EXX
.RowB           EQU $+2
                LD BC, #50C0
                EXX
                LD HL, $+3

                rept 16                                                         ; number of columns per row
                JP (IX)
                endr

                ; exit
.ContainerSP    EQU $+1
                LD SP, #0000

                RET

                endif ; ~_CORE_DISPLAY_TILEMAP_BACKGROUND_
