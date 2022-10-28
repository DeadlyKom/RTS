
                ifndef _MODULE_GAME_RENDER_CURSOR_
                define _MODULE_GAME_RENDER_CURSOR_
; -----------------------------------------
; отображение игрового курсора
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawCursor:     ; проверка бездействия курсора
                LD HL, .TickCounter
                LD A, (Mouse.PositionFlag)                                      ; если курсор не поменяет позицию, хранит #FF
                OR A
                JR NZ, .Counter                                                 ; переход, если курсор не перемещается

                ; сброс анимации и выставление время ожидания бездействия
                LD (HL), DURATION_IDLE_CURSOR
                INC HL
                LD (HL), A                                                      ; SpriteIdx (сброс анимации)
                JR .Draw

.Counter        ; отсчёт счётчика бездействия курсора
                DEC (HL)
                JR NZ, .Draw                                                    ; переход, если счётчик бездействия курсора не обнулён

                ; счётчик обнулился, необходимо сменить анимацию
                INC HL                                                          ; SpriteIdx
                LD A, (HL)

                ; flip-flop анимаций в 4 кадра
                INC HL
                ADD A, (HL)

                ; проверка достижения 4 кадра анимации
                CP 4*8
                JR NZ, .IsFirst                                                 ; переход, если кадр не равен 4 фрейму анимации

                ; установка обратного прохода смены анимации
                LD (HL), -8
                DEC HL
                JR .SetSubcounter

.IsFirst        ; проверка достижения -1 кадра анимации
                CP -8
                JR NZ, .SetAnimIdx                                              ; переход, если кадр не равен 0 фрейму анимации

                ; установка прямого проход смены анимации
                LD (HL), 8
                DEC HL
                JR .SetSubcounter

.SetAnimIdx     ; сохранение индекса анимации
                DEC HL
                LD (HL), A

.SetSubcounter  ; установка промежуточного счётчика
                DEC HL
                LD (HL), #02

.Draw           ; -----------------------------------------
                ; восстановление фона под курсором
                ; -----------------------------------------
                CALL Draw.Restore                                               ; переход, если требуется восстановление фона

                ; включение страницы видимого экрана
                LD A, (MemoryPageRef)
                AND %00001000
                LD A, #07
                JR Z, $+4
                XOR #02
                CHECK_RENDER_FLAG FINISHED_BIT
                JR NZ, $+4
                XOR #02
                CALL SetPage
               
                ; -----------------------------------------
                ; расчёт адреса
                ; -----------------------------------------
                LD HL, Game.Cursor.SpriteInfo
                LD A, (.SpriteIdx)
                ADD A, L
                LD L, A
                ADC A, H
                SUB L
                LD H, A

                ; -----------------------------------------
                ; чтение информации о спрайте
                ; -----------------------------------------
                LD B, (HL)                                                      ; FSprite.Info.Height   (высота спрайта)
                INC HL
                INC HL                                                          ; FSprite.Info.OffsetY  (смещение спрайта по вертикали в пикселях)      - пропуск
                LD C, (HL)                                                      ; FSprite.Info.Width    (ширина спрайта)
                INC HL                                                          ; FSprite.Info.OffsetX  (смещение спрайта по горизонтали в пикселях)    - пропуск
                INC HL                                                          ; FSprite.Offset                                                        - пропуск
                INC HL                                                          ; FSprite.Data.Page     (номер страницы)                                - пропуск
                INC HL                                                          ; FSprite.Data.Data
                LD A, (HL)
                INC HL
                LD H, (HL)
                LD L, A

                LD DE, (Mouse.Position)                                         ; позиция курсора на экране
                XOR A, E
                AND #07
                SRL E
                SRL E
                SRL E
                CALL Draw.Sprite                                                ; отрисовка спрайта

                ; установка флага порчи фона
                SET_RENDER_FLAG RESTORE_BIT

                RET

.TickCounter    DB 250
.SpriteIdx      DB #00
.Direction      DB #08

                endif ; ~_MODULE_GAME_RENDER_CURSOR_
