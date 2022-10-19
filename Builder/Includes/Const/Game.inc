
                    ifndef _CONST_GAME_
                    define _CONST_GAME_

FGameAdr            EQU GameConfigRef + FConfig

GameVar
.StartSlotA         EQU FGameAdr + FGame.StartSlotA                             ; координаты старта слот A
.StartSlotB         EQU FGameAdr + FGame.StartSlotB                             ; координаты старта слот B
.StartSlotC         EQU FGameAdr + FGame.StartSlotC                             ; координаты старта слот C
.TilemapSize        EQU FGameAdr + FGame.Size                                   ; размер карты
.TilemapSizeNEG     EQU FGameAdr + FGame.SizeNEG                                ; размер карты (отрицательные значения)
; .TilemapSizeChunk   EQU FGameAdr + FGame.SizeChank                              ; размер карты (в чанках)
; .TilemapSizeChunk.X EQU FGameAdr + FGame.SizeChank.X                            ; размер карты по горизонтали (в чанках)
; .TilemapSizeChunk.Y EQU FGameAdr + FGame.SizeChank.Y                            ; размер карты по вертикали (в чанках)
.TilemapOffset      EQU FGameAdr + FGame.Offset                                 ; смещения тайловой карты (текущая)
.TilemapCachedAdr   EQU FGameAdr + FGame.CachedAddress                          ; кешированное значение адрес тайловой карты
.TilemapCountdown   EQU FGameAdr + FGame.TileCountdown                          ; обратный счётчик продолжительности (DURATION_TILE_ANIM)
.FlyingCountdown    EQU FGameAdr + FGame.FlyCountdown                           ; обратный счётчик продолжительности (DURATION_FLY_ANIM)

GameAI:
.UnitArraySize      EQU FGameAdr + FGame.UnitArraySize                          ; размер массива юнитов
.AI_UpdateRate      EQU FGameAdr + FGame.AI_UpdateRate                          ; частота обновления ИИ

GameFlags:
.RenderRef          EQU FGameAdr + FGame.Render                                 ; флаги отрисовки
.SpriteRef          EQU FGameAdr + FGame.Sprite                                 ; данные спрайта
.SpriteOffsetRef    EQU FGameAdr + FGame.Sprite.Data.Low                        ; флаги спрайта
.SpriteFlagRef      EQU FGameAdr + FGame.Sprite.Data.High                       ; флаги спрайта
.Gameplay           EQU FGameAdr + FGame.Gameplay                               ; флаги геймплея


ANIM_INDEX_NONE     EQU 0xFF
ANIM_INDEX_0        EQU 0x00
ANIM_INDEX_1        EQU 0x01
ANIM_INDEX_2        EQU 0x02
ANIM_INDEX_3        EQU 0x03

GameAnim:
.OffsetY            EQU FGameAdr + FGame.CompositeY                             ; смещение по вертикали для композитного спрайта
.Array              EQU FGameAdr + FGame.Animation                              ; массив анимаций
.Element_0          EQU FGameAdr + FGame.Animation + 0                          ; 1 элемент массив анимаций
.Element_1          EQU FGameAdr + FGame.Animation + 1                          ; 2 элемент массив анимаций
.Element_2          EQU FGameAdr + FGame.Animation + 2                          ; 3 элемент массив анимаций
.Element_3          EQU FGameAdr + FGame.Animation + 3                          ; 4 элемент массив анимаций


GAMEPLAY_BIT        EQU 0x01                                                    ; флаг базового старта миссии
                                                                                ; 0 - нормальный старт со слота StartSlotA
                                                                                ; 1 - режим защиты старт со слота StartSlotB
GAMEPLAY_BASE       EQU 0x00
GAMEPLAY_PROTECT    EQU 1 << GAMEPLAY_BIT

                    endif ; ~_CONST_GAME_
