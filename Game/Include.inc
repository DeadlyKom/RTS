
                            ifndef _GAME_INCLUDE_
                            define _GAME_INCLUDE_

                            include "../Config.inc"
                            include "Color.inc"
                            include "Debug.inc"
                            include "Frame.inc"
                            include "Mouse.inc"
                            include "../Core/Macro.inc"
                    
                            define TRD_FILENAME "Torn Metal.trd"    ; имя образа TRD
StackTop                    EQU #5BFD                               ; расположение стека
MemoryPageRef               EQU #5BFE                               ; адрес хранения номера странички
BorderStorageStackRef       EQU #5BFF                               ; адрес бубера хранения цвета бордера
InterruptVectorAddress      EQU #8181                               ; адрес вектора прерывания
TileMap                     EQU #C000                               ; адрес тайловой карты
RenderBuffer                EQU #BE00                               ; адрес буфера обновлений (192 байта + 64 пустуют)
SharedBuffer                EQU #BF00                               ; адрес общего буфера (256 байт)
TimeOfDayChangeRate         EQU 50 * 60                             ; скорость смены времени дня

TilesOnScreenX              EQU 16                                  ; количество тайлов на экране по горизонтали
TileOnScreenY               EQU 12                                  ; количество тайлов на экране по вертикали

TilemapRef                  EQU Game.TilemapPtr                     ; указатель на адрес тайловой карты
NewTilemapRef               EQU Game.NewTilemapPtr                  ; указатель на адрес новой позиции тайловой карты
TilemapSizeRef              EQU Game.TilemapSize                    ; указатель на адрес размера карты
FrameStateRef               EQU Game.FrameFlags                     ; указатель на адрес флага состояний (frame)
TilemapWidth                EQU Game.TilemapSize.X                  ; ширина тайловой карты (структура FMapSize)
TilemapHeight               EQU Game.TilemapSize.Y                  ; высота тайловой карты (структура FMapSize)
TilemapOffsetWidth          EQU Game.TilemapOffset.X                ; смещение в тайловой карте по горизонтали (структура FLocation)
TilemapOffsetHeight         EQU Game.TilemapOffset.Y                ; смещение в тайловой карте по вертикали (структура FLocation)


MouseFlagRef                EQU Mouse.MousePositionFlag             ; флаг обновления позиции курсора (если #FF изменилось положение)
MouseEdgeFlagRef            EQU Mouse.MouseDirectionEdge            ; флаги отвечающие если курсор пытается выйти за края экрана
MousePositionRef            EQU Mouse.MousePosition                 ; указатель на позицию мыши
MousePositionX              EQU Mouse.MousePositionX                ; указатель на позицию мыши оси X
MousePositionY              EQU Mouse.MousePositionY                ; указатель на позицию мыши оси Y

                            endif ; ~_GAME_INCLUDE_
