
                ifndef _DEBUG_CONSOLE_
                define _DEBUG_CONSOLE_

                module Console
ROM_FONT_ADR    EQU #3D00

; -----------------------------------------
; отображение символа
; In:
;   A  - ASCII номер символа
; Out:
; Corrupt:
;   HL, DE, AF
; Note:
; -----------------------------------------
DrawChar:       ; расчёт адреса символа
                LD HL, ROM_FONT_ADR - 0x100
                LD D, #00

                ; A *= 8
                ADD A, A
                ADD A, A
                RL D
                ADD A, A
                RL D

                ; сложение смещения и адреса
                LD E, A
				ADD HL, DE

                ; адрес экрана
.ScreenAdr      EQU $+1
                LD DE, #0000
                HiddenScreenAdr_ D

                ; вывод на экран
                dup  7
                LD A, (HL)
                LD (DE), A
                INC HL
                INC D
                edup
                LD A, (HL)
                LD (DE), A

                ; преобразование адреса пикселей в адрес атрибутов
                CALL PixelAttribute
                EX DE, HL
.Attribute      EQU $+1
                LD (HL), #00

                ; переход к следующему знакоместу
                LD HL, .ScreenAdr
                INC (HL)

                RET
; -----------------------------------------
; отображение 8-битного значения
; In:
;   A  - 8-битное значение
; Out:
; Corrupt:
;   HL, DE, С, AF
; Note:
; -----------------------------------------
DrawByte:       LD C, A

                ; старший полубайт
                RRCA
                RRCA
                RRCA
                RRCA
                AND #0F

                CP #0A
                CCF
                ADC A, #30
                DAA
                CALL DrawChar

                ; младший полубайт
                LD A, C
                AND #0F
                
                CP #0A
                CCF
                ADC A, #30
                DAA
                CALL DrawChar

                RET

; -----------------------------------------
; установка курсора вывода
; In:
;   DE - координаты в знакоместах (D - y, E - x)
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SetCursor:      CALL PixelAddressC
                LD (DrawChar.ScreenAdr), DE
                RET
; -----------------------------------------
; установка адреса вывода
; In:
;   HL - адрес экрана пикселей
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SetScreenAdr:   LD (DrawChar.ScreenAdr), HL
                RET
; -----------------------------------------
; установка атрибута вывода
; In:
;   A - атрибут вывода
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SetAttribute:   LD (DrawChar.Attribute), A
                RET

                endmodule

                endif ; ~_DEBUG_CONSOLE_
