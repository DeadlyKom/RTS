
                ifndef _CORE_MODULE_MENU_MAIN_LOAD_TEXT_
                define _CORE_MODULE_MENU_MAIN_LOAD_TEXT_

@SetLanguage:   ; загрузка языка
                LD A, (ConfigOptions)
                AND LANGUAGE_MASK
                CALL Functions.LoadFont

                ; -----------------------------------------
                ; загрузка текста "главного меню"
                ; -----------------------------------------
                LD HL, MainMenu.Functor
                LD DE, MainMenu.Filename
                CALL FindLoadText
                JR C, $                                                         ; файл не найден

                ; -----------------------------------------
                ; загрузка текста "командного мостика"
                ; -----------------------------------------
                LD HL, CapBridge.Functor
                LD DE, CapBridge.Filename
                CALL FindLoadText
                JR C, $                                                         ; файл не найден

                ; инициализация таблицы текста
                LD HL, Adr.Module.MenuText
                LD (LocalizationRef), HL
                RET

MainMenu:       ; -----------------------------------------
                ; загрузка текста "главного меню"
                ; -----------------------------------------
.Functor        ; функция загрузки
                LD A, Page.Main                                                 ; страница 
                LD DE, Adr.Module.MenuText                                      ; адрес текста
                JP FileSystem.Base.PrimaryRead

.Filename       FFile { {MenuTextEnName}, TextExt }                             ; имя файла английского языка меню
                FFile { {MenuTextRuName}, TextExt }                             ; имя файла русского языка меню
                FFile { {MenuTextSpName}, TextExt }                             ; имя файла испанского языка меню
CapBridge:      ; -----------------------------------------
                ; загрузка текста "командного мостика"
                ; -----------------------------------------             
.Functor        ; функция загрузки
                LD A, Page.CaptainBridge                                        ; страница 
                LD DE, (Adr.Module.MsgText - Adr.Module.CaptainBridge) | #C000  ; адрес текста
                JP FileSystem.Base.PrimaryRead

.Filename       FFile { {MsgTextEnName}, TextExt }                              ; имя файла английского языка меню
                FFile { {MsgTextRuName}, TextExt }                              ; имя файла русского языка меню
                FFile { {MsgTextSpName}, TextExt }                              ; имя файла испанского языка меню
; -----------------------------------------
; поиск загружаемого языка
; In:
;   A - номер языка
;       0 - русский
;       1 - испанский
;       2 - английский
;   HL - адрес функции загрузки
;   DE - адрес массива файлов локализации
; Out:
;   флаг переполнения Carry сброшен при успешном поиске
; Corrupt:
; Note:
; -----------------------------------------
@FindLoadText:  ; инициализация
                SET_PAGE_FILE_SYS                                               ; включить страницу файловой системы
                CALL FileSystem.Base.Setup                                      ; инициализация файловой системы

                ; адрес завершения работы с файловой системой
                LD BC, FileSystem.Base.Shutdown   
                PUSH BC
                PUSH HL

                ; поиск файла в каталоге
                LD HL, -FFile
                ADD HL, DE

                ; проверим валидность загружаемого языка
                LD A, (ConfigOptions)
                AND LANGUAGE_MASK
                JR NZ, .IsValid

                ; установка дефолтного языка
                LD A, LANGUAGE_DEFAULT

.IsValid        LD B, A
                LD DE, FFile

.FileNameLoop   ADD HL, DE
                DJNZ .FileNameLoop
                CALL FileSystem.Base.FindFile
                RET

                display " - Load Text : \t\t", /A, SetLanguage, " = busy [ ", /D, $ - SetLanguage, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_MAIN_LOAD_TEXT_
