
                ifndef _CORE_HANDLER_INPUT_
                define _CORE_HANDLER_INPUT_

                module Input

KeyStackSize    EQU 5

                include "../Structure/Input.inc"

Initialize:     ;
                CALL Mouse.Initialize
                RET

ScanKeyboard:   ;
                CALL TilemapMove

                ; ; select
                ; LD A, VK_LBUTTON
                ; CALL CheckKeyState
                ; CALL Z, .SetVK
                ; ; options
                ; LD A, VK_RBUTTON
                ; CALL CheckKeyState
                ; CALL Z, .SetVK
                RET

ScanMouse:      CALL Mouse.UpdateStatesMouse

                RET

TilemapMove:    ;
                LD HL, (TilemapRef)
                LD (.CompareAddress), HL

                ; move map left
                LD A, VK_A
                CALL CheckKeyState
                CALL Z, Tilemap.MoveLeft

                ; move map right
                LD A, VK_D
                CALL CheckKeyState
                CALL Z, Tilemap.MoveRight

                ; move map up
                LD A, VK_W
                CALL CheckKeyState
                CALL Z, Tilemap.MoveUp

                ; move map down
                LD A, VK_S
                CALL CheckKeyState
                CALL Z, Tilemap.MoveDown

                ; comparison of current and previous address values
                LD HL, (TilemapRef)
.CompareAddress EQU $+1
                LD DE, #0000                   
                OR A
                SBC HL, DE
                CALL NZ, Tilemap.Prepare
                RET
CheckKeyState:  LD HL, .RET
                LD (.VK), A
                OR A
                JP M, Mouse.CheckKeyState
                JP P, Keyboard.CheckKeyState
.VK             EQU $+1
.RET            LD A, #00
                RET

                endmodule

                endif ; ~_CORE_HANDLER_INPUT_
