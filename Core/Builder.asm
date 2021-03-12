
                page 0
                ORG #4000

                module Boot
Basic:          DB #00, #0A                                     ; номер строки 10
                DW EndBoot - StartBoot + 2                      ; длина строки
                DB #EA                                          ; команда REM
StartBoot:      DI
                LD SP, StackTop
                ; Чтение данных в 0 страницу
                LD BC, PORT_7FFD
                LD A, %00010000
                OUT (C), A
                LD HL, Page_0                                   ; загружаем по адресу Page_0
                LD DE, (#5CF4)                                  ; загружаем позицию головки дисковода из системной переменн
                LD B, (SizePage_0 >> 8) + 1                     ; регистр B содержит кол-во секторов
                LD C, #05                                       ; регистр С — номер подпрограммы #05 (чтение секторов)
                CALL #3D13                                      ; переход в TR-DOS
                ; Чтение данных в 1 страницу
                LD BC, PORT_7FFD
                LD A, %00010001
                OUT (C), A
                LD HL, Page_1                                   ; загружаем по адресу Page_1
                LD DE, (#5CF4)                                  ; загружаем позицию головки дисковода из системной переменн
                LD B, (SizePage_1 >> 8) + 1                     ; регистр B содержит кол-во секторов
                LD C, #05                                       ; регистр С — номер подпрограммы #05 (чтение секторов)
                CALL #3D13                                      ; переход в TR-DOS
                ; Чтение данных в 2 страницу
                ;LD BC, PORT_7FFD
                ;LD A, %00010010
                ;OUT (C), A
                LD HL, Page_2                                   ; загружаем по адресу Page_2
                LD DE, (#5CF4)                                  ; загружаем позицию головки дисковода из системной переменн
                LD B, (SizePage_2 >> 8) + 1                     ; регистр B содержит кол-во секторов
                LD C, #05                                       ; регистр С — номер подпрограммы #05 (чтение секторов)
                CALL #3D13                                      ; переход в TR-DOS
                ; Чтение данных в 3 страницу
                LD BC, PORT_7FFD
                LD A, %00010011
                OUT (C), A
                LD HL, Page_3                                   ; загружаем по адресу Page_3
                LD DE, (#5CF4)                                  ; загружаем позицию головки дисковода из системной переменн
                LD B, (SizePage_3 >> 8) + 1                     ; регистр B содержит кол-во секторов
                LD C, #05                                       ; регистр С — номер подпрограммы #05 (чтение секторов)
                CALL #3D13                                      ; переход в TR-DOS
                ; Чтение данных в 4 страницу
                LD BC, PORT_7FFD
                LD A, %00010100
                OUT (C), A
                LD HL, Page_4                                   ; загружаем по адресу Page_4
                LD DE, (#5CF4)                                  ; загружаем позицию головки дисковода из системной переменн
                LD B, (SizePage_4 >> 8) + 1                     ; регистр B содержит кол-во секторов
                LD C, #05                                       ; регистр С — номер подпрограммы #05 (чтение секторов)
                CALL #3D13                                      ; переход в TR-DOS
                ; Чтение данных в 6 страницу
                LD BC, PORT_7FFD
                LD A, %00010110
                OUT (C), A
                LD HL, Page_6                                   ; загружаем по адресу Page_6
                LD DE, (#5CF4)                                  ; загружаем позицию головки дисковода из системной переменн
                LD B, (SizePage_6 >> 8) + 1                     ; регистр B содержит кол-во секторов
                LD C, #05                                       ; регистр С — номер подпрограммы #05 (чтение секторов)
                CALL #3D13                                      ; переход в TR-DOS
                ; Чтение данных в 7 страницу
                LD BC, PORT_7FFD
                LD A, %00010111
                OUT (C), A
                LD HL, Page_7                                   ; загружаем по адресу Page_7
                LD DE, (#5CF4)                                  ; загружаем позицию головки дисковода из системной переменн
                LD B, (SizePage_7 >> 8) + 0                     ; регистр B содержит кол-во секторов
                LD C, #05                                       ; регистр С — номер подпрограммы #05 (чтение секторов)
                CALL #3D13                                      ; переход в TR-DOS
                ; Чтение данных в 5 страницу
                ;LD BC, PORT_7FFD
                ;LD A, %00010101
                ;OUT (C), A
                LD HL, MemoryPage_5.GameEntry
                PUSH HL
                LD HL, Page_5                                   ; загружаем по адресу Page_5
                LD DE, (#5CF4)                                  ; загружаем позицию головки дисковода из системной переменн
                LD B, (SizePage_5 >> 8) + 1                     ; регистр B содержит кол-во секторов
                LD C, #05                                       ; регистр С — номер подпрограммы #05 (чтение секторов)
                JP #3D13                                        ; переход в TR-DOS                
EndBoot:
                DB #0D                                          ; конец строки

                DB #00, #14                                     ; номер строки 20
                DB #2A, #00                                     ; длина строки 42 байта
                DB #F9                                          ; RANDOMIZE
                DB #C0                                          ; USE
                DB #28                                          ; (
                DB #BE                                          ; PEEK
                DB #B0                                          ; VAL
                DB #22                                          ; "
                DB #32, #33, #36, #33, #36                      ; 23636
                DB #22                                          ; "
                DB #2A                                          ; *
                DB #32, #35, #36                                ; 256
                DB #0E, #00, #00, #00, #01, #00                 ; значение 256
                DB #2B                                          ; +
                DB #BE                                          ; PEEK
                DB #B0                                          ; VAL
                DB #22                                          ; "
                DB #32, #33, #36, #33, #35                      ; 23635
                DB #22                                          ; "
                DB #2B                                          ; +
                DB #35                                          ; 5
                DB #0E, #00, #00, #05, #00, #00                 ; значение 5
                DB #29                                          ; )
                DB #0D                                          ; конец строки
EndBasic:
                endmodule

                display "-------------------------------------------------------------------------"
                display "Boot  :  ", /A, Boot.Basic, " = [ ", /D, Boot.EndBasic - Boot.Basic, " bytes ]"
                display "Page 0:  ", /A, Page_0, " = busy [ ", /D, SizePage_0, " bytes ]", "\t /    free [ ", /D, 0x4000 - SizePage_0 - Page_0 & 0x3FFF, " bytes ]"
                display "Page 1:  ", /A, Page_1, " = busy [ ", /D, SizePage_1, " bytes ]", "\t /    free [ ", /D, 0x4000 - SizePage_1 - Page_1 & 0x3FFF, " bytes ]"
                display "Page 2:  ", /A, Page_2, " = busy [ ", /D, SizePage_2, " bytes ]", "\t /    free [ ", /D, 0x4000 - SizePage_2 - Page_2 & 0x3FFF, " bytes ]"
                display "Page 3:  ", /A, Page_3, " = busy [ ", /D, SizePage_3, " bytes ]", "\t /    free [ ", /D, 0x4000 - SizePage_3 - Page_3 & 0x3FFF, " bytes ]"
                display "Page 4:  ", /A, Page_4, " = busy [ ", /D, SizePage_4, " bytes ]", "\t /    free [ ", /D, 0x4000 - SizePage_4 - Page_4 & 0x3FFF, " bytes ]"
                display "Page 5:  ", /A, Page_5, " = busy [ ", /D, SizePage_5, " bytes ]", "\t /    free [ ", /D, 0x4000 - SizePage_5 - Page_5 & 0x3FFF, " bytes ]"
                display "Page 6:  ", /A, Page_6, " = busy [ ", /D, SizePage_6, " bytes ]", "\t /    free [ ", /D, 0x4000 - SizePage_6 - Page_6 & 0x3FFF, " bytes ]"
                display "Page 7:  ", /A, Page_7, " = busy [ ", /D, SizePage_7, " bytes ]", "\t /    free [ ", /D, 0x4000 - SizePage_7 - Page_7 & 0x3FFF, " bytes ]"
                display "-------------------------------------------------------------------------"

                emptytrd TRD_FILENAME
                savetrd  TRD_FILENAME, "boot.B", Boot.Basic, Boot.EndBasic - Boot.Basic
                page 0
                savetrd  TRD_FILENAME, "Page0.C", Page_0, SizePage_0        ; bank 03
                page 1
                savetrd  TRD_FILENAME, "Page1.C", Page_1, SizePage_1        ; bank 03
                page 2
                savetrd  TRD_FILENAME, "Page2.C", Page_2, SizePage_2        ; bank 02
                page 3
                savetrd  TRD_FILENAME, "Page3.C", Page_3, SizePage_3        ; bank 03
                page 4
                savetrd  TRD_FILENAME, "Page4.C", Page_4, SizePage_4        ; bank 03 
                page 6
                savetrd  TRD_FILENAME, "Page6.C", Page_6, SizePage_6        ; bank 03
                page 7
                savetrd  TRD_FILENAME, "Page7.C", Page_7, SizePage_7        ; bank 03
                page 5
                savetrd  TRD_FILENAME, "Page5.C", Page_5, SizePage_5        ; bank 01
