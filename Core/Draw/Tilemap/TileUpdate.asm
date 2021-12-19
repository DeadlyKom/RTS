
                ifndef _TILEMAP_TILE_UPDATE_
                define _TILEMAP_TILE_UPDATE_

; -----------------------------------------
; обновление области на экране
; In:
;   H  - RightColumn
;   L  - LeftColumn
;   D  - TopRow
;   E  - BottomRow
; Out:
; Corrupt:
;   HL, DE, BC, AF, AF'
; -----------------------------------------
TileUpdate:     ; ограничение значения меньше 0
                DEC L
                JR NC, $+3
                INC L

                INC H
                JR NZ, $+3
                DEC H
                
                ; ограничение значения меньше 0
                DEC D
                JR NC, $+3
                INC D
                
                LD (.LeftColumn), HL
                ;
                LD A, D
                AND %11110000
                LD C, A
                LD A, E
                AND %11110000
                SUB C
                RRA
                RRA
                RRA
                RRA
                INC A
                LD B, A

                ;
                XOR A
                LD HL, .LeftColumn
                RLD
                LD E, A
                
                INC HL
                RLD
                SUB E
                INC A
                LD D, A

                ;
                LD H, HIGH RenderBuffer
                LD A, C
                ADD A, E
                LD E, A

.LoopRow        ; LD A, RENDER_ALL_FLAGS
                LD C, D
                LD L, E
.LoopColumn     LD (HL), RENDER_ALL_FLAGS
                ; SCF
                ; RR (HL)
                ; SCF
                ; RR (HL)
                INC L
                DEC C
                JR NZ, .LoopColumn
                LD A, E
                ADD A, TilesOnScreenX
                LD E, A
                DJNZ .LoopRow
                
                RET

.LeftColumn     DB #00
.RightColumn    DB #00

                endif ; ~_TILEMAP_TILE_UPDATE_
