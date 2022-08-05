
                ifndef _CORE_MODULE_FILE_SYSTEM_BASE_READ_
                define _CORE_MODULE_FILE_SYSTEM_BASE_READ_
; -----------------------------------------
; последовательное чтение даннх из файла (первичный запуск)
; In:
;   A  - страница
;   DE - адрес назначения
;   IX - указывает на структуру переменных файловой системы FVariables
; Out:
; Corrupt:
; Note:
; -----------------------------------------
PrimaryRead:    ; размер файла
                LD BC, (TRDOS.SIZE_B)
                
; -----------------------------------------
; последовательное чтение даннх из файла (первичный запуск)
; In:
;   A  - страница
;   DE - адрес назначения
;   BC - длина блока (в байтах)
;   IX - указывает на структуру переменных файловой системы FVariables
; Out:
; Corrupt:
; Note:
; -----------------------------------------
.SetSize        EX AF, AF'

                LD HL, #0000
                LD (SequentialRead.SectorSize), HL
                
                ; инициализация последовательного чтения файла
                LD HL, (TRDOS.FIRST_S)
                LD (TRDOS.CUR_SEC), HL

                ; инициализация TR-DOS
                XOR A
                LD (TRDOS.ERROR), A

                EX AF, AF'

; -----------------------------------------
; последовательное чтение даннх из файла (послудующий запуск)
; In:
;   A  - страница
;   DE - адрес назначения
;   BC - длина блока (в байтах)
;   IX - указывает на структуру переменных файловой системы FVariables
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SequentialRead: ; подготовка чтения данных
                LD (.Page), A
                LD (.Destination), DE
                LD (.SizeBlok), BC

                ; проверим на необходимость чтения сектора
                LD HL, (.SectorSize)
                LD A, L
                OR H
                JR NZ, .SkipReadSector

.Continue       ; продолжение чтения
                CALL ReadSector                                                 ; чтения одного сектора

                ; вызов функции обновления прогресса
                LD HL, .ProgressRET
                PUSH HL                                                         ; сохранить адрес возврата
                LD HL, (IX + FVariables.FuncProgress)
                JP (HL)

.ProgressRET    ; корректировка смещения адреса назначения
                LD HL, (.Destination)
.OffsetDest     EQU $+1
                LD DE, (.SectorSize)
                ADD HL, DE
                LD (.Destination), HL

                ; обновим размер буфера
                LD HL, SharedBufSize
                LD (.SectorSize), HL

                ; обнулим смещение
                LD HL, SharedBuffer
                LD (.SharedBuffer), HL
                JR .SkipAjustment

.SkipReadSector ; чтение сектора не требуется

                ; корректировка смещения в буфере
                EX DE, HL
                LD HL, SharedBufSize
                OR A 
                SBC HL, DE
                LD BC, SharedBuffer
                ADD HL, BC
                LD (.SharedBuffer), HL

                ; добавить вызов функции обновления прогресса

.SkipAjustment  ; пропустить корректировку смещения в буфере
.SizeBlok       EQU $+1
                LD DE, #0000

.SectorSize     EQU $+1
                LD HL, #0000                                                    ; оставшиеся необработанные данные в буфере
                OR A
                SBC HL, DE
                JR Z, .Enough                                                   ; ровное значение
                JP P, .Enough                                                   ; данные остались в буфере
                ; в буфере недостаточно места

                ; расчитаем скольку данных необходимо в дальнейшем прочитать
                ADD HL, DE
                EX DE, HL
                OR A
                SBC HL, DE
                LD (.SizeBlok), HL                                              ; сохраним сколько данных осталось прочитать
                
                LD HL, .Continue
                PUSH HL
                JR .StartCopy

.Enough         LD (.SectorSize), HL                                            ; сохраним сколько данных осталось в буфере
.StartCopy      ; длина копируемого блока
                LD B, D
                LD C, E

                ; адресс общего буфере
.SharedBuffer   EQU $+1
                LD HL, #0000

                ; адрес назначения
.Destination    EQU $+1
                LD DE, #0000

                ; страницы копирования
.Page           EQU $+1
                LD A, #00
                EX AF, AF'
                LD A, Page.FileSystem
                JP MemcpyPages
; -----------------------------------------
; чтение текущего сектора во временный буфер
; In:
; Out:
; Corrupt:
; Note:
; размер сектора и временного буфера должны быть подходящими
; -----------------------------------------
ReadSector:     LD HL, SharedBuffer
                LD DE, (TRDOS.CUR_SEC)
                LD BC, (0x01 << 8) | TRDOS.RD_SECTORS                           ; один сектор == SharedBufferSize
                CALL TRDOS.EXE_CMD
                RET

                display " - Read : \t\t\t", /A, PrimaryRead, " = busy [ ", /D, $ - PrimaryRead, " bytes  ]"

                endif ; ~ _CORE_MODULE_FILE_SYSTEM_BASE_READ_
