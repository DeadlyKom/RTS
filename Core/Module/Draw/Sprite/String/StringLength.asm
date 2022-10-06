
                ifndef _CORE_MODULE_DRAW_STRING_LENGTH_
                define _CORE_MODULE_DRAW_STRING_LENGTH_

                module Monochrome
; -----------------------------------------
; длина строки 
; In:
;   HL - адрес строки
; Out:
;   B  - длина строки в пикселях (округлён по знакоместа)
; Corrupt:
; Note:
; -----------------------------------------
StringLength:   LD B, #00

.StringLoop     LD A, (HL)
                OR A
                JR NZ, .Next

                LD A, B
                SRL A
                NEG
                ADD A, C
                LD C, A

                ; округление
                LD A, B
                LD B, #00
                RRA
                ADC A, B
                RRA
                ADC A, B
                RRA
                ADC A, B
                AND %00011111
                LD B, A
                RET

.Next           DEC A

                INC HL
                PUSH HL

.AddChar        ; расчёт адреса спрайта символа
                LD E, A
                ADD A, A
                LD L, A
                LD H, #00
                LD D, H
                ADD HL, DE
                LD DE, ASCII_Info
                ADD HL, DE

                ; чтение данных о символе
                LD A, (HL)                                                      ; size (height/width)
                AND #0F
                ADD A, B
                INC A
                LD B, A
                POP HL
                JR .StringLoop

; -----------------------------------------
; длина слова в строке (в пикселях)
; In:
;   HL - адрес строки
;   A' - смещение в строке
; Out:
;   HL - длина слова (в символах)
;   DE - длина слова в строке (в пикселях)
; Corrupt:
; Note:
; -----------------------------------------
WordLength:     ; инициализация
                XOR A
                LD E, A
                LD D, A

                ; добавление смещение к строке
                EX AF, AF'
                LD C, A
                LD B, D
                ADD HL, BC
                PUSH HL

.StringLoop     ; чтение символа
                LD A, (HL)
                OR A
                JR Z, .Exit                                                     ; выход, если конец строки

                PUSH HL

                DEC A
                PUSH AF                                                         ; сохранение флага нуля (если символ пробел, флаг выставлен)

                ; расчёт адреса спрайта символа
                LD C, A
                ADD A, A
                LD L, A
                LD H, D
                LD B, D
                ADD HL, BC
                LD BC, ASCII_Info
                ADD HL, BC

                ; чтение данных о символе
                LD A, (HL)                                                      ; size (height/width)
                AND #0F
                INC A
                ADD A, E
                LD E, A

                POP AF                                                          ; востановление флага нуля (если символ пробел, флаг выставлен)
                POP HL
                INC HL
                JR NZ, .StringLoop
.Exit           ;
                POP BC
                OR A
                SBC HL, BC
                RET

                display " - String Length : \t\t\t\t\t", /A, StringLength, " = busy [ ", /D, $ - StringLength, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_STRING_LENGTH_
