
                ifndef _CORE_MODULE_FILE_SYSTEM_LOAD_MAP_INFO_
                define _CORE_MODULE_FILE_SYSTEM_LOAD_MAP_INFO_
; -----------------------------------------
; загрузка информации о карте
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
MapInfo:        ; копирование данных в область переменных
                LD HL, .MapInfoName
                LD C, TRDOS.SET_NAME
                CALL TRDOS.EXE_CMD

                ; поиск файла
                LD C, TRDOS.FIND_FILE
                CALL TRDOS.EXE_CMD

                ; по найденому файлу проинициализируем информацию о расположении файла
                LD A, C
                LD C, TRDOS.RD_FILE_INFO
                CALL TRDOS.EXE_CMD

                ; производим загрузку файла
                XOR A
                LD (#5CF9), A

                ; загрузка информации о карте во временный буфер
                DEC A
                LD HL, SharedBuffer
                LD C, TRDOS.LOAD_VERIFY
                CALL TRDOS.EXE_CMD             

                RET

.MapInfoName    BYTE MAP_INFO_FILENAME

                endif ; ~ _CORE_MODULE_FILE_SYSTEM_LOAD_MAP_INFO_