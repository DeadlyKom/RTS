
                ifndef _MODULE_GAME_TILEMAP_MOVE_
                define _MODULE_GAME_TILEMAP_MOVE_

                module Move
; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
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
                RET
; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
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
                RET
; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
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
                RET
; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
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
                RET

                endmodule

                endif ; ~_MODULE_GAME_TILEMAP_MOVE_
