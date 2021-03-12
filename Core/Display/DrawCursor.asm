
                ifndef _CORE_DRAW_CURSOR_
                define _CORE_DRAW_CURSOR_

DrawCursor:     LD A, (CursorAddress + 1)
                OR A
                CALL NZ, RestoreBackground
                ;
                LD BC, (MousePosition)
                CALL CalcPixelAddress
                LD (CursorAddress), HL
                LD DE, CursorBuffer
                LD BC, CursorSprite
                EXX
                OR A
                JR Z, Shift_0
                DEC A
                LD (Shift_1_7.SetJumpSprite), A
                INC A
                ADD A, A
                SUB #02
                LD (Shift_1_7.SetJumpMask), A
                JR Shift_1_7

; HL' - address screen
; DE' - buffer
; BC' - sprite
Shift_0:        DI
                LD (.ContainerSP), SP
                LD B, #08

.Loop           EXX
                LD SP, HL
                EX DE, HL
                LD (HL), E
                INC HL
                LD (HL), D
                INC HL
                POP DE
                PUSH DE
                LD (HL), E
                INC HL
                LD (HL), D
                INC HL
                EX DE, HL
                LD A, (BC)
                INC BC
                EXX

                POP DE

                LD H, A
                LD L, #FF

                LD A, E
                AND H
                LD E, A
                LD A, D
                AND L
                LD D, A
                EXX
                LD A, (BC)
                INC BC
                EXX
                LD H, A
                LD L, #00

                LD A, E
                OR H
                LD E, A
                LD A, D
                OR L
                LD D, A
                PUSH DE

                EXX
                ; переход к следующей линии экрана
                LD HL, #0000
                ADD HL, SP
                INC H
                LD A, H
                AND %00000111
                JR NZ, .Next
                DEC H
                LD A, H
                AND %11111000
                LD H, A

                LD A, L
                ADD A, #20
                JR C, .NextSegment
                LD L, A
                JR .Next
.NextSegment    LD A, L
                AND %00011111
                LD L, A

                LD A, H
                ADD A, #08
                LD H, A
                AND %00011000
                CP %00011000
                JR Z, .Exit

.Next           EXX
                DJNZ .Loop
             
.ContainerSP    EQU $+1
.Exit           LD SP, #0000
                EI
                RET

Shift_1_7:      DI
                LD (.ContainerSP), SP
                LD B, #08

.Loop           EXX
                LD SP, HL
                EX DE, HL
                LD (HL), E
                INC HL
                LD (HL), D
                INC HL
                POP DE
                PUSH DE
                LD (HL), E
                INC HL
                LD (HL), D
                INC HL
                EX DE, HL
                LD A, (BC)
                INC BC
                EXX

                POP DE

                LD H, #FF
                LD L, A

.SetJumpMask    EQU $+1
                JR .JumpMask

.JumpMask       rept 7
                ADD HL, HL
                INC L
                endr
                
                LD A, E
                AND H
                LD E, A
                LD A, D
                AND L
                LD D, A
                EXX
                LD A, (BC)
                INC BC
                EXX
                LD H, #00
                LD L, A

.SetJumpSprite  EQU $+1
                JR .JumpSprite
.JumpSprite     rept 7
                ADD HL, HL
                endr

                LD A, E
                OR H
                LD E, A
                LD A, D
                OR L
                LD D, A
                PUSH DE

                EXX
                ; переход к следующей линии экрана
                LD HL, #0000
                ADD HL, SP
                INC H
                LD A, H
                AND %00000111
                JR NZ, .Next
                DEC H
                LD A, H
                AND %11111000
                LD H, A

                LD A, L
                ADD A, #20
                JR C, .NextSegment
                LD L, A
                JR .Next
.NextSegment    LD A, L
                AND %00011111
                LD L, A

                LD A, H
                ADD A, #08
                LD H, A
                AND %00011000
                CP %00011000
                JR Z, .Exit

.Next           EXX
                DJNZ .Loop
             
.ContainerSP    EQU $+1
.Exit           LD SP, #0000
                EI
                RET

RestoreBackground:
                LD HL, CursorBuffer

                rept 8
                LD C, (HL)
                INC HL
                LD B, (HL)
                INC HL
                LD A, (HL)
                INC HL
                LD (BC), A
                INC BC
                LD A, (HL)
                INC HL
                LD (BC), A
                endr                            
                RET

CursorSprite:   DB %00001111, %11000000
                DB %00000011, %11110000
                DB %00110001, %01111100
                DB %00001100, %01111110
                DB %10000000, %00111110
                DB %10000001, %00111100
                DB %11000011, %00011000
                DB %11100111, %00000000

CursorBuffer:   DS 4 * 8, 0
CursorAddress:  DW #0000

                endif ; ~_CORE_DRAW_CURSOR_
