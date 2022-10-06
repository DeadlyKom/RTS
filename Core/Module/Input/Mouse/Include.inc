    
                ifndef _INPUT_MOUSE_INCLUDE_
                define _INPUT_MOUSE_INCLUDE_

                module Mouse
Begin:          EQU $
SVK_LBUTTON     EQU %00000001
SVK_RBUTTON     EQU %00000010
SVK_MBUTTON     EQU %00000100
SVK_BUTTON_MASK EQU SVK_LBUTTON | SVK_RBUTTON | SVK_MBUTTON

                include "Initialize.asm"
                include "CheckKeyState.asm"
                include "GetMouseCursorPosition.asm"
                include "UpdateCursor.asm"

                display "\t - Mouse : \t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~_INPUT_MOUSE_INCLUDE_
