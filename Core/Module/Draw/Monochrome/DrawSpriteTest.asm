
                ifndef _CORE_MODULE_DRAW_MONOCHROME_DRAW_SPRITE_TEST_
                define _CORE_MODULE_DRAW_MONOCHROME_DRAW_SPRITE_TEST_

                module Monochrome
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
DrawSpriteMono: ; инициализация
                LD A, C
                LD (.Width), A
                LD A, B
                LD (.Height), A
                LD A, #DD
                LD (.Jump), A
                LD A, #24
                LD (.INC), A

                ; сохранение текущего стека
                LD (.ContainerSP), SP
                RestoreBC

                ;   DE - координаты в пикселях (D - y, E - x)
                ; Out :
                ;   DE - адрес экрана
                ;   A  - номер бита (CPL)/ смещение от левого края
                CALL PixelAddressP                                              ; DE - адрес экрана
                ; RES 7, D                                                        ; коррекция адреса основного экрана
                JP Z, .NotShift                                                 ; нет смещения
                PUSH DE

                ; -----------------------------------------
                ; защиты данных от повреждение во время прерывания
                ; -----------------------------------------
                ; RestoreBC
                LD C, (HL)
                INC L
                LD B, (HL)
                DEC L
                PUSH BC
                EXX

                POP BC                                                          ; 2 байта спрайта
                POP DE                                                          ; адрес экрана
                ; расчёт таблицы смещения
                DEC A
                ADD A, A
                ADD A, (HIGH ShiftTable)+1
                LD H, A

                EXX
                LD SP, HL

                ; SP  - адрес спрайта
                ; HL  -
                ; BC  - 2 байта спрайта
                ; H'  - старший байт таблицы сдвига
                ; DE' - адрес экрана
                ; BC' - 2 байта спрайта
.NextRow        ;
.Width          EQU $+1
                LD A, #00
.RowLoop        EX AF, AF'
.Jump           EQU $
                JP (IX)
.NextChar       EX AF, AF'
                SUB #08
                JR NC, .RowLoop

.NextPass       ; classic method "DOWN_DE" 25/59
                INC D
                LD A, D
                AND #07
                JP NZ, $+12
                LD A, E
                SUB #E0
                LD E, A
                SBC A, A
                AND #F8
                ADD A, D
                LD D, A

                ;
                LD A, (.Jump)
                XOR %00100000
                LD (.Jump), A

                ;
.INC            EQU $
                INC H
                LD A, (.INC)
                XOR %00000001
                LD (.INC), A

.Height         EQU $+1
                LD A, #00
                DEC A
                LD (.Height), A
                JR NZ, .NextRow

.ContainerSP    EQU $+1
                LD SP, #0000
                RET

.NotShift       RET

                ; SP  - адрес спрайта
                ; HL  -
                ; BC  - 2 байта спрайта
                ; H'  - старший байт таблицы сдвига
                ; DE' - адрес экрана
                ; BC' - 2 байта спрайта
                ; A'  - ширина спрайта
OR_XOR_R_S:     ; левый скип
                EX AF, AF'
                SUB #08
                EX AF, AF'
.SkipChar       EQU $+1
                LD A, #00
                POP BC
                DEC A
                JR NZ, OR_XOR_R_S
                JR OR_XOR_R.ByteR
OR_XOR_R:       ;- левая часть байта -
                LD A, (DE)
                POP BC
                LD L, C     ; OR
                OR (HL)
                LD L, B     ; XOR
                XOR (HL)
                LD (DE), A
                ;~ левая часть байта ~

                LD A, E
                CPL
                AND %00011111
                JR NZ, .SkipRight

                ;
                INC E
                INC H

.ByteR          ;- правая часть байта -
                LD A, (DE)
                LD L, C     ; OR
                OR (HL)
                LD L, B     ; XOR
                XOR (HL)
                LD (DE), A
                ;~ правая часть байта ~

                DEC H
                JP DrawSpriteMono.NextChar

.SkipRight      EX AF, AF'

.SkipRightLoop  POP BC 
                SUB #08
                JR NC, .SkipRightLoop
                ; INC H
                JP DrawSpriteMono.NextPass

OR_XOR_L_S:     ; правый скип
                EX AF, AF'
                SUB #08
                EX AF, AF'
.SkipChar       EQU $+1
                LD A, #00
                POP BC
                DEC A
                JR NZ, OR_XOR_L_S
                JR OR_XOR_L.ByteL

OR_XOR_L:       ;- правая часть байта -
                LD A, (DE)
                POP BC
                LD L, C     ; OR
                OR (HL)
                LD L, B     ; XOR
                XOR (HL)
                LD (DE), A
                ;~ правая часть байта ~

                LD A, E
                AND %00011111
                JR Z, .SkipLeft

                ;
                DEC E
                DEC H

.ByteL          ;- левая часть байта -
                LD A, (DE)
                LD L, C     ; OR
                OR (HL)
                LD L, B     ; XOR
                XOR (HL)
                LD (DE), A
                ;~ левая часть байта ~

                INC H
                JP DrawSpriteMono.NextChar

.SkipLeft       EX AF, AF'

.SkipRightLoop  POP BC 
                SUB #08
                JR NC, .SkipRightLoop
                JP DrawSpriteMono.NextPass

                display " - Draw Sprite Monochrome TEST: \t", /A, DrawSpriteMono, " = busy [ ", /D, $ - DrawSpriteMono, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_MONOCHROME_DRAW_SPRITE_TEST_
