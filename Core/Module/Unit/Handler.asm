
                ifndef _CORE_MODULE_UNIT_HANDLER_
                define _CORE_MODULE_UNIT_HANDLER_

; -----------------------------------------
; visibility computation handler of units
; In:
; Out:
; Corrupt:
;   HL, DE, BC, AF, AF'
; -----------------------------------------
Handler:        SET_PAGE_UNITS_ARRAY                                            ; включить страницу массива юнитов

                ; инициализация
                ifdef SHOW_VISIBLE_UNITS
                XOR A
                LD (VisibleUnits), A
                endif

                ; проверка на наличие юнитов в массиве
                LD A, (AI_NumUnitsRef)
                OR A
                JP Z, .Exit
                LD (.ProcessedUnits), A

                LD IX, UnitArrayPtr

.Loop           ; ---------------------------------------------
                ; проверка видимости юнита под туманом войны
                ; ---------------------------------------------
                LD DE, (IX + FUnit.Position)
                SET_PAGE_TILEMAP                                                ; включение страницы с тайловой картой
                CALL Utils.Tilemap.IsVisibleUnit
                JP C, .PreNextUnit                                              ; юнит не видим

                ; BIT FUAF_FLASH_BIT, (IX + FUnit.Flags)
                ; JR Z, .SkipFlash

                ;
;                 RES FUAF_FLASH_BIT, (IX + FUnit.Flags)
;                 JR .PreNextUnit

; .SkipFlash      ;

                ; ---------------------------------------------
                ; клипинг
                ; ---------------------------------------------

                CALL Sprite.FastClipping
                JR C, .PreNextUnit

                ; проверка что юнит составной
                BIT COMPOSITE_UNIT_BIT, (IX + FUnit.Type)
                JR Z, .NotComposite                                             ; юнит не является составным

                ; получение адреса хранения информации о спрайте
                OR A                                                            ; проверка нижней части 
                CALL Animation.SpriteInfo.Composite
                CALL Sprite.PixelClipping
                JR C, .PreNextUnit

                CALL Sprite.Draw                                                ; отрисовка спрайта

                SET_PAGE_UNITS_ARRAY                                            ; включить страницу массива юнитов

                ; если юнит умер, не рисовать верхнию его часть
                CALL Utils.Unit.State.IsDEAD                                    ; проверка флага UNIT_STATE_DEAD
                JR Z, .Visible

                ; получение адреса хранения информации о спрайте
                SCF                                                             ; проверка верхней части 
                CALL Animation.SpriteInfo.Composite
                CALL Sprite.PixelClipping
                JR C, .PreNextUnit

                CALL Sprite.Draw                                                ; отрисовка спрайта

                JR .Visible
                
.NotComposite   ; получение адреса хранения информации о спрайте
                CALL Animation.SpriteInfo
                CALL Sprite.PixelClipping
                JR C, .PreNextUnit

                CALL Sprite.Draw                                                ; отрисовка спрайта

.Visible        ; подсчёт видимых юнитов
                ifdef SHOW_VISIBLE_UNITS 
                LD A, (VisibleUnits)
                INC A
                LD (VisibleUnits), A
                endif

                SET_PAGE_UNITS_ARRAY                                            ; включить страницу массива юнитов

                ; ; отрисовка линии пути
                ; LD A, (DE)                  ; DE = FUnitState
                ; BIT FUSF_SELECTED_BIT, A    ; check flag FUSF_SELECTED
                ; CALL NZ, DrawPath

                ifdef SHOW_AABB
                ; отрисовка AABB
                CALL Utils.AABB.GetScreen.CurrentAddress
                ; ---------------------------------------------
                ;   HL  - H - правый край спрайта,   L - левый край спрайта  (в пикселах)
                ;   DE  - D - верхний край спрайта,  E - нижний край спрайта (в пикселях)
                ;   HL' - указывает на структуру текущего юнита FSprite.Dummy
                ;   DE' - указывает на структуру текущего юнита FSpriteLocation.OffsetByPixel.X
                ; ---------------------------------------------
                LD A, L
                LD (DrawRectangle.Start), A
                LD A, H
                LD (DrawRectangle.End), A
                LD A, E
                LD (DrawRectangle.End + 1), A
                LD A, D
                LD (DrawRectangle.Start + 1), A
                CALL Memory.SetPage7
                CALL DrawRectangle.Custom

                SET_PAGE_UNITS_ARRAY                                            ; включить страницу массива юнитов
                endif

                ; ---------------------------------------------
                ; анимация
                ; ---------------------------------------------

                CALL Utils.Unit.State.IsATTACK                                  ; проверка флага UNIT_STATE_ATTACK
                CALL Z, Animation.Attack

                CALL Utils.Unit.State.IsDEAD                                    ; проверка флага UNIT_STATE_DEAD
                CALL Z, Animation.Dead
                
                ; отрисовка HP
                BIT FUSF_SELECTED_BIT, (IX + FUnit.State)                       ; проверка флага FUSF_SELECTED
                CALL NZ, UI.HP.Draw

.PreNextUnit    ; ---------------------------------------------
                ; всё же, спрайт за пределами экрана
                ; ---------------------------------------------
                SET_PAGE_UNITS_ARRAY                                            ; включить страницу массива юнитов

.NextUnit       ; переход к следующему юниту
                LD DE, UNIT_SIZE
                ADD IX, DE

                LD HL, .ProcessedUnits
                DEC (HL)
                JP NZ, .Loop

.Exit           RET

.NotTarget      POP AF
                POP DE
                RET

.ProcessedUnits DB #00

                ifdef SHOW_VISIBLE_UNITS
VisibleUnits    DB #00

                endif

                endif ; ~ _CORE_MODULE_UNIT_HANDLER_
