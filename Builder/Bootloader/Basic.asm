
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
                ; загрузка кернеля
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
                LD HL, Adr.Module.FileSystem                                    ; установка адреса загрузки
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
.Address        EQU $
                ; расчёт адреса .FileArray
                LD HL, .FileArray-.Address
                LD BC, (ReturnAddress)
                ADD HL, BC

                ; адрес запуска
                LD BC, Adr.Module.Main
                PUSH BC

                ; количество загружаемых файлов
                LD A, .FileNum
                PUSH AF

                ; сохранение адреса .FileArray
                PUSH HL

                ; установка дефолтной конфигурации
                LD HL, .DefaultConfig-.Address
                LD BC, (ReturnAddress)
                ADD HL, BC
                LD DE, GameConfigRef
                LD BC, FConfig
                LDIR

                ; вызов загрузчика пакета файлов
                JP LoadModule.Loader

.DefaultConfig  FConfig {
                VK_ENTER,                                                       ; клавиша по умолчанию "меню/пауза" (0)
                VK_CAPS_SHIFT,                                                  ; клавиша по умолчанию "ускорить"
                VK_SYMBOL_SHIFT,                                                ; клавиша по умолчанию "oтмена"
                VK_SPACE,                                                       ; клавиша по умолчанию "выбор"
                VK_D,                                                           ; клавиша по умолчанию "вправо"
                VK_A,                                                           ; клавиша по умолчанию "влево"
                VK_S,                                                           ; клавиша по умолчанию "вниз"
                VK_W,                                                           ; клавиша по умолчанию "вверх"
                0,                                                              ; минимальная скорость курсора
                0,                                                              ; максимальная скорость курсора
                DURATION_TILEMAP_SCROLL,                                        ; скорость скрола тайловой карты
                LANGUAGE_DEFAULT | INPUT_MOUSE,                                 ; флаги
                1                                                               ; слот уровня
                }

.FileArray      ; путь файла модуля языка
                FFileArea {
                {{LanguageName}, LanguageExt },
                Page.Module.Language | FILE_ARCHIVE,
                Adr.Module.Language }

                ; путь файла работы с меню
                FFileArea {
                {{MenuCoreName}, CodeExt },
                Page.Core | FILE_ARCHIVE,
                Adr.Module.Core }

                ; путь файла "опций"
                FFileArea {
                {{MenuOptionsName}, CodeExt },
                Page.Options | FILE_ARCHIVE,
                Adr.Module.Options }

                ; путь файла "главного меню"
                FFileArea {
                {{MenuMainName}, CodeExt },
                Page.Main | FILE_ARCHIVE,
                Adr.Module.Main }

                ; путь файла "капитанский мостик"
                FFileArea {
                {{CaptainBridgeName}, CodeExt },
                Page.CaptainBridge | FILE_ARCHIVE,
                /*Adr.Module.CaptainBridge*/ #C000 }

                ; путь файла графические файлы для "капитанский мостик"
                FFileArea {
                {{CaptainBridgeGraphicsAName}, GraphicsExt },
                Page.Graphics.A | FILE_ARCHIVE,
                Adr.Module.Graphics.A }

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

                display "Basic : \t\t\t\t\t\t", /A, Begin, " = busy [ ", /D, Size, " bytes  ]"

                endif ; ~_BUILDER_BOOTLOADER_
