
                ifndef _STRUCT_CONFIG_
                define _STRUCT_CONFIG_

                struct FConfig
;
;      7    6    5    4    3    2    1    0
;   +----+----+----+----+----+----+----+----+
;   | .. | .. | .. | .. | .. | .. | L1 | L0 |
;   +----+----+----+----+----+----+----+----+
;
;   L1-L0 - [1-0]   - язык
;
Options         DB #00
SpeedCursorMin  DB #00                                                          ; минимальная скорость курсора
SpeedCursorMax  DB #00                                                          ; максимальная скорость курсора
KeyUp           DB VK_W                                                         ; клавиша по умолчанию "Вверх"
KeyDown         DB VK_S                                                         ; клавиша по умолчанию "Вниз"
KeyLeft         DB VK_A                                                         ; клавиша по умолчанию "Влево"
KeyRight        DB VK_D                                                         ; клавиша по умолчанию "Вправо"
KeySelect       DB VK_SPACE                                                     ; клавиша по умолчанию "Выбор"
KeyDeselect     DB VK_SYMBOL_SHIFT                                              ; клавиша по умолчанию "Отмена"
                ends

                endif ; ~_STRUCT_CONFIG_
