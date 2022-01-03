
                ifndef _CORE_MODULE_INITIALIZE_MAP_
                define _CORE_MODULE_INITIALIZE_MAP_

MapInfo:        ; инициализация перменных (из загруженной информации о карте)
                LD IX, SharedBuffer                                             ; адрес структуры карты

.CopyMapName    ; ********** MAP NAME **********
                LD HL, SharedBuffer
                LD DE, FileSystem.FileNameMap
                LD BC, #0009
                LDIR
                ; ********** ~MAP NAME *********

.MapSize        ; ********** MAP SIZE **********
                ; размер карты
                LD BC, (IX + FMap.Size)
                LD (TilemapSizeRef), BC                                         
                ; инициализация отрецательное значение ширины карты 
                LD A, C
                NEG
                LD (TilemapWidth_NEG), A
                ; инициализация отрецательное значение высоты карты 
                LD A, B
                NEG
                LD (TilemapHeight_NEG), A
                ; генерация таблицы адресов по позиции тайла (не использовать умножение)
                LD HL, TilemapPtr
                LD DE, TilemapTableAddress                                      ; DE - адрес таблицы тайловой карты 
                CALL Generate
                ; ********** ~MAP SIZE *********

.StartLocation  ; ******* START LOCATION *******
                LD DE, (IX + FMap.StartLocation)                                ; E - смещение по горизонтали, D - смещение по вертикали
                LD (TilemapOffsetRef), DE
                ; расчёт адрес расположения тайла
                CALL Utils.Tilemap.GetAddressTilemap
                LD (TilemapRef), HL
                ; ******* ~START LOCATION ******

.CalcMapMove    ; ***** CALCULATE MAP MOVE *****
                LD HL, TilemapSizeRef
                ; расчёт ограничения движения карты по горизонтали
                LD A, (HL)
                LD (Tilemap.MoveDown.Increment), A
                NEG                                                             ; X = -X
                LD (Tilemap.MoveUp.Decrement), A
                ADD A, #10                                                      ; -X += 16
                LD (Tilemap.MoveRight.Clamp), A
                LD (TilemapRightClampRef), A

                INC HL                                                          ; move to Y

                ; расчёт ограничения движения карты по вертикали
                LD A, (HL)
                ADD A, #F4                                                      ; -(Y - 12)
                NEG
                LD (Tilemap.MoveDown.Clamp), A
                LD (TilemapBottomClampRef), A

                ; расчёт количество тайлов на экране TilemapWidth * TilesOnScreenY
                LD HL, #0000
                LD A, (TilemapWidth)
                LD E, A
                LD D, #00
                LD B, TilesOnScreenY
                ADD HL, DE
                DJNZ $-1
                LD (TilemapBottomOffsetRef), HL
                ; ***** ~CALCULATE MAP MOVE ****
                
.SurfPropSize   ; ****** SURFACE PROPERTY ******
                LD A, (IX + FMap.SurfacePropertySize)
                LD (FileSystem.Load.MapData.SurfPropSize), A
                ; ****** ~SURFACE PROPERTY *****

.BehaviorSize   ; ********** BEHAVIOR **********
                LD HL, GameModeDataPtr
                LD DE, (IX + FMap.BehaviorSize)
                LD (FileSystem.Load.MapData.BehaviorSize), DE                   ; размер поведения
                ADD HL, DE
                ; ********* ~BEHAVIOR **********

.AnimTUpSize    ; ****** ANIMATION TURN UP *****
                LD (AnimTurnUpTableRef), HL
                LD DE, (IX + FMap.AnimTUpTableSize)
                LD (FileSystem.Load.MapData.AnimTUpSize), DE                    ; размер таблицы анимации поворотов (вверх)
                ADD HL, DE
                ; ***** ~ANIMATION TURN UP *****

.AnimTDownSize  ; ***** ANIMATION TURN DOWN ****
                LD (AnimTurnDownTableRef), HL
                LD DE, (IX + FMap.AnimTDownTableSize)
                LD (FileSystem.Load.MapData.AnimTDownpSize), DE                 ; размер таблицы анимации поворотов (низа)
                ADD HL, DE
                ; **** ~ANIMATION TURN DOWN ****

.AnimMoveSize   ; ******* ANIMATION MOVE *******
                LD (AnimMoveTableRef), HL
                LD DE, (IX + FMap.AnimMoveTableSize)
                LD (FileSystem.Load.MapData.AnimMoveSize), DE                   ; размер таблицы анимации перемещения
                ; ADD HL, DE
                ; ****** ~ANIMATION MOVE *******

.TilemapSize    ; ******** TILEMAP SIZE ********
                LD HL, (IX + FMap.MapSize)
                LD (FileSystem.Load.MapData.TilemapSize), HL                    ; размер тайловой карты
                ; ******** TILEMAP SIZE ********
                
                RET

                endif ; ~ _CORE_MODULE_INITIALIZE_MAP_