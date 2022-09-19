
                ifndef _CORE_MODULE_MENU_OPTIONS_CONTROL_SELECT_
                define _CORE_MODULE_MENU_OPTIONS_CONTROL_SELECT_
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

                CP OPTIONS_BACK
                RET Z

                CP OPTIONS_KEMPSTON
                JP Z, ReqChangeKEMPSTON

                CP OPTIONS_MOUSE
                JP Z, ReqChangeMouse

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
                CP OPTIONS_KEMPSTON
                JP Z, CantBeSelected
                CP OPTIONS_MOUSE
                JP Z, CantBeSelected
                ; CP OPTIONS_KEYBOARD
                ; JP Z, CantBeSelected

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
                CP OPTIONS_MOUSE
                RET Z
                CP OPTIONS_KEMPSTON
                RET Z

                CALL WaitEvent

                CP OPTIONS_KEYBOARD
                JP Z, MenuControlKey

                CP OPTIONS_BACK
                JP Z, ApplyControl

                JR $
ApplyControl:   ; установка языка
                ; LD A, (OptionsLanguage.Current)
                ; INC A                                                           ; язык начинается с 1
                ; LD C, A
                ; LD A, (ConfigOptions)
                ; AND LANGUAGE_MASK
                ; CP C
                ; JP Z, @MenuOptions

                ; SET_LANGUAGE_A

                JP @MenuOptions

                display " - Control Select : \t\t\t", /A, Changed, " = busy [ ", /D, $ - Changed, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_CONTROL_SELECT_