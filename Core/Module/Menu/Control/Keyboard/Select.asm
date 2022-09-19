
                ifndef _CORE_MODULE_MENU_OPTIONS_CONTROL_KEYBOARD_SELECT_
                define _CORE_MODULE_MENU_OPTIONS_CONTROL_KEYBOARD_SELECT_
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

                ; CP OPTIONS_KEMPSTON
                ; JP Z, ReqChangeKEMPSTON

                ; CP OPTIONS_MOUSE
                ; JP Z, ReqChangeMouse

                ; CP OPTIONS_CURSOR_SPEED
                ; JP Z, ReqChangeCS

                RET

; -----------------------------------------
; обработчик возможности выбора опции (нажат выбор опции)
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
CanSelected:    ; проверка выбора доступных опций
                ; LD A, (MenuVariables.Current)
                ; CP OPTIONS_KEMPSTON
                ; JP Z, CantBeSelected
                ; CP OPTIONS_MOUSE
                ; JP Z, CantBeSelected
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
                
                CP OPTION_BACK
                JR NZ, RedefineKeys

                CALL WaitEvent

                CP OPTION_BACK
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

                JP @MenuControl

RedefineKeys:   ; проиграть при переходе новый эффект
                CALL RNDTextVFX
                
                ; очистка клавиши
                LD A, (MenuVariables.Current)
                LD H, HIGH GameConfigRef
                DEC A
                LD L, A
                LD (HL), WAIT_INPUT_KEY
                INC A
                CALL RefreshCurrentOption

                CALL Keyboard.WaitReleasedKey                                   ; ожидание отпускание ранее нажатой клавиши
                CALL Keyboard.WaitPressedKey                                    ; ожидание нажатия клавиши

                ; установка нажатой клавиши
                LD A, (MenuVariables.Current)
                DEC A
                LD L, A
                LD H, HIGH GameConfigRef
                LD (HL), E
                LD D, L
                PUSH DE
                INC A
                CALL RefreshCurrentOption

                ; проверка коллизии клавиш
                POP DE
                LD HL, GameConfigRef
                LD B, OPTION_KEY_NUM
.CollisionLoop  LD A, L
                CP D
                JR Z, .Next
                LD A, (HL)
                CP E
                JR Z, .IsEqual
.Next           INC L
                DJNZ .CollisionLoop
                JR .Break

.IsEqual        CALL WaitEventVFX

                ; -----------------------------------------
                ; коллизия клавиш
                ; -----------------------------------------
                LD A, (MenuVariables.Current)
                PUSH AF

                LD (HL), VK_NONE
                LD A, L
                INC A

                CALL RefreshOption

                ; -----------------------------------------
                ; обновление изменённого меню
                ; -----------------------------------------
                CALL RNDTextVFX                                                 ; проиграть новый эффект
                POP AF
                CALL SetOption
                CALL WaitVFX

.Break          ; ожидание отпускание ранее нажатой клавиши
                JP Keyboard.WaitReleasedKey 

                display " - Keyboard Select : \t\t\t", /A, Changed, " = busy [ ", /D, $ - Changed, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_CONTROL_KEYBOARD_SELECT_