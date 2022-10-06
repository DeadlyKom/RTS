
                ifndef _CORE_MODULE_MENU_RESUME_GAME_
                define _CORE_MODULE_MENU_RESUME_GAME_

                module ResumeGame
Begin:          EQU $
ResumeGame:     RET

                display " - Resume Game : \t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_MENU_RESUME_GAME_
