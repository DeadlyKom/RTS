
                ifndef _MACRO_MEMORY_
                define _MACRO_MEMORY_
; -----------------------------------------
; включение страницы памяти в банк 03
; In:
; Out:
; Corrupt:
;   BC, AF
; -----------------------------------------
SetPage:        macro Page?
                LD BC, PORT_7FFD
                LD A, (BC)
                AND PAGE_MASK_INV
                OR Page?
                LD (BC), A
                OUT (C), A
                endm
; включение страницы масива юнитов
SET_PAGE_UNITS_ARRAY macro
                CALL SetPage0
                endm
; включение страницы тайловой карты
SET_PAGE_TILEMAP macro 
                CALL SetPage1
                endm
; включение страницы файловой системы
SET_PAGE_FILE_SYS macro
                CALL FileSystemFunc
                endm
; включение страницы локализации
SET_PAGE_LOCALIZATION macro
                CALL LocalizationFunc
                endm
; включение страницы первого экрана
SET_SCREEN_BASE macro
                CALL SetPage5
                endm
; включение страницы второго экрана
SET_SCREEN_SHADOW macro
                CALL SetPage7
                endm
                endif ; ~_MACRO_MEMORY_
