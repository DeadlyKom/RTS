
                ifndef _BUILDER_KERNEL_MODULE_LOADER_
                define _BUILDER_KERNEL_MODULE_LOADER_
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
Loader:         ; подготовка
                BORDER BLACK                                                    ; бордюр чёрного цвета
                ATTR_4000_IPB BLACK, BLACK, 1

                ; инициализация
                SET_PAGE_FILE_SYS                                               ; включить страницу файловой системы
                CALL FileSystem.Base.Setup                                      ; инициализация файловой системы

                ; адрес завершения работы с файловой системой
                POP DE
                LD HL, FileSystem.Base.Shutdown
                EX (SP), HL
                PUSH HL
                PUSH DE

                ; поиск файла в каталоге
                LD HL, .FileName
                CALL FileSystem.Base.FindFile
                RET C                                                           ; выход если файл не найден

                ; загрузка модуля
                LD A, Page.Loader                                               ; страница 
                LD DE, Adr.Loader                                               ; адрес загрузчика
                CALL FileSystem.Base.PrimaryRead
                JP Adr.Loader

.FileName       FFile { {LoaderName}, SystemExt }                               ; имя загрузчика

                display "\t - Loader : \t\t\t\t\t", /A, Loader, " = busy [ ", /D, $ - Loader, " bytes  ]"

                endif ; ~_BUILDER_KERNEL_MODULE_LOADER_
