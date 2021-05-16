
                            ifndef _GAME_INCLUDE_
                            define _GAME_INCLUDE_

                            include "../Config.inc"
                            include "Color.inc"
                            include "../Core/Macro.inc"
                    
                            define TRD_FILENAME "RTS.trd"       ; имя образа TRD
StackTop                    EQU #5BFD                           ; расположение стека
MemoryPagePtr               EQU #5BFE                           ; адрес хранения номера странички
InterruptVectorAddress      EQU #8181                           ; адрес вектора прерывания
TileMap                     EQU #C000                           ; адрес тайловой карты
SharedBuffer                EQU #7F00                           ; адрес общего буфера (256 байт)
TimeOfDayChangeRate         EQU 50 * 60                         ; скорость смены времени дня

TilesOnScreenX              EQU 16                              ; количество тайлов на экране по горизонтали
TileOnScreenY               EQU 12                              ; количество тайлов на экране по вертикали

TilemapRef                  EQU Game.TilemapPtr                 ; указатель на адрес тайловой карты
TilemapSizeRef              EQU Game.TilemapSize                ; указатель на адрес размера карты
CoreStateRef                EQU Game.StatusFlag                 ; указатель на адрес флага состояний (core)
TilemapWidth                EQU Game.TilemapSize.X              ; ширина тайловой карты (структура FMapSize)
TilemapHeight               EQU Game.TilemapSize.Y              ; высота тайловой карты (структура FMapSize)
TilemapOffsetWidth          EQU Game.TilemapOffset.X            ; смещение в тайловой карте по горизонтали (структура FLocation)
TilemapOffsetHeight         EQU Game.TilemapOffset.Y            ; смещение в тайловой карте по вертикали (структура FLocation)

                            endif ; ~_GAME_INCLUDE_
