
                ifndef _CORE_MODULE_MENU_CORE_VARIABLES_
                define _CORE_MODULE_MENU_CORE_VARIABLES_

                struct FMenu
Options:        DW #0000                                                        ; адрес опций
Suboptions:     DW #0000                                                        ; адрес подопций
SuboptionsFunc: DW #0000                                                        ; адрес функции обработчика подопций
Changed:        DW #0000                                                        ; адрес функции обработчика смены опции меню
Selected:       DW #0000                                                        ; адрес функции обработчика выбора опции меню
CanSelected:    DW #0000                                                        ; адрес функции обработчика возможности выбора опции меню
NumberOptions:  DB #00                                                          ; количество опций в текущем меню       (1)
Current:        DB #00                                                          ; текущая опция в меню                  (2)
Flags:          DB #00                                                          ; флаги                                 (3)
AddFlags:       DB #00                                                          ; дополнительные флаги                  (4)

                ends

                endif ; ~ _CORE_MODULE_MENU_CORE_VARIABLES_