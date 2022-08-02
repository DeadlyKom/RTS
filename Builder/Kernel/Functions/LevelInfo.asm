
                ifndef _BUILDER_KERNEL_MODULE_LOAD_LEVEL_INFO_
                define _BUILDER_KERNEL_MODULE_LOAD_LEVEL_INFO_
; -----------------------------------------
; загрузка информации об уровне
; In:
;   A - номер слота уровня
; Out:
; Corrupt:
; Note:
; -----------------------------------------
LevelInfo:      ; инициализация
                EX AF, AF'                                                      ; сохранён номер слота уровня
                SET_PAGE_FILE_SYS                                               ; включить страницу файловой системы
                CALL FileSystem.Base.Setup                                      ; инициализация файловой системы

                ; адрес завершения работы с файловой системой
                LD HL, FileSystem.Base.Shutdown
                PUSH HL
                ; JP FileSystem

                display "\t - Load Level Info : \t\t", /A, LevelInfo, " = busy [ ", /D, $ - LevelInfo, " bytes  ]"

                endif ; ~ _BUILDER_KERNEL_MODULE_LOAD_LEVEL_INFO_