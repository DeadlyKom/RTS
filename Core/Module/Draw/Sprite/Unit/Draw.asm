
                ifndef _CORE_MODULE_DRAW_SPRITE_UNIT_DRAW_SPRITE_
                define _CORE_MODULE_DRAW_SPRITE_UNIT_DRAW_SPRITE_
; -----------------------------------------
; отображение спрайта без атрибутов
; In:
; BC  - размер спрайта (B - изначальная ширина, C - изначальная/изменённая высота) в пикселях
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
                PUSH DE
                EX DE, HL
                LD H, B                                                         ; перенос старшего байт адреса таблицы сдвига
                LD B, #00                                                       ; BC хранит количество пропускаемых байт, для спрайтов с общей маской
                EXX
                POP DE

                CALL Memcpy.Sprite                                              ; копирование спрайта в буфер
                CALL Screen.PageToC000_                                             ; установка страницы не видимого экрана

                RET

                display " - Draw Sprite: \t\t\t", /A, Draw, " = busy [ ", /D, $ - Draw, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_SPRITE_UNIT_DRAW_SPRITE_
