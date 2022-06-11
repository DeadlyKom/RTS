
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
TextToBuffer:   ; расчёт адреса сообщения
                LD HL, (LocalizationRef)
                ADD A, A
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H
                LD E, (HL)
                INC HL
                LD D, (HL)
                ADD HL, DE

                ; сохранеие текущей страницы
                LD A, (MemoryPageRef)
                LD (.RestoreMemPage), A

                SET_PAGE_LOCALIZATION                                           ; включение страницы локализации
                ; проверка на первичное отображение
                EX AF, AF
                JR C, .Primary

                LD C, A
                CALL Language.Monochrome.DrawString.Custom
                JR .Continue

.Primary        CALL Language.Monochrome.DrawString
.Continue       LD E, C                                                         ; копирование длины строки в пикселах

                ; востановление предыдущей страницы
.RestoreMemPage EQU $+1
                LD A, #00
                JP SetPage

; -----------------------------------------
; In:
;   HL - адрес текста
; Out:
;   E - длина строки в пикселах
; Corrupt:
; Note:
; -----------------------------------------
StringToBuffer: ; сохранеие текущей страницы
                LD A, (MemoryPageRef)
                LD (.RestoreMemPage), A

                SET_PAGE_LOCALIZATION                                           ; включение страницы локализации
                
                EX AF, AF
                LD C, A
                CALL Language.Monochrome.DrawString.Custom
                LD E, C                                                         ; копирование длины строки в пикселах

                ; востановление предыдущей страницы
.RestoreMemPage EQU $+1
                LD A, #00
                JP SetPage

                display "\t - Text To Buffer : \t", /A, StringToBuffer, " = busy [ ", /D, $ - StringToBuffer, " bytes  ]"

                endif ; ~_BUILDER_KERNEL_MODULE_STRING_TO_BUFFER_
