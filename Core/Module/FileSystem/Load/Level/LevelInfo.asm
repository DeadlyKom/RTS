
                ifndef _CORE_MODULE_FILE_SYSTEM_LOAD_LEVEL_INFO_
                define _CORE_MODULE_FILE_SYSTEM_LOAD_LEVEL_INFO_
; -----------------------------------------
; загрузка информации об уровне
; In:
;   A - номер уровня
; Out:
; Corrupt:
; Note:
; -----------------------------------------
LevelInfo:      ; подготовим номер слота
                INC A
                LD (.SlotInfo), A

                ; поиск файла в каталоге
                LD HL, .FileName
                CALL FileSystem.Base.FindFile
                RET C                                                           ; файла нет на диске, выход

                ; загрузка файла
                LD A, (IY + FFileArea.Info)                                     ; страница
                LD DE, (IY + FFileArea.Address)                                 ; адрес загрузки
                LD BC, (TRDOS.SIZE_B)                                           ; размер файла в байтах
                CALL FileSystem.Base.PrimaryRead


                ;
                LD HL, RenderBuffer - FMap
                LD DE, FMap
.SlotInfo       EQU $+1
                LD B, #00
                ADD HL, DE
                DJNZ $-1

                ; копирование информацию о карты
                LD DE, SharedBuffer
                LD BC, FMap
                LDIR

                ; успешное выполнение
                OR A
                RET

                RET

.FileName       FFile { {LevelsName}, LevelsExt }                               ; имя файла хранящий имена всех уровнях

                endif ; ~ _CORE_MODULE_FILE_SYSTEM_LOAD_LEVEL_INFO_