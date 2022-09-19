
                    ifndef _CONST_GAME_
                    define _CONST_GAME_

FGameAdr            EQU GameConfigRef + FConfig

GameVar
.TilemapSize:       EQU FGameAdr + FGame.Size                                   ; размер карты
.TilemapSizeNEG     EQU FGameAdr + FGame.SizeNEG                                ; размер карты (отрицательные значения)
.TilemapOffset:     EQU FGameAdr + FGame.Offset                                 ; смещения тайловой карты
.TilemapCachedAdr:  EQU FGameAdr + FGame.CachedAddress                          ; кешированное значение адрес тайловой карты
.TilemapCountdown:  EQU FGameAdr + FGame.Countdown                              ; обратный счётчик продолжительности (DURATION_TILE_ANIM)

GameFlags:
.RenderRef          EQU FGameAdr + FGame.Render                                 ; флаги отрисовки

                    endif ; ~_CONST_GAME_
