
                ifndef _CORE_MODULE_UTILS_RECONNAISSANCE_
                define _CORE_MODULE_UTILS_RECONNAISSANCE_

                module Tilemap
; IX - FUnitLocation (2)
Reconnaissance: LD E, (IX + FUnitLocation.TilePosition.X)
                LD D, (IX + FUnitLocation.TilePosition.Y)
                
                ; кламп сверху
                LD A, D         ; D = Y
                SUB (HL)
                JR NC, $+7
                NEG
                ADD A, L
                LD L, A
                XOR A
                LD D, A         ; D = новое значение Y
                INC HL

                ; ---------------------

.Loop           LD B, (HL)      ; B = смещение по горизонтали
                INC B
                RET Z
                INC HL
                PUSH HL

                ; кламп слева   (X - смещение)
                LD A, E         ; E = X
                SUB B

                JR NC, $+3
                XOR A
                LD C, A         ; C - левый X

                 ; кламп справа
                LD A, (TilemapWidth)
                LD L, A         ; L = ширина карты

                LD A, E
                ADD A, B
                CP L
                JR C, $+4
                LD A, L
                DEC A

                SUB C
                INC A           ; +1 центр
                LD B, A         ; B - длина по горизонтали

                ; ---------------------

                LD L, D
                LD A, (TilemapTableHighAddressRef)
                LD H, A
                LD A, (HL)
                INC H
                LD H, (HL)
                ADD A, C
                LD L, A
                
                ; ---------------------

.LoopRow        RES 7, (HL)
                INC HL
                DJNZ .LoopRow

                ; ---------------------

                POP HL
                
                INC D
                LD A, (TilemapHeight)
                LD C, A
                LD A, D
                CP C
                JP C, .Loop
                
                RET
Radius_2        DB 2, 0,1,2,1,0, #FF
Radius_3        DB 3, 0,2,2,3,2,2,0, #FF
Radius_4        DB 3, 0,2,3,4,3,2,0, #FF
Radius_5        DB 4, 1,3,3,4,5,4,3,3,1, #FF
Radius_6        DB 5, 1,3,4,5,6,6,6,5,4,3,1, #FF
Radius_7        DB 7, 1,3,4,5,5,6,6,6,6,6,5,5,4,3,1, #FF
                endmodule

                endif ; ~ _CORE_MODULE_UTILS_RECONNAISSANCE_