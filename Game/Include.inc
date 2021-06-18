
                            ifndef _GAME_INCLUDE_
                            define _GAME_INCLUDE_

                            include "../Config.inc"
                            include "AI.inc"
                            include "Color.inc"
                            include "Debug.inc"
                            include "Frame.inc"
                            include "Hardware.inc"
                            include "Mouse.inc"
                            include "SurfaceProperty.inc"
                            include "../Core/Macro.inc"
                    
                            define MAJOR 1
                            define MINOR 2
                            define BUILD 1

                            define TRD_FILENAME "Torn Metal.trd"    ; имя образа TRD
StackTop                    EQU #5BFB                               ; расположение стека
MemoryPageIDRef             EQU #5BFC                               ; ID
MemoryPageRef               EQU #5BFE                               ; адрес хранения номера странички
BorderStorageStackRef       EQU #5BFF                               ; адрес бубера хранения цвета бордера
InterruptVectorAddress      EQU #8181                               ; адрес вектора прерывания
MapStructure                EQU #C000                               ; адрес структуры карты
WayPointArray               EQU Page_1.WayPointArray                ; адрес массива Way Point'ов (512 байт)
SurfaceProperty             EQU Page_1.SurfaceProperty              ; адрес свойст тайлов (128 байт)                    - 1 страница
UnitArray                   EQU Page_1.UnitArray                    ; адрес масива юнитов (1024 байта 64 юнита)         - 1 страница
SharedBuffer                EQU #BD00                               ; адрес общего буфера (256 байт)
RenderBuffer                EQU #BE00                               ; адрес буфера обновлений (192 байта + 64 пустуют)
TilemapBuffer               EQU #BF00                               ; адрес тайловой карты буфера (256 байт)
BypassFOW                   EQU Page_7.BypassFOW                    ; адресс таблицы обхода FOW
AI_MIN_UPDATE_FREQ          EQU 1                                   ; скорость обновления ИИ (минимальная)
AI_MAX_UPDATE_FREQ          EQU 8                                   ; скорость обновления ИИ (максимальная)
TimeOfDayChangeRate         EQU 50 * 60                             ; скорость смены времени дня
TickCounterRef              EQU Interrupt.Handler.TickCounterPtr    ; счётчик тиков 1/50

; flags
FrameStateRef               EQU Game.FrameFlags                     ; указатель на флаги состояний (frame)
AIStateRef                  EQU Game.AIFlags                        ; указатель на флаги состояний (AI)
HardwareStateRef            EQU Game.HardwareFlags                  ; указатель на флаг ограничений железа
FrameUnitsFlagRef           EQU Game.FrameUnitsFlag                 ; флаг обновления юнитов принудительно (необходим для скролинга)

; debug
                            ifdef DEBUG
DebugStateRef               EQU Game.DebugFlags                     ; указатель на флаги необходимые для отладки

                            endif
; AI
AI_UpdateFrequencyRef       EQU Game.AI_UpdateFreq                  ; частота обновления AI
AI_NumUnitsRef              EQU Game.AI_NumUnits                    ; число юнитов

TilesOnScreenX              EQU 16                                  ; количество тайлов на экране по горизонтали
TilesOnScreenY              EQU 12                                  ; количество тайлов на экране по вертикали

TilemapRef                  EQU Game.TilemapPtr                     ; указатель на адрес тайловой карты
TilemapSizeRef              EQU Game.TilemapSize                    ; указатель на адрес размера карты
TilemapWidth                EQU Game.TilemapSize.X                  ; ширина тайловой карты (структура FMapSize)
TilemapHeight               EQU Game.TilemapSize.Y                  ; высота тайловой карты (структура FMapSize)
TilemapOffsetRef            EQU Game.TilemapOffset                  ; указатель смещения тайловой карты
TilemapOffsetWidth          EQU Game.TilemapOffset.X                ; смещение в тайловой карте по горизонтали (структура FLocation)
TilemapOffsetHeight         EQU Game.TilemapOffset.Y                ; смещение в тайловой карте по вертикали (структура FLocation)

BehaviorTableRef            EQU Game.BehaviorTable                  ; адрес таблицы поведения юнитов
UnitArrayRef                EQU Game.UnitArray                      ; адрес юнитов
TopRowOffsetFOW             EQU MemoryPage_7.FOW.ROW_UP             ; смещение в буфере верхней строки FOW
BottomRowOffsetFOW          EQU MemoryPage_7.FOW.ROW_DOWN           ; смещение в буфере нижней строки FOW

MouseFlagRef                EQU Mouse.MousePositionFlag             ; флаг обновления позиции курсора (если #FF изменилось положение)
MousePositionRef            EQU Mouse.MousePosition                 ; указатель на позицию мыши
MousePositionX              EQU Mouse.MousePositionX                ; указатель на позицию мыши оси X
MousePositionY              EQU Mouse.MousePositionY                ; указатель на позицию мыши оси Y

TilemapBottomClampRef       EQU MEMCPY.Tilemap.BottomClamp          ; ограничения при определении нижней границы карты
TilemapBottomOffsetRef      EQU MEMCPY.Tilemap.BottomOffset         ; смещение до нижней границы карты
TilemapRightClampRef        EQU MEMCPY.Tilemap.RightClamp           ; ограничения при определении правой границы карты

                            endif ; ~_GAME_INCLUDE_
