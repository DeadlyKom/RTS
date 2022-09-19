
                ifndef _CORE_MODULE_LOADER_SAVER_PROGRESS_
                define _CORE_MODULE_LOADER_SAVER_PROGRESS_

                module Progress
; -----------------------------------------
; функция обновления прогресса
; In:
;   IX - указывает на структуру переменных файловой системы FVariables
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Update:         ; -----------------------------------------
                ; приращение прогресса
                ; -----------------------------------------
                LD HL, (IX + FVariables.Progress)
                LD DE, (IX + FVariables.ProgressStep)
                ADD HL, DE
                LD (IX + FVariables.Progress), HL

                SET_SCREEN_SHADOW                                               ; включение страницы теневого экрана

                ; -----------------------------------------
                ; обновление прогресса на экране
                ; -----------------------------------------
                LD DE, LoadProgress
                EX DE, HL
                INC D

.Loop           LD A, D
                CP #08
                JR C, .Less

                LD (HL), #FF
                INC H
                LD (HL), #FF
                DEC H
                INC L

                SUB #08
                LD D, A
                JR .Loop

.Less           OR A
                JP Z, FileSystemFunc                                            ; включение страницы файловой системы

                ; расчёт рисуемого байта прогресса
                LD A, D
                RRA
                CPL
                AND #03
                INC A
                LD B, A
                LD A, #FF
                JR Z, .SkipRoll

.Roll           ADD A, A
                ADD A, A
                DJNZ .Roll
.SkipRoll       RR D

                JR NC, .SkipDown
                INC H

.SkipDown       LD D, A
                EX AF, AF'
                LD A, (HL)
                OR D
                LD (HL), A
                EX AF, AF'

                INC H

                JR NC, .SkipLShift
                DEC H
                DEC H

                ADD A, A
                ADD A, A

.SkipLShift     OR (HL)
                LD (HL), A

                JP FileSystemFunc                                               ; включение страницы файловой системы

                display " - Progress : \t\t\t", /A, Update, " = busy [ ", /D, $ - Update, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_LOADER_SAVER_PROGRESS_
