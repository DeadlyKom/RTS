
                ifndef _CORE_MODULE_FILE_SYSTEM_LOAD_AND_LAUNCH_LEVEL_
                define _CORE_MODULE_FILE_SYSTEM_LOAD_AND_LAUNCH_LEVEL_
; -----------------------------------------
; загрузка и последующий запуск уровня
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
LaunchLevel:    CALL FileSystem.Base.Setup                                      ; инициализация файловой системы

                ; -----------------------------------------
                ; загрузка информации об уровне (номер уровня в LevelSlotRef)
                ; -----------------------------------------
                CALL Info
                DEBUG_BREAK_POINT_C                                             ; произошла ошибка

                ; -----------------------------------------
                ; инициализация уровня
                ; -----------------------------------------
                LD DE, .FileArray                                               ; адрес стркутуры FFileArea
                CALL Data
                CALL FileSystem.Base.Shutdown                                   ; завершения работы с файловой системой

                ; -----------------------------------------
                ; загрузка данных уровня
                ; -----------------------------------------
                ; адрес запуска
                LD HL, Adr.Module.Game.Main
                PUSH HL

                ; адрес запуска инициализации
                LD HL, PostInitialize
                PUSH HL

                ; количество загружаемых файлов
                LD A, .FileNum
                PUSH AF

                ; сохранение адреса .FileArray
                LD HL, .FileArray
                PUSH HL

                ; -----------------------------------------
                ;   SP-2 - указывает массив FFileArea загружаемых данных
                ;   SP-4 - старший байт количество файлов
                ;   SP-6 - адрес запуска
                ; -----------------------------------------

                ; вызов загрузчика пакета файлов
                JP LoadModule.Loader

.FileArray      ; путь файла "тайловой карты"
                FFileArea {
                {{"xxxxxxxx"}, 0x00 },
                Page.Game.Tilemap | FILE_ARCHIVE,
                Adr.Module.Game.Tilemap }

                ; путь файла спрайтов "тайловой карты"
                FFileArea {
                {{"xxxxxxxx"}, 0x00 },
                Page.Tilemap.Sprite | FILE_ARCHIVE,
                Adr.Tilemap.SpriteTable }

                ; путь файла спрайтов "Pack1"
                FFileArea {
                {{GraphicsPack_1_Name}, GraphicsExt },
                Page.Graphics.Pack1 | FILE_ARCHIVE,
                Adr.Graphics.Pack1 }

                ; путь файла модуля "основной блок"             (1)
                FFileArea {
                {{GameMainName}, CodeExt },
                Page.Game.Main | FILE_ARCHIVE,
                Adr.Module.Game.Main }

                ; путь файла модуля "кода работы с юнитами"     (2)
                FFileArea {
                {{GameUnitCodeName}, CodeExt },
                Page.Game.Unit | FILE_ARCHIVE,
                Adr.Module.Game.UnitCode }

                ; путь файла модуля "кода работы с тайлами"     (3)
                FFileArea {
                {{GameTilemapCodeName}, CodeExt },
                Page.Game.Tilemap | FILE_ARCHIVE,
                Adr.Module.Game.TilemapCode }

                ; путь файла модуля "таблиц"                    (4)
                FFileArea {
                {{GameTilemapExName}, CodeExt },
                Page.Game.TilemapEx | FILE_ARCHIVE,
                Adr.Module.Game.TilemapEx }

.FileNum        EQU ($-.FileArray) / FFileArea

                display " - Load Level : \t\t\t\t\t", /A, Data, " = busy [ ", /D, $ - Data, " bytes  ]"

                endif ; ~ _CORE_MODULE_FILE_SYSTEM_LOAD_AND_LAUNCH_LEVEL_
