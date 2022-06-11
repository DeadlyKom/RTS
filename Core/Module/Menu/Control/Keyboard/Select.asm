
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
                CALL RefreshMenuText
                CALL WaitVFX

                ; ожидание отпускание ранее нажатой клавиши
                CALL WaitReleasedKey

                ; ожидание нажатия клавиши
.WaitPressedKey HALT
                CALL GetPressedKey
                JR NC, .WaitPressedKey

                ; установка нажатой клавиши
                LD A, (MenuVariables.Current)
                DEC A
                LD L, A
                LD H, HIGH GameConfigRef
                LD (HL), E
                LD D, L
                PUSH DE
                INC A
                CALL RefreshMenuText
                CALL WaitVFX

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

                ; выключить отображение курсора
                LD HL, MenuVariables.Flags
                RES DRAW_CURSOR_BIT, (HL)

                CALL GetTextCoord
                PUSH BC

                CALL ASD
                CALL WaitVFX
                ; CALL WaitEventVFX

                POP BC
                CALL SetTextCoord

                ; -----------------------------------------
                ; обновление изменённого меню
                ; -----------------------------------------
                CALL RNDTextVFX                                                 ; проиграть новый эффект
                POP AF
                CALL SetMenuText
                CALL WaitVFX

.Break          ; ожидание отпускание ранее нажатой клавиши
                JP WaitReleasedKey

; ожидание завершения VFX
WaitVFX:        HALT
                BIT VFX_PLAYING_BIT, (IY + FTVFX.Flags)
                JP Z, WaitVFX
                RET
WaitEventVFX:   PUSH HL

                LD HL, (IY + FTVFX.VFX_Complited)
                PUSH HL

                ; установка функции обработчика завершения эффекта
                LD HL, .OnComplited
                LD (IY + FTVFX.VFX_Complited), HL

                LD HL, MenuVariables.Flags
                RES JUMP_BIT, (HL)

.WaitLoop       ; ожидание завершения VFX
                HALT
                BIT JUMP_BIT, (HL)
                JP Z, .WaitLoop

                POP HL
                LD (IY + FTVFX.VFX_Complited), HL
                POP HL

                RET

.OnComplited    ; установка флага разрешения перехода в выбранное меню
                LD HL, MenuVariables.Flags
                SET JUMP_BIT, (HL)
                RET

; -----------------------------------------
; получить Virtual Key нажатой клавиши  
; In:
; Out:
;   если была нажата клавиша флаг переполнения Carry установлен,
;   регистре E хранится Virtual Key, в противном случае флаг cброшен
; Corrupt:
;   DE, BC, AF, AF'
; Note:
;   SerdjukSVS (C)
; -----------------------------------------
GetPressedKey:  LD DE, #0500
                LD BC, #FEFE
.NextPort       IN A, (C)
                CPL
.NextBit        RRA
                RET C
                INC E
                DEC D
                JR NZ, .NextBit
                RLC B
                RET NC
                LD D, #05
                JR .NextPort

WaitReleasedKey HALT
                CALL GetPressedKey
                RET NC
                JR WaitReleasedKey

                display " - Keyboard Select : \t\t", /A, Changed, " = busy [ ", /D, $ - Changed, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_CONTROL_KEYBOARD_SELECT_