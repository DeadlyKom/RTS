
                ifndef _BUILDER_KERNEL_MODULE_CHANGE_LANGUAGE_
                define _BUILDER_KERNEL_MODULE_CHANGE_LANGUAGE_
; -----------------------------------------
; смена языка
; In:
;   A - номер языка
;       0 - русский
;       1 - испанский
;       2 - английский
; Out:
;   флаг переполнения Carry сброшен при успешном поиске
; Corrupt:
; Note:
; -----------------------------------------
ChangeLanguage: ; инициализация
                EX AF, AF'                                                      ; сохранён номер языка
                SET_PAGE_FILE_SYS                                               ; включить страницу файловой системы
                CALL FileSystem.Base.Setup                                      ; инициализация файловой системы

                ; адрес завершения работы с файловой системой
                LD HL, FileSystem.Base.Shutdown
                PUSH HL

                ; поиск файла в каталоге
                LD HL, .FileName - FFile
                EX AF, AF'                                                      ; востановлен номер языка
                LD B, A
                LD DE, FFile

.FileNameLoop   ADD HL, DE
                DJNZ .FileNameLoop
                CALL FileSystem.Base.FindFile
                RET C                                                           ; выход если файл не найден

                ; загрузка модуля
                LD A, Page.Module.Language                                      ; страница 
                LD DE, Adr.Fonts                                                ; адрес загрузчика шрифта
                JP FileSystem.Base.PrimaryRead

.FileName       FFile { {FontRuName}, SystemExt }                               ; имя шрифта русского языка
                FFile { {FontSpName}, SystemExt }                               ; имя шрифта испанского языка
                FFile { {FontEnName}, SystemExt }                               ; имя шрифта английского языка

                display "\t - Change Language : \t", /A, ChangeLanguage, " = busy [ ", /D, $ - ChangeLanguage, " bytes  ]"

                endif ; ~_BUILDER_KERNEL_MODULE_CHANGE_LANGUAGE_
