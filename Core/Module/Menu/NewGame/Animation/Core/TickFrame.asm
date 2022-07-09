
                ifndef _CORE_MODULE_MENU_MAIN_NEW_GAME_ANIMATION_CORE_TICK_FRAME_
                define _CORE_MODULE_MENU_MAIN_NEW_GAME_ANIMATION_CORE_TICK_FRAME_
TickFrame:      ;
                LD A, (Room.Number)
                CP Room.ROTATE
                RET Z

                CP Room.LEFT
                JP Z, Room.Left.Tick

                RET

                endif ; ~ _CORE_MODULE_MENU_MAIN_NEW_GAME_ANIMATION_CORE_TICK_FRAME_
