
                ifndef _DRAW_SPRITE_DRAW_
                define _DRAW_SPRITE_DRAW_
; -----------------------------------------
; рисовани спрайта, по ранне настроенным значениям
; смотрите FastClipping и PixelClipping
; In:
;   HL' - FSprite.Dummy
;   D'  - старший байт таблицы сдвига
; Out:
; Corrupt:
; Note:
;   Lx, Ly   - позиция спрайта (в тайлах)
;   Vx, Vy   - позиция видимой области карты (в тайлах)
;   Ox, Oy   - смещение спрайта относительно тайла (в пикселах)
;   Sx, Sy   - размер спрайта (х - в знакоместах, y - в пикселах)
;   SOx, SOy - смещение спрайта (в пикселах)
; -----------------------------------------
Draw:           ; ---------------------------------------------
                EXX                                                             ; сохраним 
                                                                                ; HL = FSprite.Dummy
                                                                                ; D  = старший байт таблицы сдвига
                LD E, (HL)                                                      ; E = FSprite.Dummy (смещение + Data = адрес маски)
                INC HL
                EX DE, HL
                LD A, (DE)                                                      ; A = FSprite.Page (7 бит, говорит об использовании маски по смещению)
                INC DE
                LD L, A                                                         ; сохраним номер страницы с данными 7 бита

                CALL Memory.SetPage
                LD A, (DE)
                EX AF, AF'
                INC DE
                LD A, (DE)
                EXX

                LD H, A
                EX AF, AF'
                LD L, A

                ; модификация адреса спрайта
.SkipLine       EQU $+1
                LD BC, #0000
                ADD HL, BC

                ; ---------------------------------------------

.SpriteHeight   EQU $+1                                                         ; C - Sy (высота спрайта в пикселях)
.SpriteWidth    EQU $+2                                                         ; B - Sx (ширина спрайта в знакоместах)
                LD BC, #0000

                EXX
                LD A, E                                                         ; FSprite.Dummy
                EX AF, AF'
                LD A, L                                                         ; FSprite.Page
                EXX

                ADD A, A                                                        ; проверка бита FSSF_CUSTOM_BIT
                CALL NC, MEMCPY.Sprite                                          ; копирование спрайта в буфер

                CALL Memory.InvScrPageToC000

                ; корректировка адреса экран
                EXX
.ScreenAdr      EQU $+1
                LD DE, #0000
                EXX

                ;
                LD (.ContainerSP), SP

                ; protection data corruption during interruption
                RestoreBC
                LD C, (HL)
                INC L
                LD B, (HL)
                DEC L
                PUSH BC
                EXX
                POP BC
                EXX
                LD SP, HL

                ; ---------------------------------------------
                ; двухпроходные вызовы
                ; ---------------------------------------------
                LD HL, .JumpsRows
                LD A, #18
.RowOffset      EQU $+1
                SUB #00
                LD E, A
                LD D, #00
                RRA
                JP NC, .EvenRows                                                ; чётное количество строк
                DEC E
                ADD HL, DE
                LD E, (IX - 2)
                LD D, (IX - 1)
                EX DE, HL
                JP (HL)

.EvenRows       ADD HL, DE
.JumpsRows      rept 12
                JP (IX)
                endr

.ContainerSP    EQU $+1
                LD SP, #0000

                RET


                endif ; ~_DRAW_SPRITE_DRAW_
