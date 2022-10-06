
                ifndef _CORE_MODULE_INTERRUPT_INCLUDE_
                define _CORE_MODULE_INTERRUPT_INCLUDE_

                module Interrupt
Begin:          EQU $
                include "Handler.asm"

                display " - Interrupt : \t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_INTERRUPT_INCLUDE_