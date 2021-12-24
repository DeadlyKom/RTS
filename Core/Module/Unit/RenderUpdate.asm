
                ifndef _CORE_MODULE_UNIT_RENDER_UPDATE_
                define _CORE_MODULE_UNIT_RENDER_UPDATE_
; -----------------------------------------
; обновление юнита на экране
; In:
;   A - номер юнита
; Out:
; Corrupt:
;   HL, DE, BC, AF, AF'
; -----------------------------------------
RefUnitOnScr:   ; включить страницу
                EX AF, AF'
                CALL Memory.SetPage1
                EX AF, AF'

                ; определение AABB выбранного юнита
                CALL Utils.AABB.GetScreen
                RET C

                ; ---------------------------------------------
                ;   HL  - H - правый край спрайта,   L - левый край спрайта  (в пикселах)
                ;   DE  - D - верхний край спрайта,  E - нижний край спрайта (в пикселях)
                ;   HL' - указывает на структуру текущего юнита FSprite.Dummy
                ;   DE' - указывает на структуру текущего юнита FSpriteLocation.OffsetByPixel.X
                ; ---------------------------------------------

                ; установим флаги обновления юнита в 2-х экранах
                EXX
                DEC D                                                           ; DE = FUnitState.Type
                DEC E                                                           ; DE = FUnitState.Direction
                DEC E                                                           ; DE = FUnitState.State
                LD A, (DE)
                OR %11000000
                LD (DE), A
                EXX

                JP Tilemap.TileUpdate

                endif ; ~ _CORE_MODULE_UNIT_RENDER_UPDATE_