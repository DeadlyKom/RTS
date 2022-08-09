
                ifndef _BUILDER_LEVEL_SLOTS_
                define _BUILDER_LEVEL_SLOTS_
Slots:          
.Tutorial       FLevelInfo {
                {{TilemapTutorialName}, TilemapExt},                            ; имя файла тайловой карты
                {{TilemapPack_1_Name}, GraphicsExt},                            ; имя файла "спрайтов тайловой карты + таблицы спрайтов"
                { 64, 64 },                                                     ; размер карты в тайлах
                { 56, 16 }                                                      ; координаты старта для фракции А
                { 0, 0 }                                                        ; координаты старта для фракции B
                { 0, 0 }                                                        ; координаты старта для фракции C
                }

.Debug          FLevelInfo {
                {{TilemapTestName}, TilemapExt},                                ; имя файла тайловой карты
                {{TilemapPack_1_Name}, GraphicsExt},                            ; имя файла "спрайтов тайловой карты + таблицы спрайтов"
                { 64, 64 },                                                     ; размер карты в тайлах
                { 0, 0 }                                                        ; координаты старта для фракции А
                { 0, 0 }                                                        ; координаты старта для фракции B
                { 0, 0 }                                                        ; координаты старта для фракции C
                }

                endif ; ~ _BUILDER_LEVEL_SLOTS_
