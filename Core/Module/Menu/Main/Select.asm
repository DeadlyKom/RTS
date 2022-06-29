
                ifndef _CORE_MODULE_MENU_MAIN_SELECT_
                define _CORE_MODULE_MENU_MAIN_SELECT_
Begin:          EQU $
Changed:        RET
Selected:       CALL WaitEvent

                CP MENU_OPTIONS
                JP Z, MenuOptions

                CP MENU_NEW_GAME
                JP Z, NewGame

                JR $

                display " - Select : \t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_MAIN_SELECT_