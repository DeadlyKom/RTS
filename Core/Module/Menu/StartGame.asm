
                ifndef _CORE_MODULE_MENU_START_GAME_
                define _CORE_MODULE_MENU_START_GAME_

                module StartGame
Begin:          EQU $
StartGame:      RET

                display " - Start Game : \t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_MENU_START_GAME_
