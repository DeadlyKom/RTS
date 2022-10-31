
                    ifndef _CONST_GAME_
                    define _CONST_GAME_

FGameAdr            EQU GameConfigRef + FConfig

Map
.StartSlotA         EQU FGameAdr + FGame.StartSlotA                             ; координаты старта слот A
.StartSlotB         EQU FGameAdr + FGame.StartSlotB                             ; координаты старта слот B
.StartSlotC         EQU FGameAdr + FGame.StartSlotC                             ; координаты старта слот C
.Size               EQU FGameAdr + FGame.Size                                   ; размер карты
.Width              EQU FGameAdr + FGame.Size.X                                 ; размер карты по горизонтали
.Height             EQU FGameAdr + FGame.Size.Y                                 ; размер карты по вертикали
.SizeNEG            EQU FGameAdr + FGame.SizeNEG                                ; размер карты (отрицательные значения)

Game
.FlyingCountdown    EQU FGameAdr + FGame.FlyCountdown                           ; обратный счётчик продолжительности (DURATION.FLY_ANIM)
.RestoreScr         EQU FGameAdr + FGame.RestoreScr                             ; адрес экрана для функции восстановления фона
.RestoreSize        EQU FGameAdr + FGame.RestoreSize                            ; размер восстанвливаемой области для функции восстановление фона
.RestorePage        EQU FGameAdr + FGame.RestorePage                            ; страница для функции восстановление фона
.DeltaTime          EQU FGameAdr + FGame.DeltaTime                              ; время между кадрами отрисовки (значение отрицательное)

GameAI:
.UnitArraySize      EQU FGameAdr + FGame.UnitArraySize                          ; размер массива юнитов
.AI_UpdateRate      EQU FGameAdr + FGame.AI_UpdateRate                          ; частота обновления ИИ

Tilemap
.Offset             EQU FGameAdr + FGame.Offset                                 ; смещения тайловой карты (текущая)
.Offset.X           EQU FGameAdr + FGame.Offset.X                               ; смещение тайловой карты (текущая) по горизонтали
.Offset.Y           EQU FGameAdr + FGame.Offset.Y                               ; смещение тайловой карты (текущая) по вертикали
.CachedAddress      EQU FGameAdr + FGame.CachedAddress                          ; кешированное значение адрес тайловой карты
.Countdown          EQU FGameAdr + FGame.TileCountdown                          ; обратный счётчик продолжительности (DURATION.TILE_ANIM)
; .TilemapSizeChunk   EQU FGameAdr + FGame.SizeChank                              ; размер карты (в чанках)
; .TilemapSizeChunk.X EQU FGameAdr + FGame.SizeChank.X                            ; размер карты по горизонтали (в чанках)
; .TilemapSizeChunk.Y EQU FGameAdr + FGame.SizeChank.Y                            ; размер карты по вертикали (в чанках)
GameFlags:
.RenderRef          EQU FGameAdr + FGame.Render                                 ; флаги отрисовки
.ScrollFlagsRef     EQU FGameAdr + FGame.ScrollFlags                            ; флаги описывающие смещение тайловой карты при скроле
.SpriteRef          EQU FGameAdr + FGame.Sprite                                 ; данные спрайта
.SpriteOffsetRef    EQU FGameAdr + FGame.Sprite.Data.Low                        ; флаги спрайта (смещение)
.SpriteFlagRef      EQU FGameAdr + FGame.Sprite.Data.High                       ; флаги спрайта
.Gameplay           EQU FGameAdr + FGame.Gameplay                               ; флаги геймплея
.Hardware           EQU FGameAdr + FGame.Hardware                               ; флаги ограничения железа

GameAnim:
.OffsetY            EQU FGameAdr + FGame.CompositeY                             ; смещение по вертикали для композитного спрайта
.Array              EQU FGameAdr + FGame.Animation                              ; массив анимаций
.Element_0          EQU FGameAdr + FGame.Animation + 0                          ; 1 элемент массив анимаций
.Element_1          EQU FGameAdr + FGame.Animation + 1                          ; 2 элемент массив анимаций
.Element_2          EQU FGameAdr + FGame.Animation + 2                          ; 3 элемент массив анимаций
.Element_3          EQU FGameAdr + FGame.Animation + 3                          ; 4 элемент массив анимаций

                    include "GameConst.inc"

                    endif ; ~_CONST_GAME_
