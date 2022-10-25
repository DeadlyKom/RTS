
                ifndef _MODULE_GAME_RENDER_CURSOR_
                define _MODULE_GAME_RENDER_CURSOR_
; -----------------------------------------
; отображение игрового курсора
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawCursor:     ;
                SET_PAGE_VISIBLE_SCREEN                                         ; включение страницы видимого экрана

                ;
                ; LD HL, GameFlags.SpriteFlagRef
                ; SET CSIF_OR_XOR_BIT, (HL)

                ; -----------------------------------------
                ; расчёт адреса
                ; -----------------------------------------
                LD HL, Game.Cursor.SpriteInfo

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

                ; установка флага порчи фона под курсором
                SET_RENDER_FLAG RESTORE_CURSOR_BIT

                RET
; -----------------------------------------
; восстановление фона под игровым курсором
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
RestoreCursor:  ; ---------------------------------------------
                ; 
                ; ---------------------------------------------

                ; сброс флага востановления фона под курсором
                RES_RENDER_FLAG RESTORE_CURSOR_BIT

                RET

                

                endif ; ~_MODULE_GAME_RENDER_CURSOR_
