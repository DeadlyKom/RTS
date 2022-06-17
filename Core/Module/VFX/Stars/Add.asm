
                ifndef _CORE_MODULE_MENU_MAIN_SCREENSAVER_STARS_ADD_
                define _CORE_MODULE_MENU_MAIN_SCREENSAVER_STARS_ADD_
; -----------------------------------------
; добавление звезды в массив
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Add:            PUSH BC
                
                ; расчёт адреса в массиве
                LD HL, StarCounter
                LD E, (HL)
                INC (HL)
                LD D, #00
                LD B, D
                LD C, E
                EX DE, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, BC
                LD DE, StarsArray
                ADD HL, DE

                POP BC

; -----------------------------------------
; генерация звезды
; In:
;   HL - адрес элемента в массиве
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Generate:       ; генерация скорости звезды
                EXX
                CALL Math.Rand8
                LD D, A
                LD E, #AA
                CALL Math.Div8x8
                EXX
                ADD A, #55
                ; JR NC, .Less

;                 ; установка максимального значения
;                 SBC A, A
.Less           LD (HL), A
                INC HL

                ; позиция звезды по горизонтали
                XOR A
                LD (HL), A
                INC HL
                LD (HL), A

                LD A, (StarFlags)
                ADD A, A
                JR NC, .SkipRND_X
                EXX
                CALL Math.Rand8
                CPL
                EXX
                LD (HL), A

.SkipRND_X      INC HL

                ; генерация позиция звезды по вертикали
                EXX
.Generate       CALL Math.Rand8

                LD C, #01

                EX AF, AF'
                LD A, (StarFlags)
                BIT STAR_CLS_BIT, A
                JR Z, .LLL1
                LD C, #00
.LLL1           EX AF, AF'

                OR C
                CP 191
                JR NC, .Generate

                LD H, HIGH SharedBuffer
                LD L, A

                SLA (HL)
                JR C, .Generate

                LD (HL), #FF
                EXX

                LD D, A
                LD E, #00
                CALL PixelAddressP
                RES 7, D

                LD (HL), E
                INC HL
                LD (HL), D
                INC HL

                RET

                endif ; ~ _CORE_MODULE_MENU_MAIN_SCREENSAVER_STARS_ADD_
