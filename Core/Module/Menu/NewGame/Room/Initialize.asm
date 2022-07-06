
                ifndef _CORE_MODULE_MENU_MAIN_NEW_GAME_ROOM_INITIALIZE_
                define _CORE_MODULE_MENU_MAIN_NEW_GAME_ROOM_INITIALIZE_
Initialize:     ; инициализация
                XOR A
                LD (Flags), A
                LD (Frame), A
                LD A, DELAY_FRAME
                LD (FrameCounter), A

                ; отображени первого фрейма
                CALL DrawFrame

                LD HL, Flags
                SET COMPLETED_BIT, (HL)
                
                RET

                endif ; ~ _CORE_MODULE_MENU_MAIN_NEW_GAME_ROOM_INITIALIZE_
