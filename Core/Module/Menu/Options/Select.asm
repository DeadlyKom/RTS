
                ifndef _CORE_MODULE_MENU_OPTIONS_SELECT_
                define _CORE_MODULE_MENU_OPTIONS_SELECT_
; -----------------------------------------
; обработчик смены опции вверх/вниз или влево/вправо
; In:
;   IY - указывает на структуру FTVFX
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ChangeOption:   ; выбор внутри опции (влево/вправо)
                LD HL, MenuVariables.Flags
                BIT OPTION_BIT, (HL)
                RET Z

                ; сброс флага запроса смены
                RES OPTION_BIT, (HL)
SelectingOption ; выбор внутри опции (влево/вправо)

                ; проверка выбора доступных опций
                LD A, (MenuVariables.Current)
                CP OPTIONS_CONTROL
                RET Z

                CP OPTIONS_BACK
                RET Z

                CP OPTIONS_LANGUAGE
                JP Z, ReqChangeLang

                CP OPTIONS_GAME_SPEED
                JP Z, ReqChangeGS

                CP OPTIONS_CURSOR_SPEED
                JP Z, ReqChangeCS

                RET

; -----------------------------------------
; обработчик возможности выбора опции (нажат выбор опции)
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
CanSelectedOption:
                ; проверка выбора доступных опций
                LD A, (MenuVariables.Current)
                CP OPTIONS_LANGUAGE
                JP Z, CantSelected
                CP OPTIONS_GAME_SPEED
                JP Z, CantSelected
                CP OPTIONS_CURSOR_SPEED
                JP Z, CantSelected

                JP CanSelected
; -----------------------------------------
; обработчик выбора опции (нажат выбор опции)
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SelectedOption: ; проверка выбора доступных опций
                LD A, (MenuVariables.Current)
                CP OPTIONS_LANGUAGE
                RET Z
                CP OPTIONS_GAME_SPEED
                RET Z
                CP OPTIONS_CURSOR_SPEED
                RET Z

                CALL Reset

                ; установка функции обработчика завершения эффекта
                LD HL, .Handler
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
                JP Z, .Loop

                LD A, (MenuVariables.Current)
                CP OPTIONS_CONTROL
                JP Z, Options

                CP OPTIONS_BACK
                JP Z, ApplyOptions

                JR $

.Handler:       ; выбрана опция (нажат выбор опции)
                LD HL, MenuVariables.Flags
                SET JUMP_BIT, (HL)

                RET
ApplyOptions:   ; установка языка
                LD A, (OptionsLanguage.Current)
                INC A                                                           ; язык начинается с 1
                LD C, A
                LD A, (ConfigOptions)
                AND LANGUAGE_MASK
                CP C
                JP Z, @Main.Back

                SET_LANGUAGE_A

                JP @Main.Load

                display " - Select : \t\t\t", /A, Select, " = busy [ ", /D, $ - Select, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_SELECT_