
                ifndef _DISPLAY_UI_HP_
                define _DISPLAY_UI_HP_

                module HP
; -----------------------------------------
; отрисовка указанного юнита Health Point
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Draw:           ; DE - указывает на структуру FSpriteLocation
                INC E
                INC E

                LD HL, .OffsetByPixel

                EX DE, HL
                LD C, (HL)                                                      ; FSpriteLocation.OffsetByPixel
                INC L
                LD B, (HL)

                EX DE, HL
                LD (HL), C
                INC L
                LD (HL), B
    
                LD A, R   ; XP
            
                ; расчёт HP
                RRA
                RRA
                RRA
                AND %00011110
                LD HL, .SmalHP_Table
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H
                LD E, (HL)
                INC HL
                LD D, (HL)

.DrawHP         LD HL, ST_HealthBar_Small + 5
                LD A, (HL)
                CALL Memory.SetPage
                INC HL
                LD C, (HL)
                INC HL
                LD B, (HL)
                LD HL, #0009
                ADD HL, BC
                LD (HL), E
                INC HL
                INC HL
                LD (HL), D

                LD HL, ST_HealthBar_Small
                LD DE, .OffsetByPixel + 1

                CALL Sprite.PixelClipping
                CALL NC, Sprite.Draw

                RET

.OffsetByPixel  FLocation
.SmalHP_Table   DB %01011111, %11111010                                         ; 0     [0]     - HP    (xxx0000x)  =..........=
                DB %01001111, %11111010                                         ; 25.5  [16]    - HP    (xxx0001x)  =|.........=
                DB %01001111, %11111010                                         ; 25.5  [32]    - HP    (xxx0001x)  =|.........=
                DB %01000111, %11111010                                         ; 51    [64]    - HP    (xxx0010x)  =||........=
                DB %01000011, %11111010                                         ; 76.5  [80]    - HP    (xxx0011x)  =|||.......=
                DB %01000011, %11111010                                         ; 76.5  [96]    - HP    (xxx0011x)  =|||.......=
                DB %01000001, %11111010                                         ; 102   [112]   - HP    (xxx0100x)  =||||......=
                DB %01000000, %11111010                                         ; 127.5 [128]   - HP    (xxx0101x)  =|||||.....=
                DB %01000000, %11111010                                         ; 127.5 [144]   - HP    (xxx0101x)  =|||||.....=
                DB %01000000, %01111010                                         ; 153   [160]   - HP    (xxx0110x)  =||||||....=
                DB %01000000, %01111010                                         ; 153   [176]   - HP    (xxx0110x)  =||||||....=
                DB %01000000, %00111010                                         ; 178.5 [192]   - HP    (xxx0111x)  =|||||||...=
                DB %01000000, %00011010                                         ; 204   [208]   - HP    (xxx1000x)  =||||||||..=
                DB %01000000, %00011010                                         ; 204   [224]   - HP    (xxx1000x)  =||||||||..=
                DB %01000000, %00001010                                         ; 229.5 [240]   - HP    (xxx1001x)  =|||||||||.=
                DB %01000000, %00000010                                         ; 255   [256]   - HP    (xxx1010x)  =||||||||||=

                endmodule

                endif ; ~_DISPLAY_UI_HP_
