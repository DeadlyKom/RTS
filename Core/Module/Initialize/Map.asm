
                ifndef _CORE_MODULE_INITIALIZE_MAP_
                define _CORE_MODULE_INITIALIZE_MAP_

Map:            ; инициализация перменных (из загруженной карты)
                XOR A
                LD IX, SharedBuffer                                             ; адрес структуры карты

.SetBehavior    ; ********** BEHAVIOR **********
                ; установка адреса таблицы поведения юнитов
                LD HL, (IX + FMap.BehaviorTable)
                LD (AI.Behavior.Table), HL
                ; ********** ~BEHAVIOR *********

                ; 
                LD HL, TilemapPtr
                LD DE, TilemapTableAddress                                      ; DE - адрес таблицы тайловой карты 
                LD BC, (IX + FMap.Size)
                LD (TilemapSizeRef), BC                                         ; размер карты

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

                LD DE, (IX + FMap.StartLocation)                                ; E - смещение по горизонтали, D - смещение по вертикали
                LD (TilemapOffsetRef), DE
                
                CALL Utils.Tilemap.GetAddressTilemap                            ; расчёт адрес расположения тайла
                LD (TilemapRef), HL

                ;
                LD HL, TilemapSizeRef
                ;
                LD A, (HL)
                LD (Tilemap.MoveDown.Increment), A
                NEG                                                             ; X = -X
                LD (Tilemap.MoveUp.Decrement), A
                ADD A, #10                                                      ; -X += 16
                LD (Tilemap.MoveRight.Clamp), A
                LD (TilemapRightClampRef), A
                ;
                INC HL                                                          ; move to Y
                ; -(Y - 12)
                LD A, (HL)
                ADD A, #F4
                NEG
                LD (Tilemap.MoveDown.Clamp), A
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

                endif ; ~ _CORE_MODULE_INITIALIZE_MAP_