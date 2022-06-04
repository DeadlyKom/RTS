
                ifndef _CORE_MODULE_MENU_OPTIONS_SELECT_
                define _CORE_MODULE_MENU_OPTIONS_SELECT_
ChangeMenu:     RET
SelectMenu:     ; установка функции обработчика завершения эффекта
                LD HL, Selected
                LD (IY + FTVFX.VFX_Complited), HL

                HALT
                
                ; подготовка экрана 1
                SET_SCREEN_BASE
                CLS_C000
                ATTR_C000_IPB RED, BLACK, 1

                ; подготовка экрана 2
                SET_SCREEN_SHADOW
                CLS_C000
                ATTR_C000_IPB RED, BLACK, 0

.Loop           LD HL, MenuVariables.Flags
                BIT JUMP_BIT, (HL)
                JP NZ, Options
                JR .Loop
Selected:       ; проверка ранее установленного флага SELECT_BIT
                LD HL, MenuVariables.Flags
                SET JUMP_BIT, (HL)

                RET

                display " - Select : \t\t\t", /A, Select, " = busy [ ", /D, $ - Select, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_SELECT_