
                            ifndef _GAME_INCLUDE_
                            define _GAME_INCLUDE_

;                             include "../Config.inc"
;                             include "../TRDOSConfig.inc"
;                             include "AI.inc"
;                             include "Color.inc"
;                             include "Debug.inc"
;                             include "Frame.inc"
;                             include "Gameplay.inc"
;                             include "Hardware.inc"
;                             include "Input.inc"
;                             include "Mouse.inc"
;                             include "SurfaceProperty.inc"
;                             include "TilemapMove.inc"
;                             ; include "../Core/Macro.inc"
                    
;                             define MAJOR 1
;                             define MINOR 2
;                             define BUILD 1

;                             define TRD_FILENAME "Torn Metal.trd"                ; имя образа TRD
;                             define MAP_INFO_FILENAME "MapsInfo.C"               ; имя файла информации о карте
;                             define MAP_FILENAME "Map.C"                         ; имя файла карте
; StackTop                    EQU Page_5                                          ; расположение стека
; MemoryPageRef               EQU PORT_7FFD;                                      ; адрес хранения номера странички
; InterruptVectorAddress      EQU #8181                                           ; адрес вектора прерывания

; file system
FileSystemPtr               EQU Page_1.FileSystemPtr                            ; адрес блока работы с загрузкой/сохранением

;
; SharedBuffer                EQU Page_2.SharedBuffer                             ; адрес общего буфера (256 байт)
; SharedBufferSize            EQU 256                                             ; размер общего буфера
; RenderBuffer                EQU Page_2.RenderBuffer                             ; адрес буфера обновлений (192 байта)                                               [64]  free
SelectedBufferFirst         EQU Page_2.RenderBuffer + 0xC0                      ; адрес буфера выделенных юнитов (32 байта)                                         [32]
SizeSelectedBuffer          EQU 32                                              ; размер буфера выделенных юнитов
MaskSelectedBuffer          EQU SizeSelectedBuffer - 1                          ; маска буфера выделенных юнитов
WaypointsSequenceBitmapPtr  EQU Page_2.RenderBuffer + 0xE0                      ; адрес битовой карты последовательностей Way Point'ов (32 байта)                   [32]
SizeWaypointsSequenceBitmap EQU 32                                              ; размер битовой карты последовательностей Way Point'ов
; TilemapBuffer               EQU Page_2.TilemapBuffer                            ; адрес тайловой карты буфера (256 байт)
BypassFOW                   EQU Page_7.BypassFOW                                ; адресс таблицы обхода FOW
AI_MIN_UPDATE_FREQ          EQU 1                                               ; скорость обновления ИИ (минимальная)
AI_MAX_UPDATE_FREQ          EQU 4                                               ; скорость обновления ИИ (максимальная)
TimeOfDayChangeRate         EQU 50 * 60                                         ; скорость смены времени дня
; TickCounterRef              EQU Interrupt.Handler.TickCounterPtr                ; счётчик тиков 1/50

; ; cursor speed
; MIN_CURSOR_SPEED            EQU 3                                               ; минимальная дефолтная скорость курсора
; MAX_CURSOR_SPEED            EQU 24                                              ; максимальная дефолтная скорость курсора
; MinCursorSpeedRef           EQU Game.MinCursorSpeed                             ; минимальная скорость курсора
; MaxCursorSpeedRef           EQU Game.MaxCursorSpeed                             ; максимальная скорость курсора

; flags
FrameStateRef               EQU Game.FrameFlags                                 ; указатель на флаги состояний (frame)
GameplayStateRef            EQU Game.GameplayState                              ; указатель на флаги состояний (game)
InputStateRef               EQU Game.InputState                                 ; указатель на флаги состояний (input)
TilemapStateRef             EQU Game.TilemapState                               ; указатель на флаги тайловой карты (tilemap)
AIStateRef                  EQU Game.AIFlags                                    ; указатель на флаги состояний (AI)
HardwareStateRef            EQU Game.HardwareFlags                              ; указатель на флаг ограничений железа
FrameUnitsFlagRef           EQU Game.FrameUnitsFlag                             ; флаг обновления юнитов принудительно (необходим для скролинга)

; debug
                            ifdef _DEBUG
DebugStateRef               EQU Game.DebugFlags                                 ; указатель на флаги необходимые для отладки

                            endif
; AI
; AI_UpdateFrequencyRef       EQU Game.AI_UpdateFreq                              ; частота обновления AI
; AI_NumUnitsRef              EQU Game.AI_NumUnits                                ; число юнитов

; Tilemap
; TilemapPtr                  EQU #C000                                           ; адрес тайловой карты
; TilemapMaxSize              EQU 8192                                            ; максимально доступный размер для карты
; TilesOnScreenX              EQU 16                                              ; количество тайлов на экране по горизонтали
; TilesOnScreenY              EQU 12                                              ; количество тайлов на экране по вертикали
; TilemapRef                  EQU Game.TilemapPtr                                 ; указатель на адрес тайловой карты
TilemapSizeRef              EQU Game.TilemapSize                                ; указатель на адрес размера карты
TilemapWidth                EQU Game.TilemapSize.X                              ; ширина тайловой карты (структура FMapSize)
TilemapWidth_NEG            EQU Game.TilemapSize_NEG.X                          ; ширина тайловой карты (отрецательное значение)
TilemapHeight               EQU Game.TilemapSize.Y                              ; высота тайловой карты (структура FMapSize)
TilemapHeight_NEG           EQU Game.TilemapSize_NEG.Y                          ; высота тайловой карты (отрецательное значение)
TilemapOffsetRef            EQU Game.TilemapOffset                              ; указатель смещения тайловой карты
; TilemapOffsetWidth          EQU Game.TilemapOffset.X                            ; смещение в тайловой карте по горизонтали (структура FLocation)
; TilemapOffsetHeight         EQU Game.TilemapOffset.Y                            ; смещение в тайловой карте по вертикали (структура FLocation)
TilemapTableAddress         EQU Page_1.TilemapTableAdr                          ; адрес таблицы тайловой карты, для расчёта адреса используя пизиции тайла X и Y (не использовать умножение)
TilemapTableSize            EQU 512                                             ; размер таблицы тайлов карты для расчёта адреса используя пизиции тайла X и Y (не использовать умножение)

; surface
SurfacePropertyPtr          EQU Page_1.SurfaceProperty                          ; адрес свойст тайлов (128 байт)
SurfecePropertySize         EQU 128 + 128                                       ; размер свойства тайлов (128 тайлов)                       [128] free
; SurfacePropertyRef          EQU Game.SurfacePropertyPtr                         ; адрес таблицы свойст тайлов (128 байт)                    - 1 страница
; HighSurfacePropertyRef      EQU Game.SurfacePropertyPtr + 1                     ; старший байт адреса таблицы свойст тайлов (128 байт)      - 1 страница
WaypointCounterRef          EQU Game.WaypointCounter                            ; адрес счётчика элементов waypoint в массиве
; WaypointArrayRef            EQU Game.WaypointArray                              ; адрес массива точек пути
; HighWaypointArrayRef        EQU Game.WaypointArray + 1                          ; старший байт адрес массива точек пути

; brhavior
; BehaviorTableRef            EQU Game.BehaviorTable                              ; адрес таблицы поведения юнитов

; animation
AnimTurnUpTableRef          EQU Game.AnimTurnUpTable                            ; адрес таблицы анимации поворотов (вверх)
AnimTurnDownTableRef        EQU Game.AnimTurnDownTable                          ; адрес таблицы анимации поворотов (низ)
AnimMoveTableRef            EQU Game.AnimMoveTable                              ; адрес таблицы анимации перемещения

; TopRowOffsetFOW             EQU MemoryPage_7.FOW.ROW_UP                         ; смещение в буфере верхней строки FOW
; BottomRowOffsetFOW          EQU MemoryPage_7.FOW.ROW_DOWN                       ; смещение в буфере нижней строки FOW

CursorFlagRef               EQU Mouse.PositionFlag                              ; флаг обновления позиции курсора (если #FF изменилось положение)
CursorPositionRef           EQU Mouse.Position                                  ; указатель на позицию курсора
CursorPositionX             EQU Mouse.PositionX                                 ; указатель на позицию курсора оси X
CursorPositionY             EQU Mouse.PositionY                                 ; указатель на позицию курсора оси Y

; tilemap clamps (right/bottom)
TilemapMEMCPYBottomClampRef EQU MEMCPY.Tilemap.BottomClamp                      ; ограничения при определении нижней границы карты
TilemapMoveBottomClampRef   EQU Tilemap.MoveDown.BottomClamp                    ; ограничение при перемещении карты нижней границы карты
TilemapVisibleBottomClampRef EQU Utils.Tilemap.IsVisibleUnit.BottomClamp        ;
TilemapBottomOffsetRef      EQU MEMCPY.Tilemap.BottomOffset                     ; смещение до нижней границы карты
TilemapMEMCPYRightClampRef  EQU MEMCPY.Tilemap.RightClamp                       ; ограничения при определении правой границы карты
TilemapMoveRightClampRef    EQU Tilemap.MoveRight.Clamp                         ; ограничение при перемещении карты правой границы карты
TilemapVisibleRightClampRef EQU Utils.Tilemap.IsVisibleUnit.RightClamp          ;

; Keys
VirtualKeysRef              EQU Game.VK_Keys                                    ; Up, Down, Left, Right
VirtualKeyUpRef             EQU Game.VK_KeyUp                                   ;
VirtualKeyDownRef           EQU Game.VK_KeyDown                                 ;
VirtualKeyLeftRef           EQU Game.VK_KeyLeft                                 ;
VirtualKeyRightRef          EQU Game.VK_KeyRight                                ;

; pathfinding
PFWinWidth                  EQU 16                                              ; ширина окна поисковика (не менять, захардкожено)
PFWinHeight                 EQU 16                                              ; высота окна поисковика (не менять, захардкожено)
PFWinNumNodes               EQU PFWinWidth * PFWinHeight                        ; количество узлов согласно размеру окна
PFWinBufSize                EQU PFWinNumNodes * FPFInfo                         ; размер буфера окна поисковика (2560 байт)
PathfindingBuffer           EQU Page_5.PathfindingBuffer                        ; адрес буфера для поиска пути (2560 байт)
PathfindingOpenListBuffer   EQU Page_5.PathfindingOLBuffer                      ; адрес буфера для хранения координат открытого списка (max 512 байт)
CountFreeQueryQueueRef      EQU Pathfinding.Queue.PushUnit.CountFree            ; адрес переменной, сколько доступно в очереди запросов поиска пути
FoundPathToUnitRef          EQU Pathfinding.AStar.GetFoundPath.UnitIdx          ; индекс юнита * 4, для которого строится путь
PathfindingQueryQueueFirst  EQU SurfacePropertyPtr + 0x80                       ; адрес очереди запросов поиска пути (128 байт)             [128]
PathfindingQueryQueueLast   EQU SurfacePropertyPtr + 0xFF                       ; адрес очереди запросов поиска пути (128 байт)             [128]
SizePathfindingQueryQueue   EQU 128                                             ; размер очереди запросов поиска пути
MaskPathfindingQueryQueue   EQU SizePathfindingQueryQueue - 1                   ; маска очереди запросов поиска пути

; selection
SelectRectStartRef          EQU DrawRectangle.Start                             ; адрес левой-верхней точки выбора рамкой (в пикселях)
SelectRectEndRef            EQU DrawRectangle.End                               ; адрес правой-нижней точки выбора рамкой (в пикселях)
NumberSelectedUnitRef       EQU Unit.Select.ScanRectSelect.NumSelected          ; адрес переменной, сколько элементов в буфере выбора

; ; units
; UnitArrayPtr                EQU Page_1.UnitArray                                ; адрес массива юнитов
; MAX_UNIT_ARRAY              EQU 128                                             ; максимальное количество юнитов в массиве
; UNITS_STRUCTURE_SIZE        EQU MAX_UNIT_ARRAY * UNIT_SIZE                      ; размер массива всех доступных юнитов
; UnitsCharRef                EQU Game.UnitsChar                                  ; адрес таблицы характеристик юнитов

; array of chunks for units
ARRAY_CHUNKS

                            endif ; ~_GAME_INCLUDE_
