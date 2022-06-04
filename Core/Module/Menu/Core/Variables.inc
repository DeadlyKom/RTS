
                ifndef _CORE_MODULE_MENU_CORE_VARIABLES_
                define _CORE_MODULE_MENU_CORE_VARIABLES_

                struct FMenu
Options:        DW #0000                                                        ; адрес опций меню
Changed:        DW #0000                                                        ; адрес функции обработчика смены опции меню
Selected:       DW #0000                                                        ; адрес функции обработчика выбора опции меню
NumberOptions:  DB #00                                                          ; количество опций в текущем меню       (1)
Current:        DB #00                                                          ; текущая опция в меню                  (2)
Flags:          DB #00                                                          ; флаги                                 (3)
                ends

                endif ; ~ _CORE_MODULE_MENU_CORE_VARIABLES_