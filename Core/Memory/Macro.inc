
                        ifndef _MEMORY_MACRO_INCLUDE_
                        define _MEMORY_MACRO_INCLUDE_

; включить страницу масива юнитов
SET_PAGE_UNITS_ARRAY    macro
                        CALL MemPage_UnitArray
                        endm
; включить страницу тайловой карты
SET_PAGE_TILEMAP        macro 
                        CALL SetMemPage_Tilemap
                        endm
; включить страницу файловой системы
SET_PAGE_FILE_SYS       macro
                        CALL SetMemPage_FileSystem
                        endm

                        endif ; ~_MEMORY_MACRO_INCLUDE_
