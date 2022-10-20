
                ifndef _BUILDER_LEVEL_SLOTS_
                define _BUILDER_LEVEL_SLOTS_
Slots:          
.Tutorial       FLevelInfo {
                {{TilemapTutorialName}, TilemapExt},                            ; имя файла тайловой карты
                {{TilemapPack_1_1_Name}, GraphicsExt},                          ; имя файла "спрайтов тайловой карты + таблицы спрайтов"
                { 64, 64 },                                                     ; размер карты в тайлах
                { 56, 16 }                                                      ; координаты старта слот А
                { 0, 0 }                                                        ; координаты старта слот B
                { 0, 0 }                                                        ; координаты старта слот C
                }

.Debug          FLevelInfo {
                {{TilemapTestName}, TilemapExt},                                ; имя файла тайловой карты
                {{TilemapPack_1_1_Name}, GraphicsExt},                          ; имя файла "спрайтов тайловой карты + таблицы спрайтов"
                { 64, 64 },                                                     ; размер карты в тайлах
                { 0, 0 }                                                        ; координаты старта слот А
                { 0, 0 }                                                        ; координаты старта слот B
                { 10, 10 }                                                      ; координаты старта слот C
                }

                endif ; ~ _BUILDER_LEVEL_SLOTS_
