
                ifndef _CORE_MODULE_DRAW_MONOCHROME_DRAW_SPRITE_
                define _CORE_MODULE_DRAW_MONOCHROME_DRAW_SPRITE_

                module Monochrome
; -----------------------------------------
; отрисовка спрайта без атрибутами (OR & XOR)
; In:
;   HL - адрес спрайта
;   DE - координаты в пикселях (D - y, E - x)
;   BC - размер (B - y, C - x)
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawSpriteOR:   ; -----------------------------------------
                ; инициализация
                ; ----------------------------------------
                EXX
                LD HL, Shift_OR
                LD (DrawSpriteMono.Shift), HL
                LD HL, NotShift_OR
                LD (DrawSpriteMono.NotShift), HL
                EXX
                JR DrawSpriteMono
; -----------------------------------------
; отрисовка спрайта без атрибутами (OR)
; In:
;   HL - адрес спрайта
;   DE - координаты в пикселях (D - y, E - x)
;   BC - размер (B - y, C - x)
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawSpriteORXOR:; -----------------------------------------
                ; инициализация
                ; ---------------------------------------- 
                EXX
                LD HL, Shift_OR_XOR
                LD (DrawSpriteMono.Shift), HL
                LD HL, NotShift_OR_XOR
                LD (DrawSpriteMono.NotShift), HL
                EXX
                JR DrawSpriteMono
; -----------------------------------------
; отрисовка спрайта без атрибутами
; In:
;   HL - адрес спрайта
;   DE - координаты в пикселях (D - y, E - x)
;   BC - размер (B - y, C - x)
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawSpriteMono: ; -----------------------------------------
                ; расчёт счётчика по горизонтали
                ; -----------------------------------------
                ; округление ширины до знакоместа
                LD A, C
                LD C, #00
                RRA
                ADC A, C
                RRA
                ADC A, C
                RRA
                ADC A, C
                DEC A
                LD C, A
                
                ; -----------------------------------------
                ; расчёт адреса экрана
                ; -----------------------------------------
                PUSH DE
                EXX
                POP DE
                ;   DE - координаты в пикселях (D - y, E - x)
                ; Out :
                ;   DE - адрес экрана
                ;   A  - номер бита (CPL)/ смещение от левого края
                CALL PixelAddressP                                              ; DE - адрес экрана
                LD C, E                                                         ; сохранение смещения по горизонтали
                RES 7, D                                                        ; коррекция адреса основного экрана

                ; -----------------------------------------
                ; определение функтора вывода
                ; -----------------------------------------
                EXX
.Shift          EQU $+1
                LD DE, #0000
                JR NZ, .IsShift
.NotShift       EQU $+1
                LD DE, #0000
.IsShift        EXX

                ; -----------------------------------------
                ; расчёт адреса таблицы смещения
                ; -----------------------------------------
                DEC A
                ADD A, A
                ADD A, HIGH Table.Shift
                LD H, A
                EXX

.ColumLoop      ; -----------------------------------------
                LD A, C
.RowLoop        ; -----------------------------------------
                EX AF, AF'
                LD A, (HL)
                INC HL
                EX DE, HL
                JP (HL)
.Continue       EXX
                
                EX AF, AF'
                DEC A
                JP P, .RowLoop

.NextRow        ; -----------------------------------------
                EXX
                LD E, C                                                         ; востановление смещения по горизонтали

                ; -----------------------------------------
                ; classic method "DOWN_DE" 25/59
                ; -----------------------------------------
                INC D
                LD A, D
                AND #07
                JP NZ, $+13
                LD A, E
                SUB #E0
                LD E, A
                LD C, A                                                         ; сохранение смещения по горизонтали
                SBC A, A
                AND #F8
                ADD A, D
                LD D, A

                EXX
                DJNZ .ColumLoop

                RET
Shift_OR:       EX DE, HL
                EXX
                LD L, A
                LD A, (DE)
                OR (HL)
                LD (DE), A

                INC H
                INC E

                LD A, (DE)
                OR (HL)
                LD (DE), A
                
                DEC H
                JP DrawSpriteMono.Continue
NotShift_OR:    EX DE, HL
                EXX
                LD L, A
                LD A, (DE)
                OR L
                LD (DE), A

                INC E
                JP DrawSpriteMono.Continue
Shift_OR_XOR:   EX DE, HL
                EXX
                LD L, A
                LD A, (DE)
                OR (HL)
                LD B, A
                EXX
                LD A, (HL)
                INC HL
                EXX

                PUSH DE

                ; A (xor), L (or), B (value)
                LD E, A
                LD A, B
                LD B, L
                LD L, E
                ; A (value), L (xor), B (or)

                POP DE

                XOR (HL)
                LD (DE), A

                ; swap L (xor) and B (or)
                LD A, L
                LD L, B
                LD B, A

                INC H
                INC E

                LD A, (DE)
                OR (HL)
                LD L, B
                XOR (HL)
                LD (DE), A
                
                DEC H
                JP DrawSpriteMono.Continue
NotShift_OR_XOR: 
                EX DE, HL
                EXX
                LD L, A
                LD A, (DE)
                OR L
                LD L, A
                EXX
                LD A, (HL)
                INC HL
                EXX
                XOR L
                LD (DE), A

                INC E
                JP DrawSpriteMono.Continue

                display " - Draw Sprite Monochrome: \t\t", /A, DrawSpriteMono, " = busy [ ", /D, $ - DrawSpriteMono, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_MONOCHROME_DRAW_SPRITE_
