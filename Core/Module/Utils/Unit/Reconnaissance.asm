
                ifndef _CORE_MODULE_UTILS_RECONNAISSANCE_
                define _CORE_MODULE_UTILS_RECONNAISSANCE_

                module Tilemap
; -----------------------------------------
; рекогносцировка
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Reconnaissance: ; проверка бита фракции (разведка только для игрока)
                LD A, (IX + FUnit.Type)
                AND FACTION_MASK
                RET NZ

                ; проверка бита об проведённой разведки после остановки
                BIT FUSE_RECONNAISSANCE_BIT, (IX + FUnit.State)
                RET Z                                                           ; пропустить разведку

                RES FUSE_RECONNAISSANCE_BIT, (IX + FUnit.State)                 ; сброс флага разведки

.Force          ; получение адреса характеристик юнита
                LD HL, (UnitsCharRef)
                CALL Utils.Unit.GetAdrInTable
                PUSH HL
                POP IY
                LD A, (IY + FUnitCharacteristics.Distance)

; -----------------------------------------
; рекогносцировка
; In:
;   A  - радиус обзора в тайлах
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ReconRadius:    LD HL, Table
                ADD A, A
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H
                LD A, (HL)
                INC HL
                LD H, (HL)
                LD L, A

; -----------------------------------------
; рекогносцировка
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ConstReconnaissance:
                LD DE, (IX + FUnit.Position)
                
                SET_PAGE_TILEMAP

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
                JR Z, .Exit
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
                LD H, HIGH TilemapTableAddress
                LD A, (HL)
                INC H
                LD H, (HL)
                ADD A, C
                LD L, A
                ; ---------------------

.LoopRow        RL (HL)
                JR C, .Update
                OR A
                RR (HL)
                INC HL
                DJNZ .LoopRow
                JR .Next

.Update         OR A
                RR (HL)
                INC HL
                
                ResetFrameFlag FORCE_FOW_FLAG
                DJNZ .LoopRow_
                JR .Next

.LoopRow_       RES 7, (HL)
                INC HL
                DJNZ .LoopRow_

                ; ---------------------

.Next           POP HL
                
                INC D
                LD A, (TilemapHeight)
                LD C, A
                LD A, D
                CP C
                JP C, .Loop

.Exit           SET_PAGE_UNITS_ARRAY                                            ; включить страницу массива юнитов
                
                RET
Table:          DW Radius_0                                                     ; 0
                DW Radius_1                                                     ; 1
                DW Radius_2                                                     ; 1
                DW Radius_3                                                     ; 1
                DW Radius_4                                                     ; 2
                DW Radius_5                                                     ; 3
                DW Radius_6                                                     ; 4
                DW Radius_7                                                     ; 5
Radius_0        DB 2, 0,0, #FF
Radius_1        DB 1, 0,1,1,0, #FF
Radius_2        DB 2, 0,1,2,1,0, #FF
Radius_3        DB 3, 0,2,2,3,2,2,0, #FF
Radius_4        DB 3, 0,2,3,4,3,2,0, #FF
Radius_5        DB 4, 1,3,3,4,5,4,3,3,1, #FF
Radius_6        DB 5, 1,3,4,5,6,6,6,5,4,3,1, #FF
Radius_7        DB 7, 1,3,4,5,5,6,6,6,6,6,5,5,4,3,1, #FF

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_RECONNAISSANCE_