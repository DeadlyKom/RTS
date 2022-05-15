
                ifndef _CORE_MODULE_FILE_SYSTEM_READ_
                define _CORE_MODULE_FILE_SYSTEM_READ_      
; -----------------------------------------
; последовательное чтение даннх из файла
; In:
;   A  - страница
;   DE - адрес назначения
;   BC - длина блока
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

                ; корректировка смещения адреса назначения
                LD HL, (.Destination)
.OffsetDest     EQU $+1
                LD DE, (.SectorSize)
                ADD HL, DE
                LD (.Destination), HL

                ; обновим размер буфера
                LD HL, SharedBufferSize
                LD (.SectorSize), HL
                ; обнулим смещение
                LD HL, SharedBuffer
                LD (.SharedBuffer), HL
                JR .SkipAjustment

.SkipReadSector ; чтение сектора не требуется

                ; корректировка смещения в буфере
                EX DE, HL
                LD HL, SharedBufferSize
                OR A 
                SBC HL, DE
                LD BC, SharedBuffer
                ADD HL, BC
                LD (.SharedBuffer), HL

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
                LD A, FileSystemPage
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
                LD B, #01                                                       ; один сектор == SharedBufferSize
                LD C, TRDOS.RD_SECTORS
                JP TRDOS.EXE_CMD

                endif ; ~ _CORE_MODULE_FILE_SYSTEM_READ_
