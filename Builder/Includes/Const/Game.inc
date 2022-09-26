
                    ifndef _CONST_GAME_
                    define _CONST_GAME_

FGameAdr            EQU GameConfigRef + FConfig

GameVar
.TilemapSize        EQU FGameAdr + FGame.Size                                   ; размер карты
.TilemapSizeNEG     EQU FGameAdr + FGame.SizeNEG                                ; размер карты (отрицательные значения)
.TilemapOffset      EQU FGameAdr + FGame.Offset                                 ; смещения тайловой карты
.TilemapCachedAdr   EQU FGameAdr + FGame.CachedAddress                          ; кешированное значение адрес тайловой карты
.TilemapCountdown   EQU FGameAdr + FGame.Countdown                              ; обратный счётчик продолжительности (DURATION_TILE_ANIM)

GameAI:
.UnitArraySize      EQU FGameAdr + FGame.UnitArraySize                          ; размер массива юнитов
.AI_UpdateRate      EQU FGameAdr + FGame.AI_UpdateRate                          ; частота обновления ИИ

GameFlags:
.RenderRef          EQU FGameAdr + FGame.Render                                 ; флаги отрисовки
.SpriteRef          EQU FGameAdr + FGame.Sprite                                 ; данные спрайта
.SpriteOffsetRef    EQU FGameAdr + FGame.Sprite.Data.Low                        ; флаги спрайта
.SpriteFlagRef      EQU FGameAdr + FGame.Sprite.Data.High                       ; флаги спрайта

                    endif ; ~_CONST_GAME_
