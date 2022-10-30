
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
Up:             LD HL, GameVar.TilemapOffset.Y
                XOR A
                OR (HL)
                RET Z
                DEC (HL)
                LD HL, (GameVar.TilemapCachedAdr)
.Decrement      EQU $+1
                LD DE, #FF00
                ADD HL, DE
                LD (GameVar.TilemapCachedAdr), HL
                RET
; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Down:           LD HL, GameVar.TilemapOffset.Y
.Clamp          EQU $+1
                LD A, #00
                ADD A, (HL)
                RET C
                INC (HL)
                LD HL, (GameVar.TilemapCachedAdr)
.Increment      EQU $+1
                LD DE, #0000
                ADD HL, DE
                LD (GameVar.TilemapCachedAdr), HL
                RET
; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Left:           LD HL, GameVar.TilemapOffset.X
                XOR A
                OR (HL)
                RET Z
                DEC (HL)
                LD HL, (GameVar.TilemapCachedAdr)
                DEC HL
                LD (GameVar.TilemapCachedAdr), HL
                RET
; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Right:          LD HL, GameVar.TilemapOffset.X
.Clamp          EQU $+1
                LD A, #00
                ADD A, (HL)
                RET C
                INC (HL)
                LD HL, (GameVar.TilemapCachedAdr)
                INC HL
                LD (GameVar.TilemapCachedAdr), HL
                RET

                endmodule

                endif ; ~_MODULE_GAME_TILEMAP_MOVE_
