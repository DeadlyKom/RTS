
                ifndef _MEMORY_MACRO_INCLUDE_
                define _MEMORY_MACRO_INCLUDE_
; -----------------------------------------
; установить страницу памяти в банк 03
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
; включить страницу масива юнитов
SET_PAGE_UNITS_ARRAY macro
                CALL SetPage0
                endm
; включить страницу тайловой карты
SET_PAGE_TILEMAP macro 
                CALL SetPage1
                endm
; включить страницу файловой системы
SET_PAGE_FILE_SYS macro
                CALL SetPage1
                endm

                endif ; ~_MEMORY_MACRO_INCLUDE_
