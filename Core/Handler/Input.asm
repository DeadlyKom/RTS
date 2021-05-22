
                ifndef _CORE_HANDLER_INPUT_
                define _CORE_HANDLER_INPUT_

                module Input

KeyStackSize    EQU 5

                include "../Structure/Input.inc"

Initialize:     ;
                CALL Mouse.Initialize
                RET

ScanKeyboard:   ; ; select
                ; LD A, VK_LBUTTON
                ; CALL CheckKeyState
                ; CALL Z, .SetVK
                ; ; options
                ; LD A, VK_RBUTTON
                ; CALL CheckKeyState
                ; CALL Z, .SetVK

                RET

ScanMoveMap:    ; save the current address of the visible area of the tilemap
                LD HL, (TilemapRef)
                LD (.CompareAddress), HL
                
                CALL KeyboardMove
                CALL MouseMoveEdgeB

                ; comparison of current and previous address values
                LD HL, (TilemapRef)
.CompareAddress EQU $+1
                LD DE, #0000                   
                OR A
                SBC HL, DE
                CALL NZ, Tilemap.Prepare
                RET

; перемещение, если двигать мышь за пределы экрана
MouseMoveEdgeA: LD A, (MouseEdgeFlagRef)
                LD C, A
                RR C
                CALL C, Tilemap.MoveLeft
                RR C
                CALL C, Tilemap.MoveRight
                RR C
                CALL C, Tilemap.MoveUp
                RR C
                CALL C, Tilemap.MoveDown
                XOR A
                LD (MouseEdgeFlagRef), A
                RET

; перемещение, классическое
MouseMoveEdgeB: LD BC, MousePositionRef
                LD A, (BC)
                CP #04
                CALL C, Tilemap.MoveLeft
                LD A, (BC)
                CP #FC
                CALL NC, Tilemap.MoveRight
                INC BC
                LD A, (BC)
                CP #04
                CALL C, Tilemap.MoveUp
                LD A, (BC)
                CP #BC
                CALL NC, Tilemap.MoveDown
                RET

ScanMouse:      CALL Mouse.UpdateStatesMouse

                RET

KeyboardMove:   ; move map left
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
