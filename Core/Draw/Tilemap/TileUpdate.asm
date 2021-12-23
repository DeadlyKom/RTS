
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
TileUpdate:     ; увеличение значений AABB (влево/вправо)
                
                LD A, L
                SUB #04                                                         ; отступ влево
                JR NC, $+3
                XOR A
                LD L, A

                LD A, H
                ADD A, #04                                                      ; отступ вправо
                JR NC, $+4
                LD A, #FF
                LD H, A
                
                ; увеличение значений AABB (вверх/вниз)
                
                LD A, D
                SUB #05                                                         ; отступ вверх
                JR NC, $+3
                XOR A
                LD D, A

                ; LD A, E
                ; ADD A, #04                                                      ; отступ вниз
                ; JR NC, $+4
                ; LD A, #BF
                ; LD E, A
                
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

.LoopRow        LD C, D
                LD L, E
.LoopColumn     LD (HL), RENDER_ALL_FLAGS
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
