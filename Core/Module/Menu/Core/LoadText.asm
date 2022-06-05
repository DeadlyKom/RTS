
                ifndef _CORE_MODULE_MENU_MAIN_LOAD_TEXT_
                define _CORE_MODULE_MENU_MAIN_LOAD_TEXT_
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
@LoadText:      ; инициализация
                EX AF, AF'                                                      ; сохранён номер языка
                SET_PAGE_FILE_SYS                                               ; включить страницу файловой системы
                CALL FileSystem.Base.Setup                                      ; инициализация файловой системы

                ; адрес завершения работы с файловой системой
                LD HL, FileSystem.Base.Shutdown
                PUSH HL

                ; поиск файла в каталоге
                LD HL, .FileName - FFile
                EX AF, AF'                                                      ; востановлен номер языка
                ; проверим валидность загружаемого языка
                AND LANGUAGE_MASK
                JR NZ, .IsValid

                ; установка дефолтного языка
                LD A, LANGUAGE_DEFAULT

.IsValid        LD B, A
                LD DE, FFile

.FileNameLoop   ADD HL, DE
                DJNZ .FileNameLoop
                CALL FileSystem.Base.FindFile
                RET C                                                           ; выход если файл не найден

                ; загрузка модуля
                LD A, Page.Main                                                 ; страница 
                LD DE, Adr.Module.Text                                          ; адрес текста меню
                JP FileSystem.Base.PrimaryRead

.FileName       FFile { {MenuTextEnName}, SystemExt }                           ; имя файла английского языка меню
                FFile { {MenuTextRuName}, SystemExt }                           ; имя файла русского языка меню
                FFile { {MenuTextSpName}, SystemExt }                           ; имя файла испанского языка меню

                display " - Load Text : \t\t", /A, LoadText, " = busy [ ", /D, $ - LoadText, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_MAIN_LOAD_TEXT_
