
                ifndef _GAME_MAP_INFO_INCLUDE_
                define _GAME_MAP_INFO_INCLUDE_

                ORG #0000

                module MapInfo
START:          ; метка определения начала блока
                FMap {
                {"Map"},                                                        ; имя файла карты
                'C',                                                            ; расширение файла
                {64, 64},                                                       ; размер карты в тайлах
                {0, 0},                                                         ; начальная позиция окна
                LoadMap.SurfaceSize,                                            ; размер своист тайлов (не более 128 байт)
                LoadMap.BehaviorSize,                                           ; размер поведения
                LoadMap.UnitsCharSize,                                          ; размер характеристик юнитов
                LoadMap.AnimTUpSize,                                            ; размер таблицы анимации поворотов (вверх)
                LoadMap.AnimTDownSize,                                          ; размер таблицы анимации поворотов (низа)
                LoadMap.AnimMoveSize,                                           ; размер таблицы анимации перемещения
                MAP_SIZE                                                        ; размер карты в байтах
                }
                FMap {{"MapA"}, 'C', {64, 64}, {0, 0} }
END:            ; метка определения конец блока

SIZE:           EQU END - START

                endmodule

                savetrd  TRD_FILENAME, MAP_INFO_FILENAME, #0000, MapInfo.SIZE

                endif ; ~ _GAME_MAP_INFO_INCLUDE_