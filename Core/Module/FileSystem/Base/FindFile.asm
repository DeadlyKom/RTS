
                ifndef _CORE_MODULE_FILE_SYSTEM_BASE_FIND_FILE_
                define _CORE_MODULE_FILE_SYSTEM_BASE_FIND_FILE_
; -----------------------------------------
; поиск файла в каталоге
; In:
;   HL - указывает на имя файла (длина имени 8 байт и расширение 1 байт)
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
.RET            RET

.InitFile       ; по найденому файлу проинициализируем информацию о расположении файла
                LD C, TRDOS.RD_FILE_INFO
                CALL TRDOS.EXE_CMD

                ; успешное выполнение
                OR A
                RET

                display " - FindFile : \t\t", /A, FindFile, " = busy [ ", /D, $ - FindFile, " bytes  ]"
                
                endif ; ~ _CORE_MODULE_FILE_SYSTEM_BASE_FIND_FILE_
