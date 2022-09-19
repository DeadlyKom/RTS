
                module VFX
@VFX_DEFAULT    EQU 0x00
@VFX_GLITCH_A   EQU 0x01
@VFX_GLITCH_B   EQU 0x02
@VFX_ROLL_A     EQU 0x03
@VFX_ROLL_B     EQU 0x04
@VFX_FADEIN     EQU 0x05
@VFX_FADEOUT    EQU 0x06

Table:          DW DefaultVisible, DefaultVisible.Timeline
                DW Glitch_A, Glitch_A.Timeline
                DW Glitch_B, Glitch_B.Timeline
                DW Roll_A, Roll_A.Timeline
                DW Roll_B, Roll_B.Timeline
                DW Fadein, Fadein.Timeline
                DW Fadeout, Fadeout.Timeline

                ; 0 - отсутствие изменений (применения ранее установленные занчения)
                ; 1 - отсутствие модификации изображения (NOP)
                ; 2 - RRA (х1)
                ; 3 - RRA (х2)
                ; 4 - RLA (х1) - не обновляет
                ; 5 - RLA (х2) - не обновляет
                ; 6 - AND + 1 байт значение
                ; 7 - OR  + 1 байт значение
                ; 8 - XOR + 1 байт значение

DefaultVisible: DB #10, #00, #00, #00, #00, #00, #00, #00
.Timeline       DB #02                                                          ; количество фреймов + 1
                DB #01                                                          ; время проигрывания фреймf (20 мс),
                                                                                ; проигрывание производится с конца
Glitch_A:       DB #10, #00, #20, #10, #00, #00, #00, #00                       ; 1
                DB #00, #60, #00, #00, #00, #10, #60, #00, #10, #00             ; 2
                DB #00, #00, #44, #00, #00, #00, #00, #00                       ; 3
                DB #00, #60, #00, #00, #10, #60, #00, #00, #00, #10             ; 4
                DB #00, #00, #00, #00, #44, #00, #20, #10                       ; 5
                DB #00, #00, #00, #00, #00, #00, #00, #00                       ; 6

.Timeline       DB #07                                                          ; количество фреймов + 1
                DB #03, #04, #03, #04, #03, #04                                 ; время проигрывания фреймf (20 мс),
                                                                                ; проигрывание производится с конца
Glitch_B:       DB #10, #00, #20, #10, #20, #10, #00, #00                               ; 1
                DB #00, #60, #54, #60, #33, #60, #55, #60, #2A, #60, #54, #60, #2A, #35 ; 2
                DB #00, #00, #44, #60, #2A, #10, #55, #00, #60, #25                     ; 3
                DB #00, #60, #00, #60, #06, #30, #60, #2A, #60, #18, #60, #00, #35      ; 4
                DB #00, #00, #20, #55, #44, #10, #20, #53                               ; 5
                DB #00, #00, #00, #00, #00, #00, #00, #00                               ; 6

.Timeline       DB #07                                                          ; количество фреймов + 1
                DB #03, #04, #03, #04, #03, #04                                 ; время проигрывания фреймf (20 мс),
                                                                                ; проигрывание производится с конца
Roll_A:         DB #10, #00, #44, #20, #10, #44, #00, #00                       ; 1
                DB #00, #00, #00, #00, #55, #20, #10, #00                       ; 2
                DB #00, #00, #00, #00, #00, #00, #00, #00                       ; 3

.Timeline       DB #04                                                          ; количество фреймов + 1
                DB #05, #04, #05                                                ; время проигрывания фреймf (20 мс),
                                                                                ; проигрывание производится с конца
Roll_B:         DB #10, #00, #00, #44, #00, #20, #00, #10                       ; 1
                DB #00, #00, #00, #00, #00, #00, #00, #00                       ; 2

.Timeline       DB #03                                                          ; количество фреймов + 1
                DB #05, #05                                                     ; время проигрывания фреймf (20 мс),
                                                                                ; проигрывание производится с конца
Fadein:         DB #66, #AA, #55, #60, #00, #00, #00, #00, #00, #00, #00        ; 1
                DB #30, #66, #55, #AA, #60, #00, #00, #00, #00, #00, #00        ; 2
                DB #55, #20, #66, #AA, #55, #60, #00, #00, #00, #00, #00        ; 3
                DB #20, #30, #44, #66, #55, #AA, #60, #00, #00, #00, #00        ; 4
                DB #10, #44, #55, #20, #66, #AA, #55, #60, #00, #00, #00        ; 5
                DB #10, #00, #20, #55, #44, #66, #55, #AA, #60, #00, #00        ; 6
                DB #10, #00, #00, #00, #00, #20, #66, #AA, #55, #60, #00        ; 7
                DB #10, #00, #00, #00, #00, #00, #44, #66, #AA, #55             ; 8
                DB #10, #00, #00, #00, #00, #00, #00, #00                       ; 9
.Timeline       DB #0A                                                          ; количество фреймов + 1
                DB #02, #01, #02, #01, #02, #01, #02, #01, #02                  ; время проигрывания фреймf (20 мс),
                                                                                ; проигрывание производится с конца
Fadeout:        DB #10, #00, #60, #55, #20, #80, #88, #60, #AA, #10, #00        ; 1
                DB #50, #30, #60, #00, #10, #44, #00, #70, #22, #60, #00        ; 2
                DB #10, #20, #60, #00, #00, #70, #33, #60, #00, #10, #60, #00   ; 3
                DB #00, #55, #00, #24, #30, #60, #00, #00, #00                  ; 4
                DB #00, #00, #00, #00, #00, #00, #00, #00                       ; 5

.Timeline       DB #06                                                          ; количество фреймов + 1
                DB #03, #03, #03, #03, #03                                      ; время проигрывания фреймf (20 мс),
                                                                                ; проигрывание производится с конца

                ; XOR #00 ; #EE, #00    8 + 1
                ; AND #00 ; #E6, #00    6 + 1
                ; OR #00  ; #F6, #00    7 + 1
                ; RRA     ; #1F         2, 3
                ; RLA     ; #17         4, 5 - не обновляет

                display "\t- VFX : \t\t\t", /A, Table, " = busy [ ", /D, $ - Table, " bytes  ]"

                endmodule
