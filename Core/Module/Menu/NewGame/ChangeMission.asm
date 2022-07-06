
                ifndef _CORE_MODULE_MENU_START_GAME_
                define _CORE_MODULE_MENU_START_GAME_
@NewGame:       ; подготовка
                CALL CLS                                                        ; очистка экранов
                CALL ResetOptions                                               ; сброс опций

                ;
                SetUserHendler Room.TickFrame

                ; инициализация комнаты
                CALL Room.Initialize
                
.Loop           HALT

                LD HL, Room.Flags
                BIT Room.REQ_ROTATE_BIT, (HL)
                CALL NZ, Room.NextFrame

                ; обработка ввода
                LD DE, InputNewGame
                CALL Input.JumpDefaulKeys
                JR .Loop

                endif ; ~ _CORE_MODULE_MENU_START_GAME_
