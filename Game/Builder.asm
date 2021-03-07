
            DEVICE ZXSPECTRUM128

            include "Include.inc"

            ORG #4000
            module Boot
Basic:

            DB #00, #0A                                     ; номер строки 10
            DW EndBoot - StartBoot + 2                      ; длина строки
            DB #EA                                          ; команда REM
StartBoot:
            LD SP, StackTop
            LD HL, #6000                                    ; загружаем по адресу #6000
            LD DE, (#5CF4)                                  ; загружаем позицию головки дисковода из системной переменн
            LD B, ((MainLength >> 8) + 1)                   ; регистр B содержит кол-во секторов
            LD C, #05                                       ; регистр С — номер подпрограммы #05 (чтение секторов)
            CALL #3D13                                      ; переход в TR-DOS
            JP EntryPointer
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

            emptytrd TRD_FILENAME
	        savetrd  TRD_FILENAME, "boot.B", Boot.Basic, Boot.EndBasic - Boot.Basic

            savetrd  TRD_FILENAME, "main.C", EntryPointer, MainLength
