
                ifndef _CORE_MODULE_DRAW_SPRITE_UNIT_DRAW_SPRITE_
                define _CORE_MODULE_DRAW_SPRITE_UNIT_DRAW_SPRITE_
; -----------------------------------------
; отображение спрайта без атрибутов
; In:
;   BC  - размер спрайта (B - изначальная ширина, C - изначальная/изменённая высота) в пикселях
;   HL' - адрес экрана вывода
;   DE' - изначальный/изменённый адрес спрайта
;   В'  - старший байт адреса таблицы сдвига
;   С'  - количество пропускаемых байт, для спрайтов с общей маской
;   IX  - функция прохода
;   IY  - функция возврата
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Draw:           ; подготовка
                EXX
                PUSH HL                                                         ; сохранение адреса экрана
                PUSH DE
                LD H, B                                                         ; перенос старшего байт адреса таблицы сдвига
                LD B, #00                                                       ; BC хранит количество пропускаемых байт, для спрайтов с общей маской
                EXX
                POP DE
                PUSH BC                                                         ; сохранение размера спрайта

                CALL Memcpy.Sprite                                              ; копирование спрайта в буфер
                SET_PAGE_SHADOW_SCREEN                                          ; установка страницы не видимого экрана

                LD DE, Dirty                                                    ; авто помечание испорченных тайлов
                POP BC                                                          ; восстановление размера спрайта
                LD (Dirty.SpriteSize), BC                                       ; сохранение размера спрайта
                EX DE, HL
                EX (SP), HL                                                     ; восстановление адреса экрана
                LD (Dirty.Screen), HL                                           ; сохранение адреса экрана
                EX DE, HL

                ; защитная от порчи данных с разрешённым прерыванием
                RestoreBC
                LD (Kernel.Function.Exit.ContainerSP), SP
                LD SP, HL

                ; подготовка вывода
                LD L, E
                LD A, #F8
                AND D
                LD H, A
                SUB D
                ADD A, #08
                LD B, A
                JP (IX)                                                         ; отобращение спрайта
Dirty:

                ; ToDo
                ; возможно не требует обновление спрайтов, после скролла карты
                ; на 2 фрейма

                ; -----------------------------------------
                ; автоматический расчёт и отметка грязных тайлов
                ; -----------------------------------------
.Screen         EQU $+1
                LD HL, #0000                                                    ; адреса экрана
.SpriteSize     EQU $+1
                LD BC, #0000                                                    ; размера спрайта

                ; корректировка высоты, если спрайт не выровнен знакоместу по вертикали     (точная)
                LD A, H
                AND #07
                XOR L
                AND %11011111
                XOR L
                JR Z, $+12
                LD A, C
                INC C
                AND #0F
                JR Z, $+6
                LD A, C
                ADD A, #0F
                LD C, A

                ; корректировка высоты, если спрайт не выровнен знакоместу по горизонтали   (грубая)
                LD A, B
                INC B
                AND #0F
                JR Z, $+6
                LD A, B
                ADD A, #0F
                LD B, A

                ; расчёт адреса буфера рендера
                LD A, L
                RRA
                LD E, A
                RRA
                XOR E
                AND %00110000
                XOR E
                LD E, A
                LD A, H
                ADD A, A
                ADD A, A
                ADD A, A
                XOR E
                AND %11000000
                XOR E
                LD L, A
                LD H, HIGH RenderBuffer

                ; инициализация
                LD D, #00       

                ; округление до знакоместа ширины спрайта
                LD A, B
                RRA
                ADC A, D
                RRA
                ADC A, D
                RRA
                ADC A, D
                RRA
                ADC A, D
                LD B, A

                ; округление до знакоместа высоты спрайта
                LD A, C
                RRA
                ADC A, D
                RRA
                ADC A, D
                RRA
                ADC A, D
                RRA
                ADC A, D
                LD C, A

                ; инициализация
                LD D, B                                                         ; сохранение ширины

                ; clamp по горизонтали
                LD A, L
                AND #0F
                NEG
                ADD A, #10
                CP B
                JR NC, $+3
                LD B, A

                ; clamp по вертикали
                LD A, L
                RRA
                RRA
                RRA
                RRA
                AND #0F
                NEG
                ADD A, #0C
                CP C
                JR NC, $+3
                LD C, A

.Loop           ; основной цикл отмечания грязных тайлов
                SET FIRST_QUEUE_BIT, (HL)
                INC L
                DJNZ .Loop

                ; переход к следующей строке в рендер буфере
                LD A, L
                SUB D
                ADD A, #10
                LD L, A

                ; переход к следующей строке
                LD B, D
                DEC C
                JR NZ, .Loop

                RET

                display " - Draw Sprite: \t\t\t\t\t", /A, Draw, " = busy [ ", /D, $ - Draw, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_SPRITE_UNIT_DRAW_SPRITE_
