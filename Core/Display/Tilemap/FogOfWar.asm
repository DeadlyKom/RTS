
                ifndef _CORE_DISPLAY_TILEMAP_FOW_
                define _CORE_DISPLAY_TILEMAP_FOW_
; -----------------------------------------
; display fog of war
; Corrupt:
;   HL, DE, BC, AF, HL', DE', BC', AF'
; Note:
;   requires included memory page 7
; -----------------------------------------
FOW:            ; initialize execute blocks
                LD IX, DisplayRowFOW
                LD DE, RenderBuffer
                LD BC, BypassFOW
                LD (.ContainerSP), SP
                PUSH AF                                                 ; SP -= 2
                LD (DisplayRowFOW.ContainerSP), SP
                POP AF                                                  ; SP += 2
                RestoreDE
                GetCurrentScreen
                JP Z, .Display_C000

                ; draw on the screen at #4000
.Row            defl 0
                dup TileAddressTable4000[#]
                EXX
                LD BC, TileAddressTable4000[.Row]
                EXX
                LD HL, $+3

                rept 16                                                 ; number of columns per row
                JP (IX)
                endr
.Row            = .Row + 1
                edup

.Exit           ; exit
.ContainerSP    EQU $+1
                LD SP, #0000
                RET

.Display_C000   ; draw on the screen at #C000
.Row            = 0
                dup TileAddressTableC000[#]
                EXX
                LD BC, TileAddressTableC000[.Row]
                EXX
                LD HL, $+3

                rept 16                                                 ; number of columns per row
                JP (IX)
                endr
.Row            = .Row + 1
                edup

                JP .Exit

; -----------------------------------------
; display row tiles FOW
; In:
;   SP  - "intermediate"
;   HL  - return address
;   DE  - render refresh buffer
;   BC  - current address FOW index table
;   HL' - "intermediate"
;   DE' - "intermediate"
;   BC' - screen address
; Out:
; Corrupt:
;   SP, HL, DE, BC, HL', DE', BC'
; -----------------------------------------
DisplayRowFOW:  ;
                EX DE, HL
                SLA (HL)
                JP NC, .NextTile_
                EX DE, HL

                PUSH HL

                INC D
                LD A, (DE)
                DEC D

                ; calculate 
                LD H, B
                LD L, C
                
                ADD A, A
                JP C, .FillTile
                ; EXX
                ; JP .NextTile

                ; calculate
                LD B, HIGH TilemapBuffer                            ; hight byte TilemapBuffer

                rept 4
                LD C, (HL)
                INC HL
                LD A, (BC)
                ADD A, A
                RL D
                endr

                ; check what we got around the current position
                LD A, %00001111
                AND D
                EXX
                JP Z, .NextTile

                ; calculate address sprite FOW
                DEC A
                ADD A, A
                LD L, A
                LD H, HIGH Page_7_FOWTable

                ;
                LD E, (HL)
                INC L
                LD D, (HL)
                
                EX DE, HL                                           ; HL - address current sprite

                ; protection data corruption during interruption
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                LD SP, HL

                ; HL - stores the screen address of the output
                LD H, B
                LD L, C
                
                ; draw the sprite top part
                LD A, (HL)
                OR E
                LD (HL), A
                INC L
                LD A, (HL)
                OR D
                LD (HL), A
                INC H

                POP DE
                LD A, (HL)
                OR E
                LD (HL), A
                DEC L
                LD A, (HL)
                OR D
                LD (HL), A
                INC H

                rept 2
                POP DE
                LD A, (HL)
                OR E
                LD (HL), A
                INC L
                LD A, (HL)
                OR D
                LD (HL), A
                INC H

                POP DE
                LD A, (HL)
                OR E
                LD (HL), A
                DEC L
                LD A, (HL)
                OR D
                LD (HL), A
                INC H
                endr

                POP DE
                LD A, (HL)
                OR E
                LD (HL), A
                INC L
                LD A, (HL)
                OR D
                LD (HL), A
                INC H

                POP DE
                LD A, (HL)
                OR E
                LD (HL), A
                DEC L
                LD A, (HL)
                OR D
                LD (HL), A

                ; calculation to the sprite bottom part
                SET 5, L

                ; draw the sprite bottom part
                rept 3
                POP DE
                LD A, (HL)
                OR E
                LD (HL), A
                INC L
                LD A, (HL)
                OR D
                LD (HL), A
                DEC H

                POP DE
                LD A, (HL)
                OR E
                LD (HL), A
                DEC L
                LD A, (HL)
                OR D
                LD (HL), A
                DEC H
                endr
                POP DE
                LD A, (HL)
                OR E
                LD (HL), A
                INC L
                LD A, (HL)
                OR D
                LD (HL), A
                DEC H

                POP DE
                LD A, (HL)
                OR E
                LD (HL), A
                DEC L
                LD A, (HL)
                OR D
                LD (HL), A

.ContainerSP    EQU $+1
                LD SP, #0000
                
.NextTile       ; move to next column
                INC C
                INC C

                ; move to the next cell in a tile
                EXX
                ;
                LD B, H
                LD C, L
                ;
                LD D, HIGH RenderBuffer                             ; hight byte FOW index table
                INC E                                               ; next cell of the render buffer
                
                POP HL
                INC HL
                INC HL
                JP (HL)

.FillTile       
                INC HL
                INC HL
                INC HL
                INC HL

                EXX

                ; HL - stores the screen address of the output
                LD H, B
                LD L, C

                LD A, #FF

                ; draw the sprite top part
                rept 3
                LD (HL), A
                INC L
                LD (HL), A
                INC H
                LD (HL), A
                DEC L
                LD (HL), A
                INC H
                endr
                LD (HL), A
                INC L
                LD (HL), A
                INC H
                LD (HL), A
                DEC L
                LD (HL), A

                ; calculation to the sprite bottom part
                SET 5, L

                ; draw the sprite bottom part
                rept 3
                LD (HL), A
                INC L
                LD (HL), A
                DEC H
                LD (HL), A
                DEC L
                LD (HL), A
                DEC H
                endr
                LD (HL), A
                INC L
                LD (HL), A
                DEC H
                LD (HL), A
                DEC L
                LD (HL), A

                JP .NextTile

.NextTile_      ; skip four directions
                INC BC
                INC BC
                INC BC
                INC BC
                
                ; move to next column
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

; FillFog:        ; toggle to memory page with tilemap
;                 SeMemoryPage MemoryPage_Tilemap

;                 LD HL, #0000
;                 LD A, (TilemapWidth)
;                 LD D, L
;                 LD E, A
;                 LD A, (TilemapHeight)
;                 LD B, A
; .Multiply       ADD HL, DE
;                 DJNZ .Multiply

;                 EX DE, HL
;                 LD HL, (TilemapRef)

; .Loop           LD A, (HL)
;                 OR #80
;                 LD (HL), A
;                 INC HL
;                 DEC DE
;                 LD A, D
;                 OR E
;                 JR NZ, .Loop

;                 RET

; ResetFog:       ; toggle to memory page with tilemap
;                 SeMemoryPage MemoryPage_Tilemap

;                 LD HL, TilemapOffsetWidth
;                 LD DE, MousePositionRef
;                 LD A, (DE)
;                 RRA
;                 RRA
;                 RRA
;                 RRA
;                 AND %00011111
;                 ADD A, (HL)
;                 LD C, A

;                 INC HL
;                 INC DE

;                 ; y
;                 LD A, (DE)
;                 RRA
;                 RRA
;                 RRA
;                 RRA
;                 AND %00011111
;                 ADD A, (HL)
;                 LD B, A
;                 LD HL, #C000
;                 OR A
;                 JR Z, .Reset

;                 LD A, (TilemapWidth)
;                 LD D, L
;                 LD E, A
; .Multiply       ADD HL, DE
;                 DJNZ .Multiply
; .Reset          ADD HL, BC
;                 LD A, (HL)
;                 AND %01111111
;                 LD (HL), A

;                 CALL Tilemap.Prepare

;                 SeMemoryPage MemoryPage_ShadowScreen

;                 RET

                endif ; ~_CORE_DISPLAY_TILEMAP_FOW_
