
                ifndef _CORE_MODULE_DRAW_SPRITE_UNIT_DRAW_SPRITE_
                define _CORE_MODULE_DRAW_SPRITE_UNIT_DRAW_SPRITE_
; -----------------------------------------
; отображение спрайта без атрибутов
; In:
; BC  - размер спрайта (B - изначальная/изменённая ширина, C - изначальная/изменённая высота) в пикселях
; HL' - адрес экрана вывода
; DE' - изначальный/изменённый адрес спрайта
; В'  - старший байт адреса таблицы сдвига
; С'  - количество пропускаемых байт, для спрайтов с общей маской
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

                LD IX, Kernel.Function.NoShift_OX_4
                LD IY, Kernel.Function.NoShift_OX_4

                CALL Memcpy.Sprite                                              ; копирование спрайта в буфер
                SET_PAGE_SHADOW_SCREEN                                          ; установка страницы не видимого экрана

                POP BC                                                          ; восстановление размера спрайта
                POP DE                                                          ; восстановление адреса экрана
                
                ; защитная от порчи данных с разрешённым прерыванием
                RestoreBC
                LD (.ContainerSP), SP
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

.Exit           ;
.ContainerSP    EQU $+1
                LD SP, #0000

                RET

                display " - Draw Sprite: \t\t\t", /A, Draw, " = busy [ ", /D, $ - Draw, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_SPRITE_UNIT_DRAW_SPRITE_
