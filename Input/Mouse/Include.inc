    
                ifndef _INPUT_MOUSE_INCLUDE_
                define _INPUT_MOUSE_INCLUDE_

MOUSE_BIT       EQU #80
VK_LBUTTON      EQU Mouse.SVK_LBUTTON | MOUSE_BIT
VK_RBUTTON      EQU Mouse.SVK_RBUTTON | MOUSE_BIT
VK_MBUTTON      EQU Mouse.SVK_MBUTTON | MOUSE_BIT

LEFT_EDGE       EQU 0x01
RIGHT_EDGE      EQU 0x02
TOP_EDGE        EQU 0x04
BOTTOM_EDGE     EQU 0x08

                module Mouse
SVK_LBUTTON     EQU %00000001
SVK_RBUTTON     EQU %00000010
SVK_MBUTTON     EQU %00000100
SVK_BUTTON_MASK EQU SVK_LBUTTON | SVK_RBUTTON | SVK_MBUTTON

                include "Initialize.asm"
                include "CheckKeyState.asm"
                include "GetMouseCursorPosition.asm"
                include "UpdateMouseState.asm"

                endmodule

                endif ; ~_INPUT_MOUSE_INCLUDE_
