
                            ifndef _CORE_MEMORY_INCLUDE_
                            define _CORE_MEMORY_INCLUDE_

                            ; карта памяти (общая)
Page_0:                     EQU #C000                                           ; [Bank 03]

Page_1:                     EQU #C000                                           ; [Bank 03]
Page_1.UnitArray            EQU Page_1                                          ; [Bank 03] адресс массива юнитов
Page_1.SurfaceProperty      EQU Page_1.UnitArray + TilemapMaxSize               ; [Bank 03] адрес свойст тайлов 128 байт                                            [128] free
Page_1.TilemapTableAdr      EQU Page_1.SurfaceProperty + SurfecePropertySize    ; [Bank 03] адрес таблицы тайловой карты, для расчёта адреса используя пизиции тайла X и Y (не использовать умножение)
Page_1.FileSystemPtr        EQU Page_1.TilemapTableAdr + TilemapTableSize       ; [Bank 03] адрес блока работы с загрузкой/сохранением

Page_2:                     EQU #8000                                           ; Bank 02
Page_2.SharedBuffer         EQU #BD00                                           ; Bank 02 (адрес общего буфера)                     - 256 байт
Page_2.RenderBuffer         EQU #BE00                                           ; Bank 02 (адрес буфера обновлений)                 - 192 байта                     [64] заняты буфером выбора и WayPoint'ами
Page_2.TilemapBuffer        EQU #BF00                                           ; Bank 02 (адрес тайловой карты буфера)             - 256 байт

Page_3:                     EQU #C000                                           ; Bank 03
Page_4:                     EQU #C000                                           ; Bank 03
Page_5:                     EQU #4000 + #1B00 + #0300                           ; Bank 01 (Screen 0) (пропуск экрана и 0x300 байт данных для TR DOS)
Page_5.PathfindingBuffer    EQU #4000                                           ; Bank 01 (Screen 0) (временный массив)             - размер константа PFWinBufSize
Page_5.PathfindingOLBuffer  EQU #4A00                                           ; Bank 01 (Screen 0) (временный массив)             - максимальный размер 512 байт
Page_6:                     EQU #C000                                           ; Bank 03
Page_7:                     EQU #C000 + #1B00                                   ; Bank 03 (Screen 1) (пропуск экрана)
Page_7.DebugTileTable:      EQU #DB00                                           ; Bank 03 (Screen 1) (таблица спрайтов дебага)      - 256 байт
Page_7.ScrAdr:              EQU #E600                                           ; Bank 03 (Screen 1) (таблица адресов экрана)       - 1024 байта
Page_7.BypassFOW:           EQU #EA00                                           ; Bank 03 (Screen 1) (таблица обхода FOW)           - 768 байт
Page_7.FOWTable:            EQU #ED00                                           ; Bank 03 (Screen 1) (спрайты тумана войны)         - 512 байт
Page_7.TileTable:           EQU #EF00                                           ; Bank 03 (Screen 1) (тайлы карты)                  - 256 байт
Page_7.TileSprites:         EQU #F000                                           ; Bank 03 (Screen 1) (тайлы карты)                  - 4096 байт


; file system
MemPage_FileSystem          EQU Memory.SetPage1                                 ; страница файловой системы

; data
MemPage_UnitArray           EQU Memory.SetPage0                                 ; страница массива юнитов
BehaviorAdr                 EQU Page_0 | MemoryPage_0.Behavior                  ; адрес BTT юнитов

                            include "Macro.inc"
                            include "../Module/AI/Composite/Definition.inc"

                            include "Page_00.asm"
                            include "Page_01.asm"
                            include "Page_02.asm"
                            include "Page_03.asm"
                            include "Page_04.asm"
                            include "Page_05.asm"
                            include "Page_06.asm"
                            include "Page_07.asm"

PageSprites_0               EQU 4                                               ; sprite page 0
MemoryPage_Tilemap          EQU 1
MemoryPage_Music            EQU 3
MemoryPage_MainScreen       EQU 5
MemoryPage_ShadowScreen     EQU 7
MemoryPage_CursorSprite     EQU 7

                            endif ; ~_CORE_MEMORY_INCLUDE_
