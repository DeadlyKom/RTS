
                ifndef _BUILDER_KERNEL_MODULE_LOAD_LEVEL_INFO_
                define _BUILDER_KERNEL_MODULE_LOAD_LEVEL_INFO_
; -----------------------------------------
; запуск уровня
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
LaunchLevel:    ; инициализация
                SET_PAGE_FILE_SYS                                               ; включить страницу файловой системы
                JP FileSystem.Level.LaunchLevel

                display "\t - Launch Level : \t", /A, LaunchLevel, " = busy [ ", /D, $ - LaunchLevel, " bytes  ]"

                endif ; ~ _BUILDER_KERNEL_MODULE_LOAD_LEVEL_INFO_