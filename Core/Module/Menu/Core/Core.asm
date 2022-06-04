
                ifndef _CORE_MODULE_MENU_CORE_
                define _CORE_MODULE_MENU_CORE_
@UpdateTextVFX:  ;
.Coord          EQU $+1
                LD DE, #0000
                CALL RenderVFX

                LD HL, MenuVariables.Flags
                BIT DRAW_CURSOR_BIT, (HL)
                RET Z

                ; сброс флага перерисовка флага
                RES DRAW_CURSOR_BIT, (HL)

                ; очиста курсора
.OldCoord       EQU $+1
                LD DE, #0000
                DEC E
                CALL PixelAddress
                XOR A
                dup  7
                LD (DE), A
                INC D
                edup
                LD (DE), A

                ; вывод курсора
                LD DE, (.Coord)
                DEC E
                CALL PixelAddress
                LD HL, SelectCursor
                JP DrawCharBoundary

; A - номер меню
@SetMenuText:   ; установка выбранного меню
                LD (MenuVariables.Current), A

                ; сохранить позицию курсора
                LD HL, (UpdateTextVFX.Coord)
                LD (UpdateTextVFX.OldCoord), HL

.NotUpdate      ; расчёт информации о меню
                LD HL, (MenuVariables.Options)
                INC HL
                LD D, #00
                LD E, A
                ADD A, A
                ADD A, E
                LD E, A
                ADD HL, DE
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                LD (UpdateTextVFX.Coord), DE

                ; копирование текста в буфер
                LD A, (HL)
                CALL Functions.TextToBuffer

                ; округление длины текста до знакоместа
                LD A, E
                LD B, #00
                RRA
                ADC A, B
                RRA
                ADC A, B
                RRA
                ADC A, B
                AND %00011111
                LD (IY + FTVFX.Length), A

                RET

@Select:        ; инициализация VFX
                LD IY, VariablesVFX
                LD HL, UpdateTextVFX
                LD (IY + FTVFX.FrameComplited), HL
                LD HL, NextTextVFX
                LD (IY + FTVFX.VFX_Complited), HL

                ; отрисовка меню
                LD HL, (MenuVariables.Options)
                LD A, (HL)
                CALL SetMenuText

                ; включить отображение курсора
                LD HL, MenuVariables.Flags
                SET DRAW_CURSOR_BIT, (HL)

                LD A, #01                                                       ; длительности первого фрейма
                CALL SetDefaultVFX                                              ; установка эффекта
                
.Loop           HALT

                ; проверка флага смены меню
                LD HL, MenuVariables.Flags
                BIT CHANGE_BIT, (HL)
                CALL NZ, ChangeMenu

                ; проверка флага выбора меню
                LD HL, MenuVariables.Flags
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
                JP SetVFX_Custom                                                ; установка эффекта

.Wait           LD B, #00
                RRA
                ADC A, B
                RRA
                ADC A, B
                RRA
                ADC A, B
                RRA
                ADC A, B
SetDefaultVFX:  LD C, VFX_DEFAULT                                               ; номер эффекта
                JP SetVFX_Custom                                                ; установка эффекта

ChangeMenu:     ; проверка флага PLAYING_VFX
                BIT VFX_PLAYING_BIT, (IY + FTVFX.Flags)
                RET NZ

                ; проверка отсутсвие флага необходимости обновить курсор
                BIT DRAW_CURSOR_BIT, (HL)
                RET NZ

                ; сброс флага запроса смены
                RES CHANGE_BIT, (HL)
                
                ; сброс флага PLAYING_VFX
                RES VFX_PLAYING_BIT, (IY + FTVFX.Flags)

                ; становка нового выбранного меню
                DEC HL
                LD A, (HL)
                CALL SetMenuText

                ; сброс флага перерисовка курсора
                LD HL, MenuVariables.Flags
                SET DRAW_CURSOR_BIT, (HL)

                LD HL, MenuVariables.Changed
                JR Jump
SelectMenu:     ; проверка флага PLAYING_VFX
                BIT VFX_PLAYING_BIT, (IY + FTVFX.Flags)
                RET NZ

                ; сброс флага запроса смены
                RES SELECT_BIT, (HL)

                ; сброс флага PLAYING_VFX
                RES VFX_PLAYING_BIT, (IY + FTVFX.Flags)

                LD A, #01
                LD C, VFX_FADEOUT                                               ; номер эффекта
                CALL SetVFX_Custom
                
                LD HL, MenuVariables.Selected
Jump:           LD E, (HL)
                INC HL
                LD D, (HL)
                EX DE, HL
                JP (HL)

                display " - Core : \t\t\t", /A, UpdateTextVFX, " = busy [ ", /D, $ - UpdateTextVFX, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_CORE_