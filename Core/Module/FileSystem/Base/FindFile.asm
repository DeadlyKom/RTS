
                ifndef _CORE_MODULE_FILE_SYSTEM_FIND_FILE_
                define _CORE_MODULE_FILE_SYSTEM_FIND_FILE_
; -----------------------------------------
; поиск файла в каталоге
; In:
;   HL - указывает на имя файла (длина имени 9 байт)
; Out:
;   флаг переполнения Carry сброшен при успешном поиске
; Corrupt:
; Note:
; -----------------------------------------
FindFile:       ; копирование данных в область переменных
                LD C, TRDOS.SET_NAME
                CALL TRDOS.EXE_CMD

                ; поиск файла
                LD C, TRDOS.FIND_FILE
                CALL TRDOS.EXE_CMD

                LD A, C
                CP #FF
                JR NZ, .InitFile

                ; неудачный выход
                SCF
                RET

.InitFile       ; по найденому файлу проинициализируем информацию о расположении файла
                LD C, TRDOS.RD_FILE_INFO
                CALL TRDOS.EXE_CMD

                ; инициализация последовательного чтения файла
                LD HL, (TRDOS.FIRST_S)
                LD (TRDOS.CUR_SEC), HL

                ; успешное выполнение
                OR A
                RET
                

                endif ; ~ _CORE_MODULE_FILE_SYSTEM_FIND_FILE_