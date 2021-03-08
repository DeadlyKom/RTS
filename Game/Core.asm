
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

Draw_16x8_1:    macro

                EXX
                LD B, 8
.LoopRow        EXX

                LD A, 4
.LoopLine       EX AF, AF'

.Offset_TileA   defl 0
                dup 16
                LD L, (IX + .Offset_TileA)
                LD SP, HL
                POP BC
                EX DE, HL
                LD SP, HL
                PUSH BC
                DEC HL
                DEC HL
                EX DE, HL
.Offset_TileA = .Offset_TileA - 1
                edup

                INC H

.Offset_TileB   defl 0
                dup 16
                LD L, (IX + .Offset_TileB)
                LD SP, HL
                POP BC
                EX DE, HL
                LD SP, HL
                PUSH BC
                DEC HL
                DEC HL
                EX DE, HL
.Offset_TileB = .Offset_TileB - 1
                edup

                LD BC, #FFF0
                ADD IX, BC

                DEC H

                EX AF, AF'
                DEC A
                JP NZ, .LoopLine

                LD BC, #0040
                ADD IX, BC

                INC H
                INC H

                EXX
                DEC B
                JP NZ, .LoopRow
                EXX

                LD BC, #FFC0
                ADD IX, BC

                LD H, HIGH SpritesC

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

Draw_1:         LD A, 4
                OUT (#FE), A
                DI
                LD (.ContainerSP), SP

                LD IX, TileMapEnd-1
                LD H, HIGH SpritesC
                LD DE, #5B00 - #300

                rept 3
                Draw_16x8_1
                endr

.ContainerSP    EQU $+1
                LD SP, #0000
                EI
                RET


Draw_16x8_2:    macro

                EXX
                LD B, 8
.LoopRow        EXX

                LD A, 4
.LoopLine       EX AF, AF'

.Offset_TileA   defl 0
                dup 16
                LD L, (IX + .Offset_TileA)
                LDD
                LDD
.Offset_TileA = .Offset_TileA - 1
                edup

                INC H

.Offset_TileB   defl 0
                dup 16
                LD L, (IX + .Offset_TileB)
                LDD
                LDD
.Offset_TileB = .Offset_TileB - 1
                edup

                LD BC, #FFF0
                ADD IX, BC

                DEC H

                EX AF, AF'
                DEC A
                JP NZ, .LoopLine

                LD BC, #0040
                ADD IX, BC

                INC H
                INC H

                EXX
                DEC B
                JP NZ, .LoopRow
                EXX

                LD BC, #FFC0
                ADD IX, BC

                LD H, HIGH SpritesB

                endm
Draw_2:         LD A, 4
                OUT (#FE), A

                LD IX, TileMapEndA-1
                LD H, HIGH SpritesB
                LD DE, #5B00 - #300 - 1

                rept 3
                Draw_16x8_2
                endr

                RET
TileMap:        DB #00, #00, #00, #00, #00, #00, #00, #02, #00, #00, #00, #00, #00, #00, #00, #00
                DB #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00
                DB #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00
                DB #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #02
                DB #00, #00, #00, #00, #00, #00, #00, #02, #00, #00, #00, #00, #00, #00, #00, #00
                DB #00, #02, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00
                DB #00, #00, #00, #00, #00, #00, #02, #00, #00, #00, #00, #00, #00, #00, #00, #00
                DB #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #01
                DB #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00
                DB #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00
                DB #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #02, #00, #00
                DB #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #02
TileMapEnd:

TileMapA:       DB #03, #03, #03, #03, #03, #03, #03, #05, #03, #03, #03, #03, #03, #03, #03, #03
                DB #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03
                DB #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03
                DB #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03
                DB #03, #03, #03, #03, #03, #03, #03, #05, #03, #03, #03, #03, #03, #03, #03, #03
                DB #03, #05, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03
                DB #03, #03, #03, #03, #03, #03, #05, #03, #03, #03, #03, #03, #03, #03, #03, #03
                DB #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03
                DB #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03
                DB #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03
                DB #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #05, #03, #03
                DB #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #03, #05
TileMapEndA:

                align	256
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

SpritesB:       DW #0000, #0000, #0000 : DS 250, 0
                DW #0000, #0241, #8240 : DS 250, 0

                DW #0000, #FE7F, #FE7F : DS 250, 0
                DW #0000, #0245, #4240 : DS 250, 0

                DW #0000, #0240, #0240 : DS 250, 0
                DW #0000, #0243, #4244 : DS 250, 0

                DW #0000, #0240, #0240 : DS 250, 0
                DW #0000, #0241, #8243 : DS 250, 0

                DW #0000, #C247, #C247 : DS 250, 0
                DW #0000, #0240, #0240 : DS 250, 0
                
                DW #0000, #0241, #0244 : DS 250, 0
                DW #0000, #0240, #0240 : DS 250, 0

                DW #0000, #0241, #0242 : DS 250, 0
                DW #0000, #FE7F, #FE7F : DS 250, 0

                DW #0000, #0241, #0241 : DS 250, 0
                DW #0000, #0000, #0000 : DS 250, 0
               
SpritesC:       DW #F00F, #F00F : DS 252, 0
                DW #0241, #8240 : DS 252, 0

                DW #FE7F, #FE7F : DS 252, 0
                DW #0245, #4240 : DS 252, 0

                DW #0240, #0240 : DS 252, 0
                DW #0243, #4244 : DS 252, 0

                DW #0240, #0240 : DS 252, 0
                DW #0241, #8243 : DS 252, 0

                DW #C247, #C247 : DS 252, 0
                DW #0240, #0240 : DS 252, 0
                
                DW #0241, #0244 : DS 252, 0
                DW #0240, #0240 : DS 252, 0

                DW #0241, #0242 : DS 252, 0
                DW #FE7F, #FE7F : DS 252, 0

                DW #0241, #0241 : DS 252, 0
                DW #0000, #0000 : DS 252, 0

                endif ; ~_GAME_CORE_
