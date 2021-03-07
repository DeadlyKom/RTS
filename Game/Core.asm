
                ifndef _GAME_CORE_
                define _GAME_CORE_

Draw_16x8:      macro
                EXX
                LD B, 16
.LoopRow        EXX
                
                LD (.ContainerDE_), DE
                
                LD A, 4
.LoopLine       LD (.ContainerDE), DE
                EX AF, AF'

                rept 16
                LD A, (DE)
                DEC DE
                LD L, A
                LD C, (HL)
                INC L
                LD B, (HL)
                PUSH BC
                endr

                INC H

.ContainerDE    EQU $+1
                LD DE, #0000

                rept 16
                LD A, (DE)
                DEC DE
                LD L, A
                LD C, (HL)
                INC L
                LD B, (HL)
                PUSH BC
                endr

                INC H

                EX AF, AF'
                DEC A
                JP NZ, .LoopLine

.ContainerDE_   EQU $+1
                LD DE, #0000

                EXX
                DEC B
                JP NZ, .LoopRow
                EXX
                PUSH HL
                LD HL, #FFC0
                ADD HL, DE
                EX DE, HL
                POP HL

                endm


Draw:           
                LD A, 4
                OUT (#FE), A
                DI
                LD (.ContainerSP), SP

                LD SP, #5B00 - #300
                LD H, HIGH Sprites
                LD DE, TileMapEnd-1

                rept 3
                Draw_16x8
                endr


.ContainerSP    EQU $+1
                LD SP, #0000
                EI
                RET

TileMap:        DB #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00
                DB #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00
                DB #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00
                DB #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #03
                DB #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00
                DB #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00
                DB #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00
                DB #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #02
                DB #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00
                DB #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00
                DB #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00
                DB #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #00, #01
TileMapEnd:

Sprites:        DW #0000, #0000, #0000, #0000


                endif ; ~_GAME_CORE_
