
                ifndef _CORE_DISPLAY_TILEMAP_CONTROLL_
                define _CORE_DISPLAY_TILEMAP_CONTROLL_
Initialize:     ; toggle to memory page with tilemap
                SeMemoryPage MemoryPage_Tilemap, TILEMAP_INIT_ID

                ; инициализация перменных (из загруженной карты)
                XOR A
                LD IX, MapStructure                         ; адрес структуры карты

                LD HL, (IX + FMap.BehaviorTable)            ; инициализация адреса таблицы поведения
                LD (BehaviorTableRef), HL
                LD HL, (IX + FMap.AnimTurnTable)            ; инициализация адреса таблицы анимаций поворота
                LD (AnimTurnTableRef), HL
                LD HL, (IX + FMap.UnitsArray)               ; инициализация адреса массива юнитов
                LD (UnitArrayRef), HL
                LD HL, (IX + FMap.SurfaceProperty)          ; инициализация фдреса свойств поверхностей
                LD (SurfacePropertyRef), HL

                LD HL, (IX + FMap.Address)                  ; HL - адрес начала (смещение 0,0) тайловой карты
                LD (TilemapAddressRef), HL
                LD DE, (IX + FMap.AddressTable)             ; DE - адрес таблицы тайловой карты 
                LD (TilemapTableAddressRef), DE
                LD BC, (IX + FMap.Size)
                LD (TilemapSizeRef), BC                     ; размер карты

                CALL Generate

                LD DE, (IX + FMap.StartLocation)           ; E - смещение по горизонтали, D - смещение по вертикали
                LD (TilemapOffsetRef), DE
                

                ; расчёт смещения в тайловой карте, 
                ; в зависимости от размеров карты и смещения

                LD L, D
                LD A, (TilemapTableHighAddressRef)
                LD H, A
                LD A, (HL)
                INC H
                LD H, (HL)
                ADD A, E
                LD L, A
                JR NC, $+3
                INC H
                LD (TilemapRef), HL

                ;
                LD HL, TilemapSizeRef
                ;
                LD A, (HL)
                LD (MoveDown.Increment), A
                NEG                                         ; X = -X
                LD (MoveUp.Decrement), A
                ADD A, #10                                  ; -X += 16
                LD (MoveRight.Clamp), A
                LD (TilemapRightClampRef), A
                ;
                INC HL                                      ; move to Y
                ; -(Y - 12)
                LD A, (HL)
                ADD A, #F4
                NEG
                LD (MoveDown.Clamp), A
                LD (TilemapBottomClampRef), A

                ; TilemapWidth (ширина карты) * TilesOnScreenY (количество тайлов на экране)
                LD HL, #0000
                LD A, (TilemapWidth)
                LD E, A
                LD D, #00
                LD B, TilesOnScreenY
.Multiply       ADD HL, DE
                DJNZ .Multiply
                LD (TilemapBottomOffsetRef), HL
                RET
MoveUp:         ;
                LD HL, TilemapOffsetHeight
                XOR A
                OR (HL)
                RET Z
                DEC (HL)
                LD HL, (TilemapRef)
.Decrement      EQU $+1
                LD DE, #FF00
                ADD HL, DE
                LD (TilemapRef), HL
                RET
MoveDown:       ;
                LD HL, TilemapOffsetHeight
.Clamp          EQU $+1
                LD A, #00
                ADD A, (HL)
                RET C
                INC (HL)
                LD HL, (TilemapRef)
.Increment      EQU $+1
                LD DE, #0000
                ADD HL, DE
                LD (TilemapRef), HL
                RET
MoveLeft:       ;
                LD HL, TilemapOffsetWidth
                XOR A
                OR (HL)
                RET Z
                DEC (HL)
                LD HL, (TilemapRef)
                DEC HL
                LD (TilemapRef), HL
                RET
MoveRight:      ;
                LD HL, TilemapOffsetWidth
.Clamp          EQU $+1
                LD A, #00
                ADD A, (HL)
                RET C
                INC (HL)
                LD HL, (TilemapRef)
                INC HL
                LD (TilemapRef), HL
                RET

                endif ; ~_CORE_DISPLAY_TILEMAP_CONTROLL_
