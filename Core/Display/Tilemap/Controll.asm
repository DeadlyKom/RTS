
                ifndef _CORE_DISPLAY_TILEMAP_CONTROLL_
                define _CORE_DISPLAY_TILEMAP_CONTROLL_
Initialize:     LD HL, TilemapSizeRef
                ;
                LD A, (HL)
                LD (MoveDown.Increment), A
                NEG                                         ; X = -X
                LD (MoveUp.Decrement), A
                ADD A, #10                                  ; -X += 16
                LD (MoveRight.Clamp), A
                ;
                INC HL                                      ; move to Y
                ; -(Y - 12)
                LD A, (HL)
                ADD A, #F4
                NEG
                LD (MoveDown.Clamp), A
                RET
MoveUp:         ;
                LD HL, TilemapOffsetHeight
                XOR A
                OR (HL)
                JR Z, .Exit
                DEC (HL)
                LD HL, (TilemapRef)
.Decrement      EQU $+1
                LD DE, #FF00
                ADD HL, DE
                LD (TilemapRef), HL
.Exit           JP (IX)
MoveDown:       ;
                LD HL, TilemapOffsetHeight
.Clamp          EQU $+1
                LD A, #00
                ADD A, (HL)
                JR C, .Exit
                INC (HL)
                LD HL, (TilemapRef)
.Increment      EQU $+1
                LD DE, #0000
                ADD HL, DE
                LD (TilemapRef), HL
.Exit           JP (IX)
MoveLeft:       ;
                LD HL, TilemapOffsetWidth
                XOR A
                OR (HL)
                JR Z, .Exit
                DEC (HL)
                LD HL, (TilemapRef)
                DEC HL
                LD (TilemapRef), HL
.Exit           JP (IX)
MoveRight:      ;
                LD HL, TilemapOffsetWidth
.Clamp          EQU $+1
                LD A, #00
                ADD A, (HL)
                JR C, .Exit
                INC (HL)
                LD HL, (TilemapRef)
                INC HL
                LD (TilemapRef), HL
.Exit           JP (IX)

                endif ; ~_CORE_DISPLAY_TILEMAP_CONTROLL_
