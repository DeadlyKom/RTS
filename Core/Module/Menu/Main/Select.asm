
                ifndef _CORE_MODULE_MENU_MAIN_SELECT_
                define _CORE_MODULE_MENU_MAIN_SELECT_
Select:         ; инициализация VFX
                LD IY, VFX.Text.Variables
                LD HL, UpdateTextVFX
                LD (IY + VFX.Text.FTextVFX.FrameComplited), HL
                LD HL, NextTextVFX
                LD (IY + VFX.Text.FTextVFX.VFX_Complited), HL

                ; отрисовка меню
                LD HL, Menu
                LD A, (HL)
                CALL SetMenuText

                ; включить отображение курсора
                LD HL, Menu.Flag
                SET DRAW_CURSOR_BIT, (HL)

                LD A, #01                                                       ; длительности первого фрейма
                CALL SetDefaultVFX                                              ; установка эффекта
                
.Loop           HALT

                ; проверка флага смены меню
                LD HL, Menu.Flag
                BIT CHANGE_BIT, (HL)
                CALL NZ, ChangeMenu

                ; проверка флага выбора меню
                LD HL, Menu.Flag
                BIT SELECT_BIT, (HL)
                CALL NZ, SelectMenu

                ; обработка ввода
                LD DE, InputDefault
                CALL Input.JumpDefaulKeys
                JR .Loop

NextTextVFX:    CALL Math.Rand8
                CP #2F                                                          ; чем меньше тем реже происходит смена эффекта
                JR NC, .Wait

                ; генерация эффекта
                AND #03
                INC A                                                           ; пропуск дефолтного эффекта
                LD C, A                                                         ; номер эффекта
                LD A, #01
                JP SetCustomVFX                                                 ; установка эффекта

.Wait           LD B, #00
                RRA
                ADC A, B
                RRA
                ADC A, B
                RRA
                ADC A, B
                RRA
                ADC A, B
SetDefaultVFX:  LD C, VFX.Text.MenuVFX.DEFAULT_VFX                              ; номер эффекта
SetCustomVFX:   LD HL, VFX.Text.MenuVFX.Table                                   ; таблица эффектов
                JP VFX.Text.SetTextVFX.CustomFrame                              ; установка эффекта

ChangeMenu:     ; проверка флага PLAYING_VFX
                BIT VFX.Text.PLAYING_VFX_BIT, (IY + VFX.Text.FTextVFX.Flags)
                RET NZ

                ; сброс флага запроса смены
                RES CHANGE_BIT, (HL)
                
                ; сброс флага PLAYING_VFX
                RES VFX.Text.PLAYING_VFX_BIT, (IY + VFX.Text.FTextVFX.Flags)

                ;
                DEC HL
                LD A, (HL)
                CALL SetMenuText

                ; сброс флага перерисовка флага
                LD HL, Menu.Flag  
                SET DRAW_CURSOR_BIT, (HL)

                RET

SelectMenu:     ; проверка флага PLAYING_VFX
                BIT VFX.Text.PLAYING_VFX_BIT, (IY + VFX.Text.FTextVFX.Flags)
                RET NZ

                ; сброс флага запроса смены
                RES SELECT_BIT, (HL)

                ; сброс флага PLAYING_VFX
                RES VFX.Text.PLAYING_VFX_BIT, (IY + VFX.Text.FTextVFX.Flags)

                ; LD A, #01
                ; LD C, VFX.Text.MenuVFX.FADEOUT_VFX                              ; номер эффекта
                ; CALL SetCustomVFX

                ; SET_PAGE_SHADOW_SCREEN
                ; CLS_C000
                ; ATTR_C000_IPB RED, BLACK, 0

                ; HALT

                ; SET_PAGE_SHADOW_SCREEN
                ; CLS_C000
                ; ATTR_C000_IPB RED, BLACK, 0
                
                ; инициализация VFX
                ; LD IY, VFX.Text.Variables
                LD HL, UpdateTextVFX
                LD (IY + VFX.Text.FTextVFX.FrameComplited), HL
                LD HL, FadeoutNextText
                LD (IY + VFX.Text.FTextVFX.VFX_Complited), HL

                LD HL, Menu.Flag
                LD (HL), #00

                ; отрисовка меню
                ; LD HL, Menu
                ; LD A, (HL)
                ; CALL SetMenuText
                CALL SetFadeoutVFX

.Loop           HALT

                LD HL, Menu.Flag
                BIT NEXT_FADEIN_BIT, (HL)
                CALL NZ, PreFadeoutText

                LD HL, Menu.Flag
                BIT ALL_FADEIN_BIT, (HL)
                JP NZ, Main.Reset

                JR .Loop

                endif ; ~ _CORE_MODULE_MENU_MAIN_SELECT_