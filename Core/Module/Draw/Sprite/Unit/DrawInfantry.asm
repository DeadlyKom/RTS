
                ifndef _CORE_MODULE_DRAW_SPRITE_UNIT_INFANTRY_
                define _CORE_MODULE_DRAW_SPRITE_UNIT_INFANTRY_
; -----------------------------------------
; отображение дроид-пехотинца
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawInfantry:   ; сохранеие текущей страницы
                LD A, (MemoryPageRef)
                LD (.RestoreMemPage), A                                         ; сохранение страницы спрайта

                ; подготовка позиции вывода юнита
                LD HL, (IX + FUnit.Position.X)
                LD (Prepare.PositionX), HL                                      ; сохранение позиции юнита по горизонтали
                LD HL, (IX + FUnit.Position.Y)
                LD (Prepare.PositionY), HL                                      ; сохранение позиции юнита по вертикали

                ; -----------------------------------------
                ; расчёт адреса
                ; -----------------------------------------

                LD H, HIGH Game.Infantry.SpriteInfo
                LD A, (IX + FUnit.Direction)
                LD L, (IX + FUnit.Animation)
                XOR L
                AND DF_DOWN_MASK
                XOR L
                AND %11111000                                                   ; обнуление младшие три бита
                ; -----------------------------------------
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | A1 | A0 | D2 | D1 | D0 |  0 |  0 |  0 |
                ;   +----+----+----+----+----+----+----+----+
                ;
                ;   A1,A0   [5,4]   - номер анимации (нижней)
                ;   D2-D0   [2..0]  - направление
                ;                       000 - up
                ;                       001 - up-right
                ;                       010 - right
                ;                       011 - down-right
                ;                       100 - down
                ;                       101 - down-left
                ;                       110 - left
                ;                       111 - up-left
                ; -----------------------------------------
                ; корректировка начального адреса спрайта
                ADD A, LOW Game.Infantry.SpriteInfo
                LD L, A
                ADC A, H
                SUB L
                LD H, A

                ; -----------------------------------------
                ; чтение информации о спрайте
                ; -----------------------------------------
                LD E, (HL)                                                      ; FSprite.Info.Height
                INC HL
                LD A, (HL)                                                      ; FSprite.Info.OffsetY
                LD (Prepare.SOy), A
                INC HL
                LD D, (HL)                                                      ; FSprite.Info.Width
                LD (Prepare.SpriteSize), DE
                INC HL
                LD A, (HL)                                                      ; FSprite.Info.OffsetX
                LD (Prepare.SOx), A
                INC HL
                LD A, (HL)                                                      ; FSprite.Offset
                INC HL
                LD (GameFlags.SpriteOffsetRef), A
                LD A, (HL)                                                      ; FSprite.Page
                INC HL
                LD E, CSIF_OR_XOR << 1
                ADD A, A
                RR E
                RRA
                CALL SetPage
                LD A, E
                LD (GameFlags.SpriteFlagRef), A
                LD E, (HL)                                                      ; FSprite.Data.Low
                INC HL
                LD D, (HL)                                                      ; FSprite.Data.High
                EX DE, HL

                ; -----------------------------------------
                ; подготовка спрайта перед выводом
                ; -----------------------------------------

                CALL Prepare                                                    ; проверка и подготовка спрайта перед отрисовкой
                CALL C, Draw                                                    ; если все проверки успешны, отрисовка спрайта

                ; востановление страницы
.RestoreMemPage EQU $+1
                LD A, #00
                JP SetPage

                display " - Draw Unit Infantry : \t\t\t\t", /A, DrawInfantry, " = busy [ ", /D, $ - DrawInfantry, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_SPRITE_UNIT_INFANTRY_
