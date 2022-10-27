
                ifndef _CORE_MODULE_DRAW_SPRITE_DRAW_
                define _CORE_MODULE_DRAW_SPRITE_DRAW_
; -----------------------------------------
; отрисовка спрайта попиксельно
; In:
;   HL - адрес спрайта
;   DE - координаты (D - y, E - x)
;        x в знакоместах (-4 до 31)
;        y в пикселях    (-32 до 191)
;   BC - размер спрайта в пикселях (B - y, C - x)
;   A  - младшие 3 бита смещение
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawSprite:     ; инициализация
                EX AF, AF'                                                      ; сохранить смещение
                LD A, (MemoryPageRef)
                LD (GameVar.RestorePage), A

.ClipVertical   ; -----------------------------------------
                ; вертикальный клипинг
                ; -----------------------------------------

                LD A, D
                CP SCREEN_PIXEL_Y
                JR C, .ClipBottom

                ; верхняя часть спрайта за экраном
                NEG
                CP B
                RET NC                                                          ; вне экрана

                ; корректируем адрес начала спрайта
                PUSH AF
                PUSH BC
                LD C, A
                XOR A
                ADD A, C
                DJNZ $-1
                ADD A, A                                                        ; спрайт с маской

                ; добавить смещение к спрайту
                ADD A, L
                LD L, A
                ADC A, H
                SUB L
                LD H, A

                ; корректировка позиции по вертикали
                LD D, B

                POP BC
                POP AF

                ; корректируем размер спрайта
                SUB B
                NEG
                LD B, A
                JR .Prepare

.ClipBottom     SUB SCREEN_PIXEL_Y
                NEG
                CP B
                JR NC, $+3
                LD B, A

.Prepare        ; -----------------------------------------
                ; расчёт адреса строки в экранной области
                ; -----------------------------------------
                PUSH HL
                LD A, D
                EXX
                LD H, HIGH Table.ScreenAddress
                LD L, A
                LD E, (HL)
                INC H
                LD D, (HL)
                POP HL
                EXX

                ; -----------------------------------------
                ; определение функции вывода
                ; -----------------------------------------
                LD HL, Table.NoShiftOXRFunc-2
                EX AF, AF'                                                      ; восстановление смещение
                OR A
                JR Z, .IsNotShift

                ; -----------------------------------------
                ; расчёт адреса таблицы смещения
                ; -----------------------------------------
                EXX
                DEC A
                ADD A, A
                ADD A, HIGH Table.Shift
                LD B, A
                EXX

                ; смещение таблицы
                LD A, #08
                ADD A, L
                LD L, A
                ADC A, H
                SUB L
                LD H, A

                ; корректировка (+1 знакоместо, т.к. сдвинут)
                LD A, C
                ADD A, #08
                LD C, A

.IsNotShift     ; ---------------------------------------------
                ;   HL  - адрес таблицы функций сдвига/без сдвига
                ;   DE  - координаты (D - y, E - x)
                ;        x в знакоместах (-4 до 31)
                ;        y в пикселях    (-32 до 191)
                ;   BC  - размер спрайта в пикселях (B - y (изменённая), C - x)
                ;   HL' - изначальный/изменённый адрес спрайта
                ;   DE' - адрес экрана вывода
                ;   B'  - старший байт адреса таблицы сдвига
                ; ---------------------------------------------

                ; округление ширины спрайта до знакоместа
                OR A
                LD A, C
                LD C, #00
                RRA
                ADC A, C
                RRA
                ADC A, C
                RRA
                ADC A, C
                LD C, A

                ; смещение в таблице по ширине спрайта
                ADD A, A
                ADD A, L
                LD L, A
                ADC A, H
                SUB L
                LD H, A
                LD A, (HL)
                INC HL
                LD H, (HL)
                LD L, A

.ClipRow        ; ---------------------------------------------
                ; горизонтальный клипинг
                ; ---------------------------------------------
                ;   HL  - адрес таблицы функций сдвига/без сдвига
                ;   DE  - координаты (D - y, E - x)
                ;        x в знакоместах (-4 до 31)
                ;        y в пикселях    (-32 до 191)
                ;   BC  - размер спрайта в пикселях (B - y (изменённая), C - x (в знакоместах))
                ;   HL' - изначальный/изменённый адрес спрайта
                ;   DE' - адрес экрана вывода
                ;   B'  - старший байт адреса таблицы сдвига
                ; ---------------------------------------------

                LD A, E
                CP SCREEN_CHAR_X
                JR C, .ClipRight

.ClipLeft       ; ---------------------------------------------
                ; спрайт расположен левого края экрана
                ; ---------------------------------------------
                ADD A, C
                RET Z                                                           ; выход, если спрайт расположен на границе левого края экрана
                CP SCREEN_CHAR_X
                RET NC                                                          ; выход, если спрайт расположен полностью левее края экрана
                NEG
                ADD A, C
                LD C, A

                ; смещение адреса внутри таблицы
                LD A, E
                NEG
                ADD A, A
                ADD A, A
                LD E, A
                LD A, L
                SUB E
                LD L, A
                JR NC, $+3
                DEC H
                JR .Func

.ClipRight      ; ---------------------------------------------
                ; спрайт расположен правее края экрана
                ; ---------------------------------------------
                ADD A, C
                CP SCREEN_CHAR_X+1
                JR C, .AdjustScrAdr                                             ; спрайт виден полностью

                ; спрайт обрезан правой частью экрана
                SUB SCREEN_CHAR_X

                ; расчёт размера видимой части спрайта в знакоместах
                PUSH AF
                NEG
                ADD A, C
                LD C, A
                POP AF

                ; смещение в таблице
                ADD A, A
                ADD A, A
                ADD A, L
                LD L, A
                ADC A, H
                SUB L
                LD H, A

.AdjustScrAdr   ; корректировка адреса колонки в экранной области
                LD A, E
                EXX
                OR E
                LD E, A
                EXX

.Func           ; чтение адресов из таблицы переходов
                LD A, (HL)
                LD IXL, A
                INC HL
                LD A, (HL)
                LD IXH, A
                INC HL

                ;
                LD A, (HL)
                LD IYL, A
                INC HL
                LD A, (HL)
                LD IYH, A

                ; ---------------------------------------------
                ; горизонтальный клипинг
                ; ---------------------------------------------
                ;   BC  - размер обрезанного спрайта в пикселях (B - y (изменённая), C - x (изменённая в знакоместах))
                ;   HL' - изначальный/изменённый адрес спрайта
                ;   DE' - адрес экрана вывода
                ;   B'  - старший байт адреса таблицы сдвига
                ;   IX  - функция прохода
                ;   IY  - функция возврата
                ; ---------------------------------------------

                LD HL, (Kernel.Function.Exit.ContainerSP)
                PUSH HL
                LD HL, .RestoreSP
                PUSH HL

                EXX
                LD (GameVar.RestoreScr), DE
                PUSH DE
                EXX
                LD (GameVar.RestoreSize), BC
                POP HL

                ; защитная от порчи данных с разрешённым прерыванием
                EXX
                RestoreBC
                LD (Kernel.Function.Exit.ContainerSP), SP
                LD SP, HL
                LD DE, CursorBuf
                LD H, B
                EXX

                ; подготовка вывода
                LD D, H
                LD E, L
                LD A, #F8
                AND D
                LD H, A
                SUB D
                ADD A, #08
                LD C, B
                LD B, A
                JP (IX)                                                         ; отобращение спрайта

.RestoreSP      POP HL
                LD (Kernel.Function.Exit.ContainerSP), HL
                RET

                display " - Draw Sprite by Pixels : \t\t\t\t", /A, DrawSprite, " = busy [ ", /D, $ - DrawSprite, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_SPRITE_DRAW_
