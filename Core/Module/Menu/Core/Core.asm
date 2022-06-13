
                ifndef _CORE_MODULE_MENU_CORE_
                define _CORE_MODULE_MENU_CORE_
@UpdateTextVFX: ;
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
@SetOption:     ; сохранить позицию курсора
                LD HL, (UpdateTextVFX.Coord)
                LD (UpdateTextVFX.OldCoord), HL

@SetOption.Transient:
                ; установка выбранного меню
                LD (MenuVariables.Current), A

@SetOption.NotUpdate
                ; расчёт информации о опции
                CALL GetCoordOption
                INC HL
                LD (UpdateTextVFX.Coord), DE

.AnyText        ; копирование текста в буфер
                SCF                                                             ; первичное отображение
                EX AF, AF'
                LD A, (HL)
                CALL Functions.TextToBuffer
Suboptions:     ; проверка адреса и переход если он установлен
                LD HL, (MenuVariables.SuboptionsFunc)
                LD A, H
                OR L
                JR Z, SetLength

                LD BC, SetLength
                PUSH BC
                JP (HL)
SetLength:      ; округление длины текста до знакоместа
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
GetCoordOption: ; расчёт информации о опции
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
                RET
@SelectHandler: ; подготовка смены рандомных VFX
                LD HL, NextTextVFX
                LD (IY + FTVFX.VFX_Complited), HL
                ; отрисовка меню
                LD HL, (MenuVariables.Options)
                LD A, (HL)
                CALL SetOption

                ; включить отображение курсора
                LD HL, MenuVariables.Flags
                SET DRAW_CURSOR_BIT, (HL)

                LD A, #01                                                       ; длительности первого фрейма
                CALL SetDefaultVFX                                              ; установка эффекта
                
.Loop           HALT

                ; проверка флага смены меню
                LD HL, MenuVariables.Flags
                BIT CHANGE_BIT, (HL)
                CALL NZ, OnChange

                ; проверка флага выбора меню
                LD HL, MenuVariables.Flags
                BIT SELECT_BIT, (HL)
                CALL NZ, OnSelect

                ; обработка ввода
                LD DE, InputDefault
                CALL Input.JumpDefaulKeys
                JR .Loop

@RNDTextVFX:    CALL Math.Rand8
                JP NextTextVFX.SetVFX

NextTextVFX:    ; ожидание применения следующего эффекта
.WaitNextVFX    EQU $+1
                LD A, #01
                DEC A
                JR NZ, .SetWait

                ; генерация эффекта/время до следующего эффекта
                CALL Math.Rand8
                CP #3F                                                          ; чем меньше тем реже происходит смена эффекта
                JR NC, .Wait

.SetVFX         ; генерация эффекта
                AND #03
                INC A                                                           ; пропуск дефолтного эффекта
                LD C, A                                                         ; номер эффекта
                LD A, #01
                JP SetVFX_Custom                                                ; установка эффекта

.Wait           ; округление 
                LD B, #00
                RRA
                ADC A, B
                RRA
                ADC A, B
                RRA
                ADC A, B
                RRA
                ADC A, B
                INC A
.SetWait        LD (.WaitNextVFX), A
                LD A, #01
@SetDefaultVFX: LD C, VFX_DEFAULT                                               ; номер эффекта
                JP SetVFX_Custom                                                ; установка эффекта

OnChange:       ; проверка флага VFX_PLAYING
                BIT VFX_PLAYING_BIT, (IY + FTVFX.Flags)
                RET NZ

                ; сброс флага VFX_PLAYING
                RES VFX_PLAYING_BIT, (IY + FTVFX.Flags)

                ; проверка отсутсвие флага необходимости обновить курсор
                BIT DRAW_CURSOR_BIT, (HL)
                RET NZ
    
                ; сброс флага запроса смены
                RES CHANGE_BIT, (HL)

                ; становка нового выбранного меню
                DEC HL
                LD A, (HL)
                CALL SetOption

                ; проиграть при переходе новый эффект
                CALL RNDTextVFX

                ; установка флага перерисовка курсора
                LD HL, MenuVariables.Flags
                SET DRAW_CURSOR_BIT, (HL)

                LD HL, MenuVariables.Changed
                JR Jump

OnSelect:       ; проверка флага VFX_PLAYING
                BIT VFX_PLAYING_BIT, (IY + FTVFX.Flags)
                RET NZ

                ; сброс флага выбора
                RES SELECT_BIT, (HL)

                ; сброс флага VFX_PLAYING
                RES VFX_PLAYING_BIT, (IY + FTVFX.Flags)

                ; проверка доступности выбора опции
                LD HL, .Continue
                PUSH HL

                LD HL, MenuVariables.CanSelected
                JR Jump

.Continue       RET C

                ; обновить опцию перед fadeout'ом
                LD A, #01
                LD C, VFX_FADEOUT                                               ; номер эффекта
                CALL SetVFX_Custom

                ; сброс функции обработчика подменю
                LD HL, (MenuVariables.SuboptionsFunc)
                PUSH HL
                LD HL, #0000
                LD (MenuVariables.SuboptionsFunc), HL
                CALL RefreshCurrentOption
                POP HL
                LD (MenuVariables.SuboptionsFunc), HL
                
                LD HL, MenuVariables.Selected
Jump:           LD E, (HL)
                INC HL
                LD D, (HL)
                EX DE, HL
                JP (HL)

@CanBeSelected: OR A
                RET
@CantBeSelected SCF
                RET

@ResetOptions:  ; инициализация VFX (эффект faidin)
                LD IY, VariablesVFX
                LD HL, UpdateTextVFX
                LD (IY + FTVFX.FrameComplited), HL
                LD HL, FadeinNextText
                LD (IY + FTVFX.VFX_Complited), HL

                ; инициализация меню
                XOR A
                LD (MenuVariables.OptionsMin), A
                LD (MenuVariables.Current), A
                LD (MenuVariables.Flags), A
                LD (MenuVariables.AddFlags), A
                
                ; ; сброс функции обработчика подменю
                LD HL, #0000
                LD (MenuVariables.SuboptionsFunc), HL

                ; включить отображение курсора
                LD HL, MenuVariables.Flags
                RES DRAW_CURSOR_BIT, (HL)

                ; установка дефолтного эффекта
                LD A, #01                                                       ; длительности первого фрейма
                JP SetDefaultVFX                                                ; установка эффекта

; HL - адрес массива опций
@SetFirstOption LD A, (HL)
                LD (MenuVariables.OptionsMax), A
                CALL SetOption
                CALL SetFadeinVFX

                SetUserHendler INT_Handler
                RET

; ожидание события завершений Faidout'а
; A - на входе номер выбранного меню
@WaitEvent:     ; удалить из стека адрес выхода
                HALT
                POP HL
                EX (SP), HL

                ; подготовка экрана 1
                SET_SCREEN_BASE
                CLS_C000
                ATTR_C000_IPB RED, BLACK, 1

                ; подготовка экрана 2
                SET_SCREEN_SHADOW
                CLS_C000
                ATTR_C000_IPB RED, BLACK, 0

                CALL WaitEventVFX
                OffUserHendler

                LD A, (MenuVariables.Current)

                RET

@WaitEventVFX:  PUSH HL

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

; ожидание завершения VFX
@WaitVFX:       HALT
                BIT VFX_PLAYING_BIT, (IY + FTVFX.Flags)
                JP Z, WaitVFX
                RET
    
                display " - Core : \t\t\t", /A, UpdateTextVFX, " = busy [ ", /D, $ - UpdateTextVFX, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_CORE_
