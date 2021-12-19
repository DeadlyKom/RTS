
                ifndef _CORE_DISPLAY_TILEMAP_CONTROLL_
                define _CORE_DISPLAY_TILEMAP_CONTROLL_
Initialize:     ; toggle to memory page with tilemap
                CALL Memory.SetPage1                       ; SeMemoryPage MemoryPage_Tilemap, TILEMAP_INIT_ID

                ; инициализация перменных (из загруженной карты)
                XOR A
                LD IX, MapStructure                         ; адрес структуры карты

                LD HL, (IX + FMap.WaypointArray)            ; инициализация адреса массива точек пути
                LD (WaypointArrayRef), HL
                LD HL, (IX + FMap.BehaviorTable)            ; инициализация адреса таблицы поведения
                LD (BehaviorTableRef), HL
                LD HL, (IX + FMap.AnimTurnTable)            ; инициализация адреса таблицы анимаций поворота
                LD (AnimTurnTableRef), HL
                LD HL, (IX + FMap.UnitsArray)               ; инициализация адреса массива юнитов
                LD (UnitArrayRef), HL
                LD HL, (IX + FMap.SurfaceProperty)          ; инициализация фдреса свойств поверхностей
                LD (SurfacePropertyRef), HL

                ; LD HL, (IX + FMap.Address)                  ; HL - адрес начала (смещение 0,0) тайловой карты
                ; LD (TilemapAddressRef), HL
                LD HL, TilemapPtr
                LD DE, (IX + FMap.AddressTable)             ; DE - адрес таблицы тайловой карты 
                LD (TilemapTableAddressRef), DE
                LD BC, (IX + FMap.Size)
                LD (TilemapSizeRef), BC                     ; размер карты

                ; инициализация отрецательное значение ширины карты 
                LD A, C
                NEG
                LD (TilemapWidth_NEG), A

                ; инициализация отрецательное значение высоты карты 
                LD A, B
                NEG
                LD (TilemapHeight_NEG), A

                ; генерация таблицы адресов по позиции тайла (не использовать умножение)
                CALL Generate

                LD DE, (IX + FMap.StartLocation)           ; E - смещение по горизонтали, D - смещение по вертикали
                LD (TilemapOffsetRef), DE
                
                CALL Utils.Tilemap.GetAddressTilemap       ; расчёт адрес расположения тайла
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
                JR Z, .Edge
                DEC (HL)
                LD HL, (TilemapRef)
.Decrement      EQU $+1
                LD DE, #FF00
                ADD HL, DE
                LD (TilemapRef), HL
                OR A
                RET
.Edge           ResetTilemapFlag CURSOR_UP_EDGE_FLAG
                RET
MoveDown:       ;
                LD HL, TilemapOffsetHeight
.Clamp          EQU $+1
                LD A, #00
                ADD A, (HL)
                JR C, .Edge
                INC (HL)
                LD HL, (TilemapRef)
.Increment      EQU $+1
                LD DE, #0000
                ADD HL, DE
                LD (TilemapRef), HL
                OR A
                RET
.Edge           ResetTilemapFlag CURSOR_DOWN_EDGE_FLAG
                RET
MoveLeft:       ;
                LD HL, TilemapOffsetWidth
                XOR A
                OR (HL)
                JR Z, .Edge
                DEC (HL)
                LD HL, (TilemapRef)
                DEC HL
                LD (TilemapRef), HL
                RET
.Edge           ResetTilemapFlag CURSOR_LEFT_EDGE_FLAG
                RET
MoveRight:      ;
                LD HL, TilemapOffsetWidth
.Clamp          EQU $+1
                LD A, #00
                ADD A, (HL)
                JR C, .Edge
                INC (HL)
                LD HL, (TilemapRef)
                INC HL
                LD (TilemapRef), HL
                RET
.Edge           ResetTilemapFlag CURSOR_RIGHT_EDGE_FLAG
                RET

                endif ; ~_CORE_DISPLAY_TILEMAP_CONTROLL_
