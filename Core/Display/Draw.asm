
                ifndef _GAME_CORE_
                define _GAME_CORE_

Draw_16x8:      macro
                EXX
                LD B, 8
.LoopRow        EXX
                
                LD (.ContainerDE_), DE
                
                LD A, 4
.LoopLine       LD (.ContainerDE), DE
                EX AF, AF'

                rept 16
                LD A, (DE)
                DEC DE
                LD L, A
                LD B, (HL)
                INC L
                LD C, (HL)
                PUSH BC
                endr

                INC H

.ContainerDE    EQU $+1
                LD DE, #0000

                rept 16
                LD A, (DE)
                DEC DE
                LD L, A
                LD B, (HL)
                INC L
                LD C, (HL)
                PUSH BC
                endr

                DEC H

                EX AF, AF'
                DEC A
                JP NZ, .LoopLine

.ContainerDE_   EQU $+1
                LD DE, #0000

                INC H
                INC H

                EXX
                DEC B
                JP NZ, .LoopRow
                EXX

                LD HL, #FFC0
                ADD HL, DE
                EX DE, HL

                LD H, HIGH SpritesA

                endm

Draw:           
                LD A, 4
                OUT (#FE), A
                DI
                LD (.ContainerSP), SP

                LD SP, #5B00 - #300
                LD H, HIGH SpritesA
                LD DE, TileMapEnd-1

                rept 3
                Draw_16x8
                endr

.ContainerSP    EQU $+1
                LD SP, #0000
                EI
                RET

TileMap:        DB #02, #00, #00, #00, #00, #00, #00, #02, #00, #00, #00, #00, #00, #00, #00, #00
                DB #00, #02, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00
                DB #00, #00, #02, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00
                DB #00, #00, #00, #02, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #02
                DB #00, #00, #00, #00, #02, #00, #00, #02, #00, #00, #00, #00, #00, #00, #00, #00
                DB #00, #02, #00, #00, #00, #02, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00
                DB #00, #00, #00, #00, #00, #00, #02, #00, #00, #00, #00, #00, #00, #00, #00, #00
                DB #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #02
                DB #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00
                DB #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00
                DB #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #02, #00, #00
                DB #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #02
TileMapEnd:


                align 256
SpritesA:       DW #0FF0, #0FF0 : DS 252, 0
                DW #4102, #4082 : DS 252, 0

                DW #7FFE, #7FFE : DS 252, 0
                DW #4502, #4042 : DS 252, 0

                DW #4002, #4002 : DS 252, 0
                DW #4302, #4442 : DS 252, 0

                DW #4002, #4002 : DS 252, 0
                DW #4102, #4382 : DS 252, 0

                DW #47C2, #47C2 : DS 252, 0
                DW #4002, #4002 : DS 252, 0
                
                DW #4102, #4402 : DS 252, 0
                DW #4002, #4002 : DS 252, 0

                DW #4102, #4202 : DS 252, 0
                DW #7FFE, #7FFE : DS 252, 0

                DW #4102, #4102 : DS 252, 0
                DW #0000, #0000 : DS 252, 0
                

                endif ; ~_GAME_CORE_
