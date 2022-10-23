
                ifndef _CORE_MODULE_FILE_SYSTEM_LOAD_LEVEL_INFO_
                define _CORE_MODULE_FILE_SYSTEM_LOAD_LEVEL_INFO_
; -----------------------------------------
; загрузка информации об уровне
; In:
;   LevelSlotRef - номер уровня
; Out:
;   HL - адрес структуры FLevelInfo (указанного уровня)
;   флаг переполнения Carry сброшен при успешном поиске уровня
; Corrupt:
; Note:
; -----------------------------------------
Info:           ; поиск файла списка уровней в каталоге
                LD HL, .FileName
                CALL FileSystem.Base.FindFile
                RET C                                                           ; файла нет на диске, выход

                ; -----------------------------------------
                ; загрузка файла списка уровней
                ; -----------------------------------------
                LD A, Page.Loader                                               ; страница
                LD DE, LoaderBuffer                                             ; адрес загрузки
                LD BC, (TRDOS.SIZE_B)                                           ; размер файла в байтах
                CALL FileSystem.Base.PrimaryRead

                ; -----------------------------------------
                ; расчёт адреса имени файла
                ; -----------------------------------------
                LD HL, LoaderBuffer - FLevelInfo
                LD DE, FLevelInfo
.SlotInfo       EQU $+1
                LD A, (GameConfig.LevelSlot)
                INC A
                LD B, A
                ADD HL, DE
                DJNZ $-1

                ; успешное выполнение
                OR A
                RET

.FileName       FFile { {LevelsName}, LevelsExt }                               ; имя файла хранящий имена всех уровнях

                display " - Load Level Info : \t\t\t\t\t", /A, Info, " = busy [ ", /D, $ - Info, " bytes  ]"

                endif ; ~ _CORE_MODULE_FILE_SYSTEM_LOAD_LEVEL_INFO_
