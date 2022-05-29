
                ifndef _BUILDER_KERNEL_MODULE_STRING_TO_BUFFER_
                define _BUILDER_KERNEL_MODULE_STRING_TO_BUFFER_
; -----------------------------------------
; In:
;   A - ID сообщения
; Out:
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
                CALL Language.Monochrome.DrawString

                ; востановление предыдущей страницы
.RestoreMemPage EQU $+1
                LD A, #00
                JP SetPage

; -----------------------------------------
; In:
;   HL - адрес текста
; Out:
; Corrupt:
; Note:
; -----------------------------------------
StringToBuffer: ; сохранеие текущей страницы
                LD A, (MemoryPageRef)
                LD (.RestoreMemPage), A

                SET_PAGE_LOCALIZATION                                           ; включение страницы локализации
                CALL Language.Monochrome.DrawString

                ; востановление предыдущей страницы
.RestoreMemPage EQU $+1
                LD A, #00
                JP SetPage

                display "\t - Text To Buffer : \t", /A, StringToBuffer, " = busy [ ", /D, $ - StringToBuffer, " bytes  ]"

                endif ; ~_BUILDER_KERNEL_MODULE_STRING_TO_BUFFER_
