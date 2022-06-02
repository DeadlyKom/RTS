    
                ifndef _MODULE_INPUT_INCLUDE_
                define _MODULE_INPUT_INCLUDE_

                display " - Input : \t\t\t", /A, $, " = busy [ ", /D, Input.End - $, " bytes  ]"
                include "Keyboard/Include.inc"
                include "Mouse/Include.inc"
                include "Kempston/Include.inc"

                module Input
Begin:          EQU $

                include "Input.asm"
                include "CheckKeyState.asm"
                include "CursorMove.asm"

                display "\t - Cursor : \t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"
End:            EQU $
                endmodule

                endif ; ~_MODULE_INPUT_INCLUDE_
