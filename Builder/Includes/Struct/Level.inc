
                ifndef _STRUCT_LEVEL_
                define _STRUCT_LEVEL_

                struct FLevelInfo
Map             FFile                                                           ; имя файла тайловой карты
TilemapSpr      FFile                                                           ; имя файла таблицы + спрайты тайловой карты
Size            FMapSize 0, 0                                                   ; размер карты
StartFaction_A  FLocation 0, 0                                                  ; координаты старта для фракции А
StartFaction_B  FLocation 0, 0                                                  ; координаты старта для фракции B
StartFaction_C  FLocation 0, 0                                                  ; координаты старта для фракции C

                ends

                endif ; ~ _STRUCT_LEVEL_
