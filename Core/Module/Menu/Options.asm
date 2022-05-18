
                ifndef _CORE_MODULE_MENU_OPTIONS_
                define _CORE_MODULE_MENU_OPTIONS_

                module Options
Begin:          EQU $
Options:        RET

                display " - Options : \t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_
