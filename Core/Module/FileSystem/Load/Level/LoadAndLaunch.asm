
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
                ; загрузка информации об уровне
                ; -----------------------------------------
                CALL Info
                ifdef _DEBUG
                JR C, $                                                         ; произошла ошибка
                endif

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
                LD HL, Adr.Module.Game.First
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
                Page.Tilemap.Map | FILE_ARCHIVE,
                Adr.Tilemap.Map }

                ; путь файла спрайтов "тайловой карты"
                FFileArea {
                {{"xxxxxxxx"}, 0x00 },
                Page.Tilemap.Sprite | FILE_ARCHIVE,
                Adr.Tilemap.SpriteTable }

                ; путь файла модуля "основной блок"     (1)
                FFileArea {
                {{GameFirstName}, CodeExt },
                Page.Game.First | FILE_ARCHIVE,
                Adr.Module.Game.First }

                ; путь файла модуля "работы с тайлами"  (2)
                FFileArea {
                {{GameSecondName}, CodeExt },
                Page.Game.Second | FILE_ARCHIVE,
                Adr.Module.Game.Second }

                ; путь файла модуля "таблиц"            (3)
                FFileArea {
                {{GameThirdName}, CodeExt },
                Page.Game.Third | FILE_ARCHIVE,
                Adr.Module.Game.Third }

.FileNum        EQU ($-.FileArray) / FFileArea

                display " - Load Level : \t\t", /A, Data, " = busy [ ", /D, $ - Data, " bytes  ]"

                endif ; ~ _CORE_MODULE_FILE_SYSTEM_LOAD_AND_LAUNCH_LEVEL_
