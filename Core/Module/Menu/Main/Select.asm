
                ifndef _CORE_MODULE_MENU_MAIN_SELECT_
                define _CORE_MODULE_MENU_MAIN_SELECT_

ChangeMenu:     RET
SelectMenu:     ; установка функции обработчика завершения эффекта
                LD HL, OnComplited
                LD (IY + FTVFX.VFX_Complited), HL

                POP AF                                                          ; удалить из стека адрес выхода
                HALT
                
                ; подготовка экрана 1
                SET_SCREEN_BASE
                CLS_C000
                ATTR_C000_IPB RED, BLACK, 1

                ; подготовка экрана 2
                SET_SCREEN_SHADOW
                CLS_C000
                ATTR_C000_IPB RED, BLACK, 0

.Loop           ; ожидание завершения faidout'а
                LD HL, MenuVariables.Flags
                BIT JUMP_BIT, (HL)
                JP Z, .Loop

                LD A, (MenuVariables.Current)
                CP MENU_OPTIONS
                JP Z, Options

                JR $
OnComplited:    ; установка флага разрешения перехода в выбранное меню
                LD HL, MenuVariables.Flags
                SET JUMP_BIT, (HL)
                OffUserHendler
                RET

                display " - Select : \t\t\t", /A, Select, " = busy [ ", /D, $ - Select, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_MAIN_SELECT_