
                ifndef _BUILDER_BOOTLOADER_
                define _BUILDER_BOOTLOADER_
; -----------------------------------------
; boot загрузчик
; In:
; Out:
; Corrupt:
; Note:
;   #5D40
; -----------------------------------------
Basic:          DB #00, #0A                                                     ; номер строки 10
                DW EndBoot - StartBoot + 2                                      ; длина строки
                DB #EA                                                          ; команда REM
StartBoot:      DI

                ; отключение 128 бейсика
                Disable_128k_Basic
                LD SP, StackTop

                ; -----------------------------------------
                ; загрузка кернела
                ; -----------------------------------------
                LD HL, Adr.Kernel                                               ; установка адреса загрузки
                LD DE, (TRDOS.CUR_SEC)                                          ; загружаем позицию головки дисковода из системной переменн
                LD BC, Kernel.SizeInSectors << 8 | TRDOS.RD_SECTORS             ; регистр B содержит кол-во секторов
                                                                                ; регистр С — номер подпрограммы #05 (чтение секторов)
                CALL TRDOS.EXE_CMD                                              ; переход в TR-DOS

                ; -----------------------------------------
                ; загрузка файловой системы
                ; -----------------------------------------
                SET_PAGE_FILE_SYS                                               ; включить страницу файловой системы
                LD HL, Adr.FileSystem                                           ; установка адреса загрузки
                LD DE, (TRDOS.CUR_SEC)                                          ; загружаем позицию головки дисковода из системной переменн
                LD BC, FileSystem.SizeInSectors << 8 | TRDOS.RD_SECTORS         ; регистр B содержит кол-во секторов
                                                                                ; регистр С — номер подпрограммы #05 (чтение секторов)
                CALL TRDOS.EXE_CMD                                              ; переход в TR-DOS

                ; -----------------------------------------
                ; инициализация прерывания
                ; -----------------------------------------
                include "../../Core/Module/Interrupt/Initialize.asm"

                ; -----------------------------------------
                ; запуск загрузчика
                ; -----------------------------------------
.Loader         EQU $
                ; расчёт текущего адрес
                LD BC, (ReturnAddress)
                LD IX, .FileArray-.Loader
                ADD IX, BC
                
                ; адрес запуска
                LD HL, Adr.MainMenu
                PUSH HL

                ; количество загружаемых файлов
                LD A, .FileNum
                PUSH AF

                ; вызов загрузчика пакета файлов
                JP LoadModule.Loader

.FileArray      ; путь файла главного меню
                FFileArea {
                {{MainMenuName}, SystemExt },
                (MainMenuPage << FILE_PAGE_SHIFT) | FILE_ARCHIVE,
                Adr.MainMenu }

                ; путь файла
                FFileArea {
                {{MainMenuName}, SystemExt },
                MainMenuPage << FILE_PAGE_SHIFT,
                Adr.MainMenu }
.FileNum        EQU ($-.FileArray) / FFileArea
EndBoot:        DB #0D                                                          ; конец строки
                DB #00, #14                                                     ; номер строки 20
                DB #2A, #00                                                     ; длина строки 42 байта
                DB #F9                                                          ; RANDOMIZE
                DB #C0                                                          ; USE
                DB #28                                                          ; (
                DB #BE                                                          ; PEEK
                DB #B0                                                          ; VAL
                DB #22                                                          ; "
                DB #32, #33, #36, #33, #36                                      ; 23636
                DB #22                                                          ; "
                DB #2A                                                          ; *
                DB #32, #35, #36                                                ; 256
                DB #0E, #00, #00, #00, #01, #00                                 ; значение 256
                DB #2B                                                          ; +
                DB #BE                                                          ; PEEK
                DB #B0                                                          ; VAL
                DB #22                                                          ; "
                DB #32, #33, #36, #33, #35                                      ; 23635
                DB #22                                                          ; "
                DB #2B                                                          ; +
                DB #35                                                          ; 5
                DB #0E, #00, #00, #05, #00, #00                                 ; значение 5
                DB #29                                                          ; )
                DB #0D                                                          ; конец строки

                display "Basic : \t\t\t", /A, Begin, " = busy [ ", /D, Size, " bytes  ]"

                endif ; ~_BUILDER_BOOTLOADER_
