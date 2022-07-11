                ifndef _BUILDER_KERNEL_MODULE_STRING_TO_BUFFER_
                define _BUILDER_KERNEL_MODULE_STRING_TO_BUFFER_
; -----------------------------------------
; In:
;   A  - ID сообщения
;   A' - если флаг переполнения Carry установлен, первичное отображение
;   иначе в A' хранится смещение
; Out:
;   E - длина строки в пикселах
; Corrupt:
; Note:
; -----------------------------------------
TextToBuffer:   LD HL, .Functor
                JR JumpToString
.Functor        ; проверка на первичное отображение
                EX AF, AF
                JR C, .Primary

                LD C, A
                CALL Language.Monochrome.DrawString.Custom
                JR .Continue

.Primary        CALL Language.Monochrome.DrawString
.Continue       LD E, C
                RET
; -----------------------------------------
; получить длину строки в пикселах
; In:
;   A  - ID сообщения
; Out:
;   E - длина строки в пикселах
; Corrupt:
; Note:
; -----------------------------------------
GetTextLength:  LD HL, .Functor
                JR JumpToString

.Functor        ; функция 
                CALL Language.Monochrome.GetLength
                LD E, B                                                         ; копирование длины строки в пикселах
                RET
; -----------------------------------------
; In:
;   HL - адрес строки
;   A' - смещение
; Out:
;   E - длина строки в пикселах
; Corrupt:
; Note:
; -----------------------------------------
StringToBuffer: LD BC, JumpToString.RET                                         ; точка возврата
                PUSH BC                                                         ; сохранение в стеке
                LD BC, .Functor
                PUSH BC
                JP JumpToString.SavePage

.Functor        ; функция 
                EX AF, AF
                LD C, A
                CALL Language.Monochrome.DrawString.Custom
                LD E, C                                                         ; копирование длины строки в пикселах
                RET

; -----------------------------------------
; отображение символа строки на экране
; In:
;   A  - ID сообщения
;   DE - координаты в пикселах (D - y, E - x)
;   A' - смещение в строке
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawCharToScr:  LD HL, Language.Monochrome.DrawCharToScr
; -----------------------------------------
; переход в страницу работы с языками и вызов функции обработчика
; In:
;   HL - функция обработчик
; Out:
; Corrupt:
; Note:
; -----------------------------------------
JumpToString:   ; инициализация функции обработчика и возврата
                LD BC, .RET                                                     ; точка возврата
                PUSH BC                                                         ; сохранение в стеке
                PUSH HL                                                         ; адрес функтора

                ; расчёт адреса строки
                LD HL, (LocalizationRef)
                ADD A, A
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H
                LD C, (HL)
                INC HL
                LD B, (HL)
                ADD HL, BC

.SavePage       ; сохранеие текущей страницы
                LD A, (MemoryPageRef)
                LD (.RestoreMemPage), A

                SET_PAGE_LOCALIZATION_JP                                        ; включение страницы локализации

.RET            ; востановление страницы
.RestoreMemPage EQU $+1
                LD A, #00
                JP SetPage

                display "\t - Text To Buffer : \t", /A, TextToBuffer, " = busy [ ", /D, $ - TextToBuffer, " bytes  ]"

                endif ; ~_BUILDER_KERNEL_MODULE_STRING_TO_BUFFER_
