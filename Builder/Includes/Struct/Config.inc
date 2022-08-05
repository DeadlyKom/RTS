
                ifndef _STRUCT_CONFIG_
                define _STRUCT_CONFIG_

                struct FConfig
KeyMenu         DB VK_ENTER                                                     ; клавиша по умолчанию "меню/пауза" (0)
KeyAcceleration DB VK_CAPS_SHIFT                                                ; клавиша по умолчанию "Усклорить"
KeyDeselect     DB VK_SYMBOL_SHIFT                                              ; клавиша по умолчанию "Отмена"
KeySelect       DB VK_SPACE                                                     ; клавиша по умолчанию "Выбор"
KeyRight        DB VK_D                                                         ; клавиша по умолчанию "Вправо"
KeyLeft         DB VK_A                                                         ; клавиша по умолчанию "Влево"
KeyDown         DB VK_S                                                         ; клавиша по умолчанию "Вниз"
KeyUp           DB VK_W                                                         ; клавиша по умолчанию "Вверх"
SpeedCursorMin  DB #00                                                          ; минимальная скорость курсора
SpeedCursorMax  DB #00                                                          ; максимальная скорость курсора
;
;      7    6    5    4    3    2    1    0
;   +----+----+----+----+----+----+----+----+
;   | .. | .. | .. | S0 | I1 | I0 | L1 | L0 |
;   +----+----+----+----+----+----+----+----+
;
;   L1-L0 - [1-0]   - язык
;   I1-I0 - [3-2]   - инпут
;   S0    - [4]     - звук
;
Options         DB #00
LevelSlot       DB #00                                                          ; номер слота уровня
                ends

                endif ; ~_STRUCT_CONFIG_
