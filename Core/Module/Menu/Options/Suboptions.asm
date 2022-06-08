
                ifndef _CORE_MODULE_MENU_OPTIONS_SUBOPTIONS_
                define _CORE_MODULE_MENU_OPTIONS_SUBOPTIONS_

SuboptionsMenu: LD A, (MenuVariables.Current)
                CP OPTION_LANGUAGE
                JP Z, Language

                CP OPTION_CONTROL
                JP Z, ControlHelp

                CP OPTION_GAME_SPEED
                JP Z, GameSpeed

                CP OPTION_CURSOR_SPEED
                JP Z, CursorSpeed

                RET

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_SUBOPTIONS_
