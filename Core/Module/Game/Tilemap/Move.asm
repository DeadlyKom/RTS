
                ifndef _MODULE_GAME_TILEMAP_MOVE_
                define _MODULE_GAME_TILEMAP_MOVE_

                module Move
; -----------------------------------------
; скроллл тайловой карты вверх
; In:
; Out:
; Corrupt:
;   HL, DE, AF
; Note:
; -----------------------------------------
Up:             LD HL, Tilemap.Offset.Y
                XOR A
                OR (HL)
                RET Z
                DEC (HL)
                LD HL, (Tilemap.CachedAddress)
.Decrement      EQU $+1
                LD DE, #FF00
                ADD HL, DE
                LD (Tilemap.CachedAddress), HL
                ; установка флага
                SET_SCROLL_FLAG CURSOR.UP_EDGE_BIT
                RET
; -----------------------------------------
; скроллл тайловой карты вниз
; In:
; Out:
; Corrupt:
;   HL, DE, AF
; Note:
; -----------------------------------------
Down:           LD HL, Tilemap.Offset.Y
.Clamp          EQU $+1
                LD A, #00
                ADD A, (HL)
                RET C
                INC (HL)
                LD HL, (Tilemap.CachedAddress)
.Increment      EQU $+1
                LD DE, #0000
                ADD HL, DE
                LD (Tilemap.CachedAddress), HL
                ; установка флага
                SET_SCROLL_FLAG CURSOR.DOWN_EDGE_BIT
                RET
; -----------------------------------------
; скроллл тайловой карты влево
; In:
; Out:
; Corrupt:
;   HL, AF
; Note:
; -----------------------------------------
Left:           LD HL, Tilemap.Offset.X
                XOR A
                OR (HL)
                RET Z
                DEC (HL)
                LD HL, (Tilemap.CachedAddress)
                DEC HL
                LD (Tilemap.CachedAddress), HL
                ; установка флага
                SET_SCROLL_FLAG CURSOR.LEFT_EDGE_BIT
                RET
; -----------------------------------------
; скроллл тайловой карты вправо
; In:
; Out:
; Corrupt:
;   HL, AF
; Note:
; -----------------------------------------
Right:          LD HL, Tilemap.Offset.X
.Clamp          EQU $+1
                LD A, #00
                ADD A, (HL)
                RET C
                INC (HL)
                LD HL, (Tilemap.CachedAddress)
                INC HL
                LD (Tilemap.CachedAddress), HL
                ; установка флага
                SET_SCROLL_FLAG CURSOR.RIGHT_EDGE_BIT
                RET

                endmodule

                endif ; ~_MODULE_GAME_TILEMAP_MOVE_
