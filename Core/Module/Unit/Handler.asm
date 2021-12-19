
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
                CALL Memory.SetPage1

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

                LD DE, (UnitArrayRef)

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

.Loop           PUSH DE                                                         ; save current address UnitsArray

                ; ---------------------------------------------
                ; Lx, Ly   - позиция юнита (в тайлах)
                ; Vx, Vy   - позиция видимой области карты (в тайлах)
                ; Ox, Oy   - смещение относительно тайла в которых расположен юнит (в пикселах)
                ; Sx, Sy   - ширина спрайта (в пикселах)  !!!! [ х - в знакоместах ]
                ; SOx, SOy - смещение спрайта (в пикселах)
                ; ---------------------------------------------

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

.Force          INC D                                                           ; переход к стурктуре FSpriteLocation

                CALL Sprite.FastClipping
                JR C, .PreNextUnit

                EX AF, AF'
                LD (Sprite.PixelClipping.PositionX), A
                
                ; получение адреса хранения информации о спрайте
                DEC D                                                           ; DE = FUnitState.Animation
                DEC E
                CALL Animation.SpriteInfo

                INC D

                CALL Sprite.PixelClipping

                ; подсчёт видимых юнитов
                ifdef SHOW_VISIBLE_UNITS
                JR C, .SkipVisible

                LD A, (VisibleUnits)
                INC A
                LD (VisibleUnits), A

                CALL Sprite.Draw
.SkipVisible
                else

                CALL NC, Sprite.Draw

                endif
                
                ; включить страницу 
                CALL Memory.SetPage1

                ; ---------------------------------------------
                ; всё же, спрайт за пределами экрана
                ; ---------------------------------------------
.PreNextUnit    POP DE                                                          ; restore address UnitsArray

                PUSH DE
                ; ; отрисовка линии пути
                ; LD A, (DE)                  ; DE = FUnitState
                ; BIT FUSF_SELECTED_BIT, A    ; check flag FUSF_SELECTED
                ; CALL NZ, DrawPath
                
                ; отрисовка HP
                LD A, (DE)                                                      ; DE = FUnitState
                INC D ; FSpriteLocation
                BIT FUSF_SELECTED_BIT, A                                        ; check flag FUSF_SELECTED    
                CALL NZ, UI.HP.Draw

                POP DE

.NextUnit       INC E
                INC E
                INC E
                INC E
                ;
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
