
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
MainLoadText:   ; инициализация
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
                LD A, Page.MainMenu                                             ; страница 
                LD DE, Adr.MainMenuText                                         ; адрес текста главного меню
                JP FileSystem.Base.PrimaryRead

.FileName       FFile { {MainTextRuName}, SystemExt }                           ; имя файла русского языка главного меню
                FFile { {MainTextSpName}, SystemExt }                           ; имя файла испанского языка главного меню
                FFile { {MainTextEnName}, SystemExt }                           ; имя файла английского языка главного меню

                display " - Main Load Text : \t\t\t", /A, MainLoadText, " = busy [ ", /D, $ - MainLoadText, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_MAIN_LOAD_TEXT_
