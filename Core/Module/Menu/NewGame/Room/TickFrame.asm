
                ifndef _CORE_MODULE_MENU_MAIN_NEW_GAME_ROOM_TICK_FRAME_
                define _CORE_MODULE_MENU_MAIN_NEW_GAME_ROOM_TICK_FRAME_
TickFrame:      ;
                LD HL, Flags
                BIT COUNTDOWN_BIT, (HL)
                RET Z
                RES COMPLETED_BIT, (HL)

                ; уменьшение счётчика продолжительности одного кадра
                LD HL, FrameCounter
                DEC (HL)
                RET NZ
                LD (HL), DELAY_FRAME

                ;
                LD HL, Flags
                RES COUNTDOWN_BIT, (HL)
                SET COMPLETED_BIT, (HL)

                RET

                endif ; ~ _CORE_MODULE_MENU_MAIN_NEW_GAME_ROOM_TICK_FRAME_
