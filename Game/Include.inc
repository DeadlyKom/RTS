
                            ifndef _GAME_INCLUDE_
                            define _GAME_INCLUDE_

                            include "../Config.inc"
                            include "AI.inc"
                            include "Color.inc"
                            include "Debug.inc"
                            include "Frame.inc"
                            include "Gameplay.inc"
                            include "Hardware.inc"
                            include "Input.inc"
                            include "Mouse.inc"
                            include "SurfaceProperty.inc"
                            include "TilemapMove.inc"
                            include "../Core/Macro.inc"
                    
                            define MAJOR 1
                            define MINOR 2
                            define BUILD 1

                            define TRD_FILENAME "Torn Metal.trd"                ; имя образа TRD
StackTop                    EQU #5BFB                                           ; расположение стека
MemoryPageIDRef             EQU #5BFC                                           ; ID
MemoryPageRef               EQU PORT_7FFD; #5BFE                                ; адрес хранения номера странички
BorderStorageStackRef       EQU #5BFF                                           ; адрес бубера хранения цвета бордера
InterruptVectorAddress      EQU #8181                                           ; адрес вектора прерывания
TilemapPtr                  EQU #C000                                           ; адрес тайловой карты
MapStructure                EQU MemoryPage_1.Map.End                            ; адрес структуры карты

WaypointsSequencePtr        EQU Page_1.WaypointsSequence                        ; адрес последовательностей Way Point'ов (2048 байт)
WaypointArrayPtr            EQU Page_1.WaypointArray                            ; адрес массива Way Point'ов (768 байт)
SurfacePropertyPtr          EQU Page_1.SurfaceProperty                          ; адрес свойст тайлов (128 байт)                                                    [128] free
TilemapTableAddress         EQU Page_1.TilemapTableAdr                          ; адрес таблицы тайловой карты (512 байт), для расчёта адреса по позиции тайла (не использовать умножение)
UnitArrayPtr                EQU Page_1.UnitArray                                ; адрес масива юнитов (1024 байта 64 юнита)
SharedBuffer                EQU Page_2.SharedBuffer                             ; адрес общего буфера (256 байт)
RenderBuffer                EQU Page_2.RenderBuffer                             ; адрес буфера обновлений (192 байта)                                               [64]  free
WaypointsSequenceBitmapPtr  EQU Page_2.RenderBuffer + 0xE0                      ; адрес битовой карты последовательностей Way Point'ов (32 байта)                   [32]  free + [32] busy = 64 last bytes
TilemapBuffer               EQU Page_2.TilemapBuffer                            ; адрес тайловой карты буфера (256 байт)
BypassFOW                   EQU Page_7.BypassFOW                                ; адресс таблицы обхода FOW
AI_MIN_UPDATE_FREQ          EQU 1                                               ; скорость обновления ИИ (минимальная)
AI_MAX_UPDATE_FREQ          EQU 4                                               ; скорость обновления ИИ (максимальная)
TimeOfDayChangeRate         EQU 50 * 60                                         ; скорость смены времени дня
TickCounterRef              EQU Interrupt.Handler.TickCounterPtr                ; счётчик тиков 1/50

; cursor speed
MIN_CURSOR_SPEED            EQU 3                                               ; минимальная дефолтная скорость курсора
MAX_CURSOR_SPEED            EQU 24                                              ; максимальная дефолтная скорость курсора
MinCursorSpeedRef           EQU Game.MinCursorSpeed                             ; минимальная скорость курсора
MaxCursorSpeedRef           EQU Game.MaxCursorSpeed                             ; максимальная скорость курсора

; flags
FrameStateRef               EQU Game.FrameFlags                                 ; указатель на флаги состояний (frame)
GameplayStateRef            EQU Game.GameplayState                              ; указатель на флаги состояний (game)
TilemapStateRef             EQU Game.TilemapState                               ; указатель на флаги тайловой карты (tilemap)
AIStateRef                  EQU Game.AIFlags                                    ; указатель на флаги состояний (AI)
HardwareStateRef            EQU Game.HardwareFlags                              ; указатель на флаг ограничений железа
FrameUnitsFlagRef           EQU Game.FrameUnitsFlag                             ; флаг обновления юнитов принудительно (необходим для скролинга)

; debug
                            ifdef DEBUG
DebugStateRef               EQU Game.DebugFlags                                 ; указатель на флаги необходимые для отладки

                            endif
; AI
AI_UpdateFrequencyRef       EQU Game.AI_UpdateFreq                              ; частота обновления AI
AI_NumUnitsRef              EQU Game.AI_NumUnits                                ; число юнитов

; Tilemap
TilesOnScreenX              EQU 16                                              ; количество тайлов на экране по горизонтали
TilesOnScreenY              EQU 12                                              ; количество тайлов на экране по вертикали

TilemapTableAddressRef      EQU Game.AddressTable                               ; адрес таблицы тайловой карты (512 байт), для расчёта адреса по позиции тайла (не использовать умножение)
TilemapTableHighAddressRef  EQU Game.AddressTable + 1                           ; старший байт таблицы тайловой карты (512 байт), для расчёта адреса по позиции тайла (не использовать умножение)
TilemapRef                  EQU Game.TilemapPtr                                 ; указатель на адрес тайловой карты
TilemapSizeRef              EQU Game.TilemapSize                                ; указатель на адрес размера карты
TilemapWidth                EQU Game.TilemapSize.X                              ; ширина тайловой карты (структура FMapSize)
TilemapWidth_NEG            EQU Game.TilemapSize_NEG.X                          ; ширина тайловой карты (отрецательное значение)
TilemapHeight               EQU Game.TilemapSize.Y                              ; высота тайловой карты (структура FMapSize)
TilemapHeight_NEG           EQU Game.TilemapSize_NEG.Y                          ; высота тайловой карты (отрецательное значение)
TilemapOffsetRef            EQU Game.TilemapOffset                              ; указатель смещения тайловой карты
TilemapOffsetWidth          EQU Game.TilemapOffset.X                            ; смещение в тайловой карте по горизонтали (структура FLocation)
TilemapOffsetHeight         EQU Game.TilemapOffset.Y                            ; смещение в тайловой карте по вертикали (структура FLocation)

SurfacePropertyRef          EQU Game.SurfacePropertyPtr                         ; адрес таблицы свойст тайлов (128 байт)                    - 1 страница
HighSurfacePropertyRef      EQU Game.SurfacePropertyPtr + 1                     ; старший байт адреса таблицы свойст тайлов (128 байт)      - 1 страница
WaypointCounterRef          EQU Game.WaypointCounter                            ; адрес счётчика элементов waypoint в массиве
WaypointArrayRef            EQU Game.WaypointArray                              ; адрес массива точек пути
HighWaypointArrayRef        EQU Game.WaypointArray + 1                          ; старший байт адрес массива точек пути
BehaviorTableRef            EQU Game.BehaviorTable                              ; адрес таблицы поведения юнитов
AnimTurnTableRef            EQU Game.AnimTurnTable                              ; адрес таблицы анимации поворотов
UnitArrayRef                EQU Game.UnitArray                                  ; адрес юнитов
TopRowOffsetFOW             EQU MemoryPage_7.FOW.ROW_UP                         ; смещение в буфере верхней строки FOW
BottomRowOffsetFOW          EQU MemoryPage_7.FOW.ROW_DOWN                       ; смещение в буфере нижней строки FOW

CursorFlagRef               EQU Mouse.PositionFlag                              ; флаг обновления позиции курсора (если #FF изменилось положение)
CursorPositionRef           EQU Mouse.Position                                  ; указатель на позицию курсора
CursorPositionX             EQU Mouse.PositionX                                 ; указатель на позицию курсора оси X
CursorPositionY             EQU Mouse.PositionY                                 ; указатель на позицию курсора оси Y

TilemapBottomClampRef       EQU MEMCPY.Tilemap.BottomClamp                      ; ограничения при определении нижней границы карты
TilemapBottomOffsetRef      EQU MEMCPY.Tilemap.BottomOffset                     ; смещение до нижней границы карты
TilemapRightClampRef        EQU MEMCPY.Tilemap.RightClamp                       ; ограничения при определении правой границы карты

; Keys
VirtualKeysRef              EQU Game.VK_Keys                                    ; Up, Down, Left, Right
VirtualKeyUpRef             EQU Game.VK_KeyUp                                   ;
VirtualKeyDownRef           EQU Game.VK_KeyDown                                 ;
VirtualKeyLeftRef           EQU Game.VK_KeyLeft                                 ;
VirtualKeyRightRef          EQU Game.VK_KeyRight                                ;

; pathfinding
PFWinWidth                  EQU 16                                              ; ширина окна поисковика (не менять, захардкожено)
PFWinHeight                 EQU 16                                              ; высота окна поисковика (не менять, захардкожено)
PFWinBufSize                EQU PFWinWidth * PFWinHeight * FPFInfo              ; размер буфера окна поисковика (2560 байт)
PathfindingVectorField      EQU Page_5.Pathfinding                              ; адрес буфера для поиска пути - векторное поле (4096 байт)                         remove ?
PathfindingQueue            EQU Page_5.PathfindingQueue                         ; адрес буфера для поиска пути - массив очереди ячеек (2048 байт)                   remove ?
PathfindingBuffer           EQU Page_5.PathfindingBuffer                        ; адрес буфера для поиска пути (2560 байт)
PathfindingOpenListBuffer   EQU Page_5.PathfindingOLBuffer                      ; адрес буфера для хранения координат открытого списка (max 512 байт)

                            endif ; ~_GAME_INCLUDE_
