    
                ifndef _INPUT_KEMPSTON_INCLUDE_
                define _INPUT_KEMPSTON_INCLUDE_

                module Kempston
Begin:          EQU $
                include "CheckKeyState.asm"

                display "\t - Kempston : \t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"
                endmodule

                endif ; ~_INPUT_KEMPSTON_INCLUDE_
