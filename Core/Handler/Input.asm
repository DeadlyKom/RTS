
                ifndef _CORE_HANDLER_INPUT_
                define _CORE_HANDLER_INPUT_

                module Input

KeyStackSize    EQU 32

                include "../Structure/Input.inc"

Initialize:     ;
                LD HL, KeyStack
                LD (ReadState), HL
                LD (WriteState), HL
                ;
                CALL Mouse.Initialize
                RET

ScanKeyboard:   ; LD DE, (WriteState)
;                 LD A, (DE)
;                 CALL CheckKeyState
                ; JR NZ, .NewKey

                ; ; counting the keystroke time
                ; LD (DE), A
                ; INC DE
                ; EX DE, HL
                ; INC (HL)
                ; RET

.NewKey         ; move map left
                LD A, VK_A
                CALL CheckKeyState
                CALL Z, .SetVK
                ; move map right
                LD A, VK_D
                CALL CheckKeyState
                CALL Z, .SetVK
                ; move map up
                LD A, VK_W
                CALL CheckKeyState
                CALL Z, .SetVK
                ; move map down
                LD A, VK_S
                CALL CheckKeyState
                CALL Z, .SetVK
                ; select
                LD A, VK_LBUTTON
                CALL CheckKeyState
                CALL Z, .SetVK
                ; options
                LD A, VK_RBUTTON
                CALL CheckKeyState
                CALL Z, .SetVK
                RET
.SetVK          ;
                CALL WriteCellStack
                LD (DE), A
                ; clear cell
                XOR A
                INC DE
                LD (DE), A
                INC DE
                LD (DE), A
                INC DE
                LD (DE), A
                RET
WriteCellStack: LD HL, (WriteState)
                LD DE, FKeyState
                ADD HL, DE
                EX DE, HL
                LD HL, -(KeyStack + KeyStackSize * FKeyState)
                ADD HL, DE
                LD HL, KeyStack
                JR C, .Cycle
                EX DE, HL
.Cycle          LD (WriteState), HL
                EX DE, HL
                RET

ReadCellStack:  LD DE, (ReadState)
                LD HL, (WriteState)
                OR A
                SBC HL, DE

                ; exit if ReadState and WriteState are equal
                EX DE, HL
                LD A, VK_NONE
                RET Z

                ;
                LD A, (HL)
                LD DE, FKeyState
                ADD HL, DE
                EX DE, HL
                LD HL, -(KeyStack + KeyStackSize * FKeyState)
                ADD HL, DE
                LD HL, KeyStack
                JR C, .Cycle
                EX DE, HL
.Cycle          LD (ReadState), HL
                EX DE, HL
                RET

ScanMouse:      RET

CheckKeyState:  LD HL, .RET
                LD (.VK), A
                OR A
                JP M, Mouse.CheckKeyState
                JP P, Keyboard.CheckKeyState
.VK             EQU $+1
.RET            LD A, #00
                RET
KeyStates:      ;
                LD HL, (TilemapRef)
                LD (.CompareAddress), HL
                LD IX, .Loop
                ;
.Loop           CALL ReadCellStack
                CP VK_NONE
                JR NZ, .NotLast

                LD A, (HL)
                CP VK_NONE
                JR Z, .Exit
                
                LD (HL), VK_NONE

                LD IX, .Exit
                
                
.NotLast

                ;
                CP VK_A
                JP Z, Tilemap.MoveLeft

                ;
                CP VK_D
                JP Z, Tilemap.MoveRight

                ;
                CP VK_W
                JP Z, Tilemap.MoveUp

                ;
                CP VK_S
                JP Z, Tilemap.MoveDown

                ;
.Exit           LD HL, (TilemapRef)
.CompareAddress EQU $+1
                LD DE, #0000                   
                OR A
                SBC HL, DE
                CALL NZ, Tilemap.Prepare

                RET

ReadState:      DW #0000
WriteState:     DW #0000;-(KeyStackSize * FKeyState)
KeyStack:       FKeyState = $
                DS KeyStackSize * FKeyState, VK_NONE

                endmodule

                endif ; ~_CORE_HANDLER_INPUT_
