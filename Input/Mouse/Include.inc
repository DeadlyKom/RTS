    
                ifndef _INPUT_MOUSE_INCLUDE_
                define _INPUT_MOUSE_INCLUDE_

VK_LBUTTON      EQU %00000001
VK_RBUTTON      EQU %00000010
VK_MBUTTON      EQU %00000100

                include "Initialize.asm"
                include "GetMouseKeyState.asm"
                include "GetMouseCursorPosition.asm"
                include "UpdateMouseState.asm"

                endif ; ~_INPUT_MOUSE_INCLUDE_
