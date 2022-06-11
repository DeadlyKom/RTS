
                ifndef _CORE_MODULE_MENU_CORE_SUBOPTION_
                define _CORE_MODULE_MENU_CORE_SUBOPTION_

; A  - номер меню
; HL - адрес массива подопций
@Suboption:     ; расчёт информации о опции
                LD D, #00
                ADD A, A
                LD E, A
                ADD HL, DE
                LD A, (HL)
                INC HL

                ; копирование текста в буфер
                OR A
                EX AF, AF'
                LD A, (HL)
                JP Functions.TextToBuffer

; вывод подопции кастомного текста
;   A' - если флаг переполнения Carry установлен, первичное отображение
;   иначе в A' хранится смещение
@SuboptionText: ;
                LD A, (HL)
                INC HL
                EX AF, AF'
                LD A, (HL)

                ;
                LD HL, .Buffer
                LD DE, .Buffer+1
                LD BC, .BufferSize - 1
                LD (HL), #01
                LDIR

                ; расчёт адреса сообщения
                LD HL, (LocalizationRef)
                ADD A, A
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H
                LD E, (HL)
                INC HL
                LD D, (HL)
                ADD HL, DE

                ; расчёт длины строки
                XOR A
                LD BC, .BufferSize
                CPIR
                RET NZ

.Found          DEC HL
                DEC HL
                INC C
                LD D, H
                LD E, L
                
                LD A, .BufferSize
                SUB C
                LD C, A
                PUSH BC

                LD A, .BufferSize >> 1
                SRL C
                SUB C
                LD C, A
                OR A

                LD HL, .Buffer + .BufferSize - 1
                SBC HL, BC
                EX DE, HL
                POP BC
                LDDR

                LD HL, .Buffer
                JP Functions.StringToBuffer

.Buffer         DS 20, 0
.BufferSize     EQU 19

; B  - максимальное значение
; DE - указатель на текущую подопцию
@ReqChange:     LD HL, MenuVariables.AddFlags
                LD A, (HL)
                LD (HL), #00
                AND SUBOPTION_CHANGE_MASK

                CP SUBOPTION_LEFT
                JR Z, .Left

                CP SUBOPTION_RIGHT
                JR Z, .Right

                RET

.Left           LD A, (DE)
                CP B
                RET Z

                EX DE, HL
                INC (HL)

                JR .Update

.Right          LD A, (DE)
                OR A
                RET Z

                EX DE, HL
                DEC (HL)

.Update         ; обновление опции "применить", если необходимо
                EX DE, HL
                BIT SUBOPTION_APPLY_BIT, (HL)
                JP Z, RefreshCurrentOption

                ; CALL RefreshMenuText
@RefreshCurrentOption
                LD A, (MenuVariables.Current)
; обновление опции 
; A - номер опции
@RefreshOption: ; выключить отображение курсора
                LD HL, MenuVariables.Flags
                RES DRAW_CURSOR_BIT, (HL)

                LD BC, (UpdateTextVFX.Coord)
                PUSH BC

                CALL SetOption.Transient
                CALL WaitVFX

                POP BC
                LD (UpdateTextVFX.Coord), BC

                RET

                display " - Core Suboption : \t\t", /A, Suboption, " = busy [ ", /D, $ - Suboption, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_CORE_SUBOPTION_
