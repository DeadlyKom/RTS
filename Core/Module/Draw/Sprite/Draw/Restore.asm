
                ifndef _CORE_MODULE_DRAW_RESTORE_BACKGROUND_
                define _CORE_MODULE_DRAW_RESTORE_BACKGROUND_
; -----------------------------------------
; восстановление фона под спрайтом
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawRestore:    ; проверка необходимости обновления фона
                CHECK_RENDER_FLAG RESTORE_BIT
                RET Z

                ; сброс флага востановления фона
                RES_FLAG RESTORE_BIT                                            ; RES_RENDER_FLAG

                ; установка экрана востановления
                LD A, (Game.RestorePage)
                CALL SetPage
                
                ; инициализация
                EXX
                LD HL, CursorBuf
                LD B, #00
                EXX
                LD HL, (Game.RestoreScr)
                LD BC, (Game.RestoreSize)

                ; -----------------------------------------
                ;   HL  - адрес экрана вывода
                ;   BC  - размер обрезанного спрайта в пикселях (B - y (изменённая), C - x (изменённая в знакоместах))
                ;   HL' - адрес буфера
                ; -----------------------------------------
.IsNoShift      ; сохранение размера строки в знакоместах
                LD A, C
                EX AF, AF'

                ; подготовка вывода
                LD D, H
                LD E, L
                LD A, #F8
                AND D
                LD H, A
                SUB D
                ADD A, #08
                LD C, B
                LD B, A

                ; -----------------------------------------
                ;   DE - адрес буфера
                ;   B   - количество строк в знакоместе
                ;   C   - количество отображаемых строк
                ; -----------------------------------------

.Loop           ; копирование строки
                PUSH DE
                EXX
                POP DE
                EX AF, AF'
                LD C, A
                EX AF, AF'
                LDIR
                EXX

                ; новая строка
                DEC C
                RET Z
                INC D
                DJNZ .NextRow

                LD B, #08
                LD A, L
                ADD A, #20
                LD L, A
                JR C, .NextBoundary
                LD D, H                                                         ; восстановление адреса экрана
                LD E, L
                JR .Loop

.NextBoundary   LD H, D                                                         ; сохранение старший байт адреса экрана
.NextRow        LD E, L                                                         ; восстановление младший байт адреса экрана
                JR .Loop
                
                display " - Restore Background under Sprite : \t\t\t", /A, DrawRestore, " = busy [ ", /D, $ - DrawRestore, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_RESTORE_BACKGROUND_
