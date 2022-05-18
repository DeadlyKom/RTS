
                ifndef _BUILDER_KERNEL_MODULE_LOADER_
                define _BUILDER_KERNEL_MODULE_LOADER_

                module Module
; -----------------------------------------
; поиск файла в каталоге
; In:
;   IX   - указывает массив FFileArea загружаемых данных
;   SP-2 - адрес запуска
; Out:
;   флаг переполнения Carry сброшен при успешном поиске
; Corrupt:
; Note:
; -----------------------------------------
Loader:         SET_PAGE_FILE_SYS                                               ; включить страницу файловой системы

                ; копирование данных в область переменных TR-DOS
                LD HL, .FileName
                CALL FileSystem.Base.FindFile
                RET C                                                           ; выход если файл не найден

                ; загрузка модуля
                LD DE, Adr.Loader                                               ; адрес загрузчика
                LD BC, (TRDOS.SIZE_B)                                           ; размер свойств поверхности
                LD A, #05                                                       ; страница свойств поверхности
                CALL FileSystem.Base.SequentialRead
                JP Adr.Loader

.FileName       FFile { {LoaderName}, SystemExt }                               ; имя загрузчика

                display " - Functions : \t\t", /A, Loader, " = busy [ ", /D, $ - Loader, " bytes  ]"

                endmodule

                endif ; ~_BUILDER_KERNEL_MODULE_LOADER_
