
                ifndef _CORE_MODULE_LOADER_SAVER_
                define _CORE_MODULE_LOADER_SAVER_

                module Saver
; -----------------------------------------
; заставка
; In:
;   SP-2 - указывает массив FFileArea загружаемых данных
;   SP-4 - старший байт количество файлов
;   SP-6 - адрес функции завершения работы с TR-DOS
;   SP-8 - адрес запуска
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Saver:          ; -----------------------------------------
                ; загрузочный экран
                ; -----------------------------------------

                ; подготовка экрана
                SET_SCREEN_SHADOW
                CLS_C000
                ATTR_C000_IP WHITE, BLACK

                ; отрисовка надпись Loading
                LD HL, Loader.LoadingSprAttr
                LD DE, SharedBuffer
                CALL Loader.Decompressor.Forward
                DrawSpriteATTR SharedBuffer, 2, 20, 8, 2

                ; отображение прогресса
                LD HL, Loader.ProgressSprAttr
                LD DE, SharedBuffer
                CALL Loader.Decompressor.Forward
                DrawSpriteATTR SharedBuffer, 1, 22, 10, 1

                ; переключение экране на теневой экран
                SET_SCREEN_C000

                ; -----------------------------------------
                ; инициализация
                ; -----------------------------------------
                SET_PAGE_FILE_SYS                                               ; включить страницу файловой системы
                LD IX, FileSystem.Base.Variables                                ; адрес переменных FileSystem

                ; установка дефолтного адрес функции прогресса
                LD HL, Loader.Progress.Update
                LD (IX + FVariables.FuncProgress), HL

                POP HL                                                          ; адрес массива FFileArea загружаемых данных
                ; LD (IX + FVariables.PackageAddress), HL

                POP AF                                                          ; A - количество файлов в пакете
                LD (IX + FVariables.NumFilesPackage.Low), A
                LD (IX + FVariables.NumFilesPackage.High), A

                XOR A
                LD (IX + FVariables.PackageSizeSec), A                          ; обнуление пакета загружаемых файлов
                LD (IX + FVariables.Progress.Low), A                            ; обнеление прогресса загрузки
                LD (IX + FVariables.Progress.High), A                           ; обнеление прогресса загрузки

                PUSH HL

                ; -----------------------------------------
                ; расчёт загружаемых файлов
                ; -----------------------------------------

.SizeLoop       ; поиск файла в каталоге
                PUSH HL
                CALL FileSystem.Base.FindFile
                JR C, .NextFile                                                 ; файла нет на диске, переход к следующему

.FileInfo       ; добавление размера файла в секторах к загружаемому пакету
                LD A, (TRDOS.SIZE_S)
                ADD A, (IX + FVariables.PackageSizeSec)
                LD (IX + FVariables.PackageSizeSec), A

                ifdef _DEBUG
                JR C, $                                                         ; произошло переполнение
                endif

.NextFile       ; переход к следующему файлу в массиве
                POP HL
                LD BC, FFileArea
                ADD HL, BC
                DEC (IX + FVariables.NumFilesPackage.Low)
                JR NZ, .SizeLoop

                ; -----------------------------------------
                ; расчёт шкалы
                ; -----------------------------------------
                LD A, ProgressLength
                LD C, (IX + FVariables.PackageSizeSec)
                CALL Loader.Math.DivFix8x8
                LD (IX + FVariables.ProgressStep), DE                           ; установка шага прогресса

                ; -----------------------------------------
                ; загрузка пакета файлов
                ; -----------------------------------------

                POP HL                                                          ; FVariables.PackageAddress

.LoadLoop       ; поиск файла в каталоге 
                PUSH HL
                CALL FileSystem.Base.FindFile
                JR C, .LoadNextFile                                             ; файла нет на диске, переход к следующему       

                ; загрузка файла
                EX (SP), IY
                LD A, (IY + FFileArea.Info)                                     ; страница свойств поверхности
                LD DE, (IY + FFileArea.Address)                                 ; адрес загрузчика
                LD BC, (TRDOS.SIZE_B)                                           ; размер свойств поверхности
                EX (SP), IY
                CALL FileSystem.Base.PrimaryRead

.LoadNextFile   ; переход к следующему файлу в массиве
                POP HL
                LD BC, FFileArea
                ADD HL, BC
                DEC (IX + FVariables.NumFilesPackage.High)
                JR NZ, .LoadLoop

                RET

                display " - Saver : \t\t\t", /A, Saver, " = busy [ ", /D, $ - Saver, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_LOADER_SAVER_