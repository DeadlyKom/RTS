
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
Changed:        ; выбор внутри опции (влево/вправо)
                LD HL, MenuVariables.Flags
                BIT OPTION_BIT, (HL)
                RET Z

                ; сброс флага запроса смены
                RES OPTION_BIT, (HL)

                ; проверка выбора доступных опций
                LD A, (MenuVariables.Current)
                CP OPTION_BACK
                RET Z

                CP OPTION_LANGUAGE
                JP Z, ReqChangeLang
                CP OPTION_CONTROL
                JP Z, ReqChangeCH
                CP OPTION_AUDIO
                JP Z, ReqChangeAudio
                CP OPTION_GRAPHICS
                JP Z, ReqChangeGraphics
                CP OPTION_GAME_SPEED
                JP Z, ReqChangeGS
                CP OPTION_CURSOR_SPEED
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
                CP OPTION_LANGUAGE
                JP Z, CantBeSelected
                CP OPTION_GAME_SPEED
                JP Z, CantBeSelected
                CP OPTION_CURSOR_SPEED
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
                CP OPTION_LANGUAGE
                RET Z
                CP OPTION_GAME_SPEED
                RET Z
                CP OPTION_CURSOR_SPEED
                RET Z

                CALL WaitEvent

                CP OPTION_CONTROL
                JP Z, MenuControl
                CP OPTION_BACK
                JP Z, Main.Back
                CP OPTION_APPLY
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
                CALL SetLanguage

                JP MenuOptions

; ApplyLanguadge: LD A, (OptionsLanguage.Current)
;                 INC A                                                           ; язык начинается с 1
;                 LD C, A
;                 LD A, (ConfigOptions)
;                 AND LANGUAGE_MASK
;                 CP C
;                 RET Z
;                 SET_LANGUAGE_A
;                 JP SetLanguage

                display " - Options Select : \t\t\t", /A, Changed, " = busy [ ", /D, $ - Changed, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_SELECT_