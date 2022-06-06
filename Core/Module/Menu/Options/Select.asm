
                ifndef _CORE_MODULE_MENU_OPTIONS_SELECT_
                define _CORE_MODULE_MENU_OPTIONS_SELECT_
Begin:          EQU $
; -----------------------------------------
; обработчик смены опции вверх/вниз или влево/вправо
; In:
;   IY - указывает на структуру FTVFX
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Changed:        ; выбор внутри опции (влево/вправо)
                LD HL, MenuVariables.Flags
                BIT OPTION_BIT, (HL)
                RET Z

                ; сброс флага запроса смены
                RES OPTION_BIT, (HL)

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
CanSelected:    ; проверка выбора доступных опций
                LD A, (MenuVariables.Current)
                CP OPTIONS_LANGUAGE
                JP Z, CantBeSelected
                CP OPTIONS_GAME_SPEED
                JP Z, CantBeSelected
                CP OPTIONS_CURSOR_SPEED
                JP Z, CantBeSelected

                JP CanBeSelected
; -----------------------------------------
; обработчик выбора опции (нажат выбор опции)
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Selected:       ; проверка выбора доступных опций
                LD A, (MenuVariables.Current)
                CP OPTIONS_LANGUAGE
                RET Z
                CP OPTIONS_GAME_SPEED
                RET Z
                CP OPTIONS_CURSOR_SPEED
                RET Z

                CALL WaitEvent

                ; CP OPTIONS_CONTROL
                ; JP Z, MenuControl

                CP OPTIONS_BACK
                JP Z, ApplyOptions

                JR $
ApplyOptions:   ; установка языка
                LD A, (OptionsLanguage.Current)
                INC A                                                           ; язык начинается с 1
                LD C, A
                LD A, (ConfigOptions)
                AND LANGUAGE_MASK
                CP C
                JP Z, @Main.Back

                SET_LANGUAGE_A

                JP @MenuMain

                display " - Select : \t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_SELECT_