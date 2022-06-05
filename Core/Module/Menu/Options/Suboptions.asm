
                ifndef _CORE_MODULE_MENU_OPTIONS_SUBOPTIONS_
                define _CORE_MODULE_MENU_OPTIONS_SUBOPTIONS_

SuboptionsMenu: LD A, (MenuVariables.Current)
                CP OPTIONS_LANGUAGE
                JP Z, Language

                CP OPTIONS_GAME_SPEED
                JP Z, GameSpeed

                CP OPTIONS_CURSOR_SPEED
                JP Z, CursorSpeed

                RET

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_SUBOPTIONS_
