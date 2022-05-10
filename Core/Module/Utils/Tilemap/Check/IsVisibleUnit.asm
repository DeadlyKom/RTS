
                ifndef _CORE_MODULE_UTILS_TILEMAP_IS_VISIBLE_UNIT_
                define _CORE_MODULE_UTILS_TILEMAP_IS_VISIBLE_UNIT_

; -----------------------------------------
; In:
;   DE - позиция тайла (D - y, E - x)
; Out:
; Corrupt:
; Note:
;   требуется установить страницу с тайловой картой
; -----------------------------------------
IsVisibleUnit:  ; ---------------------------------------------
                ; проверка нахождения юнита под туманом войны
                ; ---------------------------------------------
                ; AddressTilemap
                CALL Utils.Tilemap.GetAddressTilemap
                LD A, (HL)
                ADD A, A
                RET C                                                           ; юнит находится под туманом войны

                ; ---------------------------------------------
                ; проверка нахождения юнита под сглаженными улами тумана войны
                ; ---------------------------------------------

.EdgeTop        ; проверка верхнего тайла
                LD A, D
                OR A
                JR Z, .EdgeRight_

                DEC D
                CALL .IsHidden
                RET NC

.EdgeRight      ; проверка правого тайла
                INC D
.EdgeRight_     INC E
                LD A, E
.RightClamp     EQU $+1
                CP #00
                JR Z, .EdgeBottom

                CALL .IsHidden
                RET NC

.EdgeBottom     ; проверка нижнего тайла
                DEC E
                INC D
                LD A, D
.BottomClamp    EQU $+1
                CP #00
                JR Z, .EdgeLeft

                CALL .IsHidden
                RET NC

.EdgeLeft       ; проверка левого тайла
                DEC D
                LD A, E
                OR A
                JR Z, .IsVisible

                DEC E

                CALL .IsHidden
                RET NC

.IsVisible      SET_PAGE_UNITS_ARRAY                                            ; включение страницы массива юнитов
                OR A
                RET

.IsHidden       ; AddressTilemap
                CALL Utils.Tilemap.GetAddressTilemap
                LD A, (HL)
                ADD A, A
                CCF
                RET C
                SET_PAGE_UNITS_ARRAY                                            ; включение страницы массива юнитов
                CALL Unit.RefUnitOnScr.SkipIsVisible
                OR A
                RET

                endif ; ~ _CORE_MODULE_UTILS_TILEMAP_IS_VISIBLE_UNIT_
