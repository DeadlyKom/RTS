
                ifndef _CORE_MODULE_UNIT_HANDLER_
                define _CORE_MODULE_UNIT_HANDLER_

; -----------------------------------------
; visibility computation handler of units
; In:
; Out:
; Corrupt:
;   HL, DE, BC, AF, AF'
; -----------------------------------------
Handler:        ; включить страницу
                SET_PAGE_UNITS_ARRAY

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

                ; JR$
                LD IX, UnitArrayPtr

                ifndef ENABLE_FORCE_DRAW_UNITS
                ; проверка на перерисовку всех юнитов принудительно
                LD HL, FrameUnitsFlagRef
                SRA (HL)
                LD A, #7F                               ; #3F для AND
                LD HL, #C312                            ; LD (DE), A : JP
                LD BC, .Force
                JR C, .Modify                           ; включим пропуск проверки обновления юнита
                LD A, #C0                               ; #C0 для AND
                LD HL, #00CA | (LOW  .PreNextUnit << 8) ; JP Z,. PreNextUnit
                LD BC, #EB00 | (HIGH .PreNextUnit << 0) ; EX DE, HL

.Modify         ; модификация кода
                LD (.ModifyCode + 0), A
                LD (.ModifyCode + 1), HL
                LD (.ModifyCode + 3), BC
                endif

.Loop           ; PUSH DE                                                         ; save current address UnitsArray

                ifndef ENABLE_FORCE_DRAW_UNITS
                ; проврка на перерисовку текущего юнита
                LD A, (DE)
.ModifyCode     EQU $+1
                AND %11000000
                JP Z, .PreNextUnit

                ; сброс состояния обновления спрайта юнита
                EX DE, HL
                LD A, (HL)
                LD E, A
                AND %0011111
                LD D, A
                LD A, E
                RRA
                AND %11000000
                OR D
                LD (HL), A
                EX DE, HL
                endif

.Force          CALL Sprite.FastClipping
                JR C, .PreNextUnit
                
                ; получение адреса хранения информации о спрайте
                CALL Animation.SpriteInfo
                CALL Sprite.PixelClipping
                JR C, .PreNextUnit

                ; подсчёт видимых юнитов
                ifdef SHOW_VISIBLE_UNITS 
                LD A, (VisibleUnits)
                INC A
                LD (VisibleUnits), A
                endif

                CALL Sprite.Draw

                ; включить страницу 
                SET_PAGE_UNITS_ARRAY

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

                SET_PAGE_UNITS_ARRAY
                endif
                
                ; отрисовка HP
                BIT FUSF_SELECTED_BIT, (IX + FUnit.State)                       ; проверка флага FUSF_SELECTED
                CALL NZ, UI.HP.Draw

.PreNextUnit    ; ---------------------------------------------
                ; всё же, спрайт за пределами экрана
                ; ---------------------------------------------
                ; включить страницу 
                SET_PAGE_UNITS_ARRAY

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
