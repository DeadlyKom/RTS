
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
RefUnitOnScr:   ; определение AABB выбранного юнита
                CALL Utils.AABB.GetScreen
                RET C

                ; ---------------------------------------------
                ;   HL  - H - правый край спрайта,   L - левый край спрайта  (в пикселах)
                ;   DE  - D - верхний край спрайта,  E - нижний край спрайта (в пикселях)
                ;   HL' - указывает на структуру текущего юнита FSprite.Dummy
                ;   IX  - указывает на структуру FUnit
                ; ---------------------------------------------

                ; пометим что юнита необходимо обноить
                LD A, FUSF_RENDER
                OR (IX + FUnit.State)
                LD (IX + FUnit.State), A

                JP Tilemap.TileUpdate

                endif ; ~ _CORE_MODULE_UNIT_RENDER_UPDATE_