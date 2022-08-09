
                ifndef _CORE_MODULE_DRAW_TILEMAP_DRAW_ROW_
                define _CORE_MODULE_DRAW_TILEMAP_DRAW_ROW_

                module Tilemap
SkipRender:     ; переход к следующему столбцу
                EXX
                INC E
                INC E

                ; переход к следующей ячейке тайла
                EXX
                INC L                                                           ; next cell of the render buffer
                DJNZ DrawRow.Loop
                RET
; -----------------------------------------
; отрисовка строки тайлов
; In:
;   HL - адрес буфера отображения (RenderBuffer)
; Out:
; Corrupt:
; Note:
; устойчивый к прерываниям
; -----------------------------------------
DrawRow:        ; инициализация
                LD B, SCREEN_TILE_X

.Loop           ; -----------------------------------------
                ; определение необходимости обновление тайла (рендер буфер)
                ; -----------------------------------------

                LD A, (HL)
                ADD A, A
                JR C, SkipRender
                ; RES 7, (HL)
                EX AF, AF'
                
                INC H                                                           ; переход к буферу тайловой карта (TilemapBuffer)
                LD A, (HL)
                EXX

                ; -----------------------------------------
                ; определение видимости тайла (туман войны)
                ; -----------------------------------------
                ADD A, A                                                        ; сдвиг влево (7 бит - туман войны)
                ifdef ENABLE_FOW
                JP C, .NextColumn                                               ; перейти к следующему столбцу, если установлен 7 бит
                endif

                ; -----------------------------------------
                ; расчёт адреса спрайта тайла
                ; -----------------------------------------

                ; расчёт адреса спрайта тайла (без учёта анимации)
                LD H, HIGH Adr.Tilemap.SpriteTable
                LD L, A
                LD C, (HL)
                INC L
                LD H, (HL)

                ; корректировка адреса (для анимации)
                EX AF, AF'
                AND TILE_ANIM_MASK << 1
                ADD A, C
                LD L, A
                JR NC, $+3
                INC H

                ; -----------------------------------------
                ; защита от повреждения данных во время прерывания
                ; -----------------------------------------

                ; копирование данных 2-х байт спрайта
                LD C, (HL)
                INC L
                LD B, (HL)
                INC L

                ; инициализация стека, указывает на спрайт тайла
                LD SP, HL

                ; HL - хранит экранный адрес вывода
                LD H, D
                LD L, E

                ; -----------------------------------------
                ; отрисовка верхней части спрайта
                ; -----------------------------------------
                LD (HL), C
                INC L
                LD (HL), B
                INC H
                POP BC
                LD (HL), B
                DEC L
                LD (HL), C
                INC H
                rept 2
                POP BC
                LD (HL), C
                INC L
                LD (HL), B
                INC H
                POP BC
                LD (HL), B
                DEC L
                LD (HL), C
                INC H
                endr

                POP BC
                LD (HL), C
                INC L
                LD (HL), B
                INC H
                POP BC
                LD (HL), B
                DEC L
                LD (HL), C

                ; переход к нижней части спрайта
                SET 5, L

                ; -----------------------------------------
                ; отрисовка нижней части спрайта
                ; -----------------------------------------
                rept 3
                POP BC
                LD (HL), C
                INC L
                LD (HL), B
                DEC H
                POP BC
                LD (HL), B
                DEC L
                LD (HL), C
                DEC H
                endr
                POP BC
                LD (HL), C
                INC L
                LD (HL), B
                DEC H
                POP BC
                LD (HL), B
                DEC L
                LD (HL), C

.ContainerSP    EQU $+1
                LD SP, #0000

.NextColumn     ; переход к следующему столбцу
                INC E
                INC E

                ; переход к следующей ячейке тайла
                EXX
                DEC H                                                           ; переход к буферу рендера (RenderBuffer)
                INC L   

                DJNZ .Loop
                RET

                display " - Draw Row: \t\t\t", /A, SkipRender, " = busy [ ", /D, $ - SkipRender, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_TILEMAP_DRAW_ROWS_
