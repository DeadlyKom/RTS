
                ifndef _CORE_MODULE_FILE_SYSTEM_BASE_SETUP_
                define _CORE_MODULE_FILE_SYSTEM_BASE_SETUP_      
; -----------------------------------------
; настройка TR-DOS
; In:
; Out:
; Corrupt:
;   BC, IY, AF
; Note:
; -----------------------------------------
Setup:          ; сохранение IY
                LD (Shutdown.ContainerIY), IY

                ; настройка дефолтных переменных TR-DOS
                LD A, #FF
                LD (IY + 0), A                                                  ; отсутствие ошибок BASIC
                LD (TRDOS.BUFF_FLAG), A                                         ; отключение выделения буфера ввода/вывода
                LD (TRDOS.DRIVE_A), A                                           ; 80 дорожечный, двухсторонний дисковод
                LD A, #C9
                LD (TRDOS.WITH_RET), A                                          ; востановление RET

                LD A, TRDOS.FILE_LENGTH                                         ; размер имени файла + расширение
                LD (TRDOS.NAME_LENGTH), A

.TR_DOS         LD IY, BASIC.ERR_NR
                IM 1

.FileSystem     LD IX, FileSystem.Base.Variables                                ; адрес переменных FileSystem

                ; установка дефолтного адрес функции прогресса (RET)
                LD BC, FileSystem.Base.FindFile.RET
                LD (IX + FVariables.FuncProgress), BC

                RET

                display " - Setup : \t\t\t", /A, Setup, " = busy [ ", /D, $ - Setup, " bytes  ]"

                endif ; ~ _CORE_MODULE_FILE_SYSTEM_BASE_SETUP_
