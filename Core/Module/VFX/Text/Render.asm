
                ifndef _CORE_MODULE_VFX_TEXT_RENDER_
                define _CORE_MODULE_VFX_TEXT_RENDER_
@ClearVFX:      CALL PixelAddressC                                              ; DE - адрес экрана
                EX DE, HL

                LD B, #08                                                       ; высота в пикселах
                LD C, (IY + FTVFX.Length)                                       ; ширина в знакоместах
.ColumLoop      LD A, C

.Loop           LD (HL), #00
                RES 7, H
                LD (HL), #00
                SET 7, H
                INC L
                DEC A
                JR NZ, .Loop

                ; следующая строка экрана
                INC H

                ; переход к началу
                LD A, L
                SUB C
                LD L, A

                DJNZ .ColumLoop
                RET

; -----------------------------------------
; скролл текста
; In:
;   SharedBuffer - изображение
;   DE - координаты в знакоместах (D - y, E - x)
;   IY - указывает на структуру FTextVFX
; Out:
; Corrupt:
; Note:
; -----------------------------------------
@RenderVFX:     CALL PixelAddressC                                             ; DE - адрес экрана

                LD B, #08                                                       ; высота в пикселах
                LD C, (IY + FTVFX.Length)                                       ; ширина в знакоместах
                LD HL, SharedBuffer

                EXX
                LD HL, (IY + FTVFX.Shader)
                LD DE, .TMP
                EXX
                
.ColumLoop      ; отображение на теневом экране
                OR A                                                            ; сброс флага переполнения (для сдвиговых операций)
                CALL Shader_L

                ; отображение на первом экране
                RES 7, D
                OR A                                                            ; сброс флага переполнения (для сдвиговых операций)
                CALL Shader_R
                SET 7, D

                ; следующая строка экрана
                INC D

                ; следующая строка буфера
                LD A, L
                ADD A, #20
                LD L, A

                DJNZ .ColumLoop

                EXX
                LD (IY + FTVFX.Shader), HL
                EXX

                RET
.TMP            DB #00

                ; 0 - отсутствие изменений (применения ранее установленные занчения)
                ; 1 - отсутствие модификации изображения (NOP)
                ; 2 - RRA (х1)
                ; 3 - RRA (х2)
                ; 4 - RLA (х1)
                ; 5 - RLA (х2)
                ; 6 - AND + 1 байт значение
                ; 7 - OR  + 1 байт значение
                ; 8 - XOR + 1 байт значение
Shader_L:       EXX
                LD A, (HL)
                LD (DE), A
                INC HL
                EXX
Shader_R:       EXX
                EX DE, HL
                XOR A
                RLD
                EX DE, HL
                EXX
                ADD A, A
                ADD A, A
                LD (.Jump), A
.Jump           EQU $+1
                JR $

.Table          ; 0 - отсутствие изменений (применения ранее установленные занчения)
                JP ApplyVFX.Old
                NOP

                ; 1 - отсутствие модификации изображения (NOP)
                JP MOVE
                NOP

                ; 2 - RRA (х1)
                JP RRA_x1
                NOP

                ; 3 - RRA (х2)
                JP RRA_x2
                NOP

                ; 4 - RLA (х1)
                JP RLA_x1
                NOP

                ; 5 - RLA (х2)
                JP RLA_x2
                NOP

                ; 6 - AND + 1 байт значение
                JP AND_Value
                NOP

                ; 7 - OR  + 1 байт значение
                JP OR_Value
                NOP

                ; 8 - XOR + 1 байт значение
                JP XOR_Value
                NOP

                ; HL - адрес начала линии (shared buffer)
                ; DE - адрес экрана
                ; BC - размеры в знакоместах B - y, C - x
ApplyVFX:       LD (.Operator), BC
                EXX
.Old            EX AF, AF'
                LD A, C
.Loop           EX AF, AF'
                LD A, (HL)
.Operator       EQU $
                NOP
                NOP
                LD (DE), A
                INC E
                INC L
                EX AF, AF'
                DEC A
                JR NZ, .Loop

                ; переход к началу
                LD A, L
                SUB C
                LD L, A

                LD A, E
                SUB C
                LD E, A

                RET

MOVE:           EXX                                                             ; NOP
                LD BC, #0000
                JP ApplyVFX
RLA_x1:         ; переход к концу                                               ; RLA x1
                EX AF, AF'
                
                LD A, L
                ADD A, C
                DEC A
                LD L, A

                LD A, E
                ADD A, C
                DEC A
                LD E, A

                LD A, C
.Loop           EX AF, AF'
                LD A, (HL)
                RLA
                LD (DE), A
                DEC E
                DEC L
                EX AF, AF'
                DEC A
                JR NZ, .Loop
                INC E
                INC L

                RET
RLA_x2:         CALL RLA_x1                                                     ; RLA x2
                PUSH HL
                LD H, D
                LD L, E
                OR A
                CALL RLA_x1
                POP HL
                RET

RRA_x1:         EXX                                                             ; RRA x1
                LD BC, #001F
                JP ApplyVFX
RRA_x2:         CALL RRA_x1                                                     ; RRA x2
                JP ApplyVFX.Old
AND_Value:      EXX                                                             ; AND n
                LD C, #E6
                LD B, (HL)
                INC HL
                JP ApplyVFX
OR_Value:       EXX                                                             ; OR n
                LD C, #F6
                LD B, (HL)
                INC HL
                JP ApplyVFX
XOR_Value:      EXX                                                             ; XOR n
                LD C, #EE
                LD B, (HL)
                INC HL
                JP ApplyVFX

                endif ; ~ _CORE_MODULE_VFX_TEXT_RENDER_
