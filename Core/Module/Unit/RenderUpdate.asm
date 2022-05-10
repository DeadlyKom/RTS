
                ifndef _CORE_MODULE_UNIT_RENDER_UPDATE_
                define _CORE_MODULE_UNIT_RENDER_UPDATE_
; -----------------------------------------
; обновление юнита на экране
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
;   HL, DE, BC, AF, AF'
; -----------------------------------------
RefUnitOnScr:   ; ---------------------------------------------
                ; проверка видимости юнита под туманом войны
                ; ---------------------------------------------
                LD DE, (IX + FUnit.Position)
                SET_PAGE_TILEMAP                                                ; включение страницы с тайловой картой
                CALL Utils.Tilemap.GetAddressTilemap
                LD A, (HL)
                ADD A, A
                EX AF, AF'
                SET_PAGE_UNITS_ARRAY                                            ; включить страницу массива юнитов
                EX AF, AF'
                RET C                                                           ; юнит не видим

.SkipIsVisible  ; ---------------------------------------------

                ; определение AABB выбранного юнита
                CALL Utils.Unit.AABB.GetScreen
                RET C

                ; ---------------------------------------------
                ;   HL  - H - правый край спрайта,   L - левый край спрайта  (в пикселах)
                ;   DE  - D - верхний край спрайта,  E - нижний край спрайта (в пикселях)
                ;   HL' - указывает на структуру текущего юнита FSprite.Dummy
                ;   IX  - указывает на структуру FUnit
                ; ---------------------------------------------
                JP Tilemap.TileUpdate

                endif ; ~ _CORE_MODULE_UNIT_RENDER_UPDATE_