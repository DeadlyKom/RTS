
                ifndef _CORE_DISPLAY_TILEMAP_CONTROLL_
                define _CORE_DISPLAY_TILEMAP_CONTROLL_
MoveUp:         ;
                LD HL, TilemapOffsetHeight
                XOR A
                OR (HL)
                JR Z, .Edge
                DEC (HL)
                LD HL, (TilemapRef)
.Decrement      EQU $+1
                LD DE, #FF00
                ADD HL, DE
                LD (TilemapRef), HL
                OR A
                RET
.Edge           ResetTilemapFlag CURSOR_UP_EDGE_FLAG
                RET
MoveDown:       ;
                LD HL, TilemapOffsetHeight
.BottomClamp    EQU $+1
                LD A, #00
                ADD A, (HL)
                JR C, .Edge
                INC (HL)
                LD HL, (TilemapRef)
.Increment      EQU $+1
                LD DE, #0000
                ADD HL, DE
                LD (TilemapRef), HL
                OR A
                RET
.Edge           ResetTilemapFlag CURSOR_DOWN_EDGE_FLAG
                RET
MoveLeft:       ;
                LD HL, TilemapOffsetWidth
                XOR A
                OR (HL)
                JR Z, .Edge
                DEC (HL)
                LD HL, (TilemapRef)
                DEC HL
                LD (TilemapRef), HL
                RET
.Edge           ResetTilemapFlag CURSOR_LEFT_EDGE_FLAG
                RET
MoveRight:      ;
                LD HL, TilemapOffsetWidth
.Clamp          EQU $+1
                LD A, #00
                ADD A, (HL)
                JR C, .Edge
                INC (HL)
                LD HL, (TilemapRef)
                INC HL
                LD (TilemapRef), HL
                RET
.Edge           ResetTilemapFlag CURSOR_RIGHT_EDGE_FLAG
                RET

                endif ; ~_CORE_DISPLAY_TILEMAP_CONTROLL_
