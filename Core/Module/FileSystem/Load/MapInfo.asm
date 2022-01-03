
                ifndef _CORE_MODULE_FILE_SYSTEM_LOAD_MAP_INFO_
                define _CORE_MODULE_FILE_SYSTEM_LOAD_MAP_INFO_
; -----------------------------------------
; загрузка информации о карте
; In:
;   A - номер карты
; Out:
; Corrupt:
; Note:
; -----------------------------------------
MapInfo:        ; подготовим номер слота
                INC A
                LD (.SlotInfo), A

                ; копирование данных в область переменных
                LD HL, FileSystem.FileNameInfo
                CALL FileSystem.FindFile
                RET C

                ; производим загрузку файла
                XOR A
                LD (#5CF9), A

                ; загрузка информации о карте во временный буфер
                DEC A
                LD HL, RenderBuffer
                LD C, TRDOS.LOAD_VERIFY
                CALL TRDOS.EXE_CMD

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

                endif ; ~ _CORE_MODULE_FILE_SYSTEM_LOAD_MAP_INFO_