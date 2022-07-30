
                ifndef _CORE_MODULE_FILE_SYSTEM_GAME_LAUNCH_
                define _CORE_MODULE_FILE_SYSTEM_GAME_LAUNCH_

                module Game
; -----------------------------------------
; загрузка и запуск игры
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
LoadAndLaunch:  ; адрес запуска
                LD HL, Adr.Module.Game.First
                PUSH HL

                ; количество загружаемых файлов
                LD A, .FileNum
                PUSH AF

                ; сохранение адреса .FileArray
                LD HL, .FileArray
                PUSH HL

                ; -----------------------------------------
                ; поиск файла в каталоге
                ; In:
                ;   SP-2 - указывает массив FFileArea загружаемых данных
                ;   SP-4 - старший байт количество файлов
                ;   SP-6 - адрес запуска
                ; Out:
                ;   флаг переполнения Carry сброшен при успешном поиске
                ; Corrupt:
                ; Note:
                ; -----------------------------------------

                ; вызов загрузчика пакета файлов
                JP LoadModule.Loader

.FileArray      ; путь файла графические файлы для "капитанский мостик"
                FFileArea {
                {{GameName}, CodeExt },
                Page.Game.First | FILE_ARCHIVE,
                Adr.Module.Game.First }

.FileNum        EQU ($-.FileArray) / FFileArea

                endmodule

                endif ; ~ _CORE_MODULE_FILE_SYSTEM_GAME_LAUNCH_