
                ifndef _DISPLAY_UI_HP_
                define _DISPLAY_UI_HP_

                module HP
; -----------------------------------------
; отрисовка указанного юнита Health Point
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Draw:           ; копирование смещение юнита в тайле
                LD HL, .OffsetByPixel
                LD BC, (IX + FUnit.Offset)
                LD (HL), C
                INC HL
                LD (HL), B

                LD E, (IX + FUnit.Health)                                       ; XP

                ; расчёт адреса необходимого спрайта Health Bar
                LD D, (IX + FUnit.Type)
                BIT COMPOSITE_UNIT_BIT, D
                LD HL, ST_HealthBar_Short + 5
                JR Z, $+5
                LD HL, ST_HealthBar_Long + 5

                LD A, (HL)
                CALL Memory.SetPage
                INC HL
                LD C, (HL)
                INC HL
                LD B, (HL)

                BIT COMPOSITE_UNIT_BIT, D
                LD HL, #0009
                JR Z, $+5
                LD HL, #000D
                ADD HL, BC
                EX DE, HL

                LD A, H
                EX AF, AF'
             
                ; преобразование XP = 0-255 -> A = 0-20
                BIT COMPOSITE_UNIT_BIT, H
                LD H, #00 
                JR Z, $+3
                ADD HL, HL
                ADD HL, HL
                LD B, H
                LD C, L
                ADD HL, HL
                ADD HL, HL
                ADD HL, BC

                ; округление в большую сторону
                LD A, L
                SUB #01
                CCF
                LD A, H
                ADC A, #00
                RET Z                                                           ; выход, если XP равен 0
                DEC A                                                           ; отсчёт с 1

                ; расчёт смещения в таблице
                LD C, A
                ADD A, A
                ADD A, C
                LD HL, .HP_Table
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H

                ; HL - адрес таблицы
                ; DE - адрес спрайта
                ; A' - FUnit.Type

                EX AF, AF'
                BIT COMPOSITE_UNIT_BIT, A
                JR Z, .Short
                
                LD A, (HL)
                INC HL
                LD (DE), A
                INC DE
                INC DE

                LD A, (HL)
                INC HL
                LD (DE), A
                INC DE
                INC DE
                
                LD A, (HL)
                LD (DE), A

                LD HL, ST_HealthBar_Long
                JR .Draw

.Short          LD A, (HL)
                SRL A
                LD (DE), A
                INC DE
                INC DE

                LD BC, #000A * 3 + 2
                ADD HL, BC

                LD A, (HL)
                SLA A
                LD (DE), A

                LD HL, ST_HealthBar_Short

.Draw           PUSH IX
                LD IX, .OffsetByPixel - FUnit.Offset
                CALL Sprite.PixelClipping
                CALL NC, Sprite.Draw
                POP IX

                RET

.OffsetByPixel  FLocation
.HP_Table       DB %10011111, %11111111, %11111101                              ; 12.7   =|...................=  1
                DB %10001111, %11111111, %11111101                              ; 25.5   =||..................=  2
                DB %10000111, %11111111, %11111101                              ; 38.2   =|||.................=  3
                DB %10000011, %11111111, %11111101                              ; 51.0   =||||................=  4
                DB %10000001, %11111111, %11111101                              ; 63.7   =|||||...............=  5
                DB %10000000, %11111111, %11111101                              ; 76.5   =||||||..............=  6
                DB %10000000, %01111111, %11111101                              ; 89.2   =|||||||.............=  7
                DB %10000000, %00111111, %11111101                              ; 102.0  =||||||||............=  8
                DB %10000000, %00011111, %11111101                              ; 114.7  =|||||||||...........=  9
                DB %10000000, %00001111, %11111101                              ; 127.5  =||||||||||..........= 10
                DB %10000000, %00000111, %11111101                              ; 140.2  =|||||||||||.........= 11
                DB %10000000, %00000011, %11111101                              ; 153.0  =||||||||||||........= 12
                DB %10000000, %00000001, %11111101                              ; 165.7  =|||||||||||||.......= 13
                DB %10000000, %00000000, %11111101                              ; 178.5  =||||||||||||||......= 14
                DB %10000000, %00000000, %01111101                              ; 191.2  =|||||||||||||||.....= 15
                DB %10000000, %00000000, %00111101                              ; 204.0  =||||||||||||||||....= 16
                DB %10000000, %00000000, %00011101                              ; 216.7  =|||||||||||||||||...= 17
                DB %10000000, %00000000, %00001101                              ; 229.5  =||||||||||||||||||..= 18
                DB %10000000, %00000000, %00000101                              ; 242.2  =|||||||||||||||||||.= 19
                DB %10000000, %00000000, %00000001                              ; 255.0  =||||||||||||||||||||= 20

                endmodule

                endif ; ~_DISPLAY_UI_HP_
