
                ifndef _CORE_MODULE_DRAW_SPRITE_UNIT_PREPARE_SPRITE_
                define _CORE_MODULE_DRAW_SPRITE_UNIT_PREPARE_SPRITE_

; -----------------------------------------
; подготовка спрайта перед выводм на экран
; In:
;   HL - адрес текущего спрайта
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Prepare:        ; инициализация
                LD HL, GameVar.TilemapOffset
                LD C, (HL)                                                      ; X
                INC HL
                LD B, (HL)                                                      ; Y
                
                EXX

                ; -----------------------------------------
                ; расчёт положения спрайта по вертикали,
                ; относительно верхней границы видимой области
                ; -----------------------------------------

                ; приведение к форме хранения позиции юнита (12.4)
                ; SOy = FCompositeSpriteInfo.Info.OffsetY << 4
.SOy            EQU $+1
                LD L, #00
                LD A, L
                ADD A, A
                SBC A, A
                LD H, A
                LD A, L
                ADD A, A
                ADD A, A
                ADD A, A
                RL H
                ADD A, A
                RL H
                LD L, A

                ; HL = SOy + FUnit.Position.Y - GameVar.TilemapOffset.Y
.PositionY      EQU $+1
                LD DE, #0000
                ADD HL, DE
                LD A, H
                EXX
                SUB B                                                           ; GameVar.TilemapOffset.Y
                EXX
                LD H, A                                                         ; HL - хранит положение спрайта, относительно верхней границы видимой области
                JP P, .BelowTop                                                 ; переход, если спрайт находится ниже верхней границы видимой области

                ; ---------------------------------------------
                ; спрайт выше границы видимой области
                ; ---------------------------------------------

                ; преобразование высоты спрайта в 16-битное число
                LD B, #00
.Height         EQU $+1
                LD A, #00
                ADD A, A
                ADD A, A
                ADD A, A
                RL B
                ADD A, A
                RL B

                ; добавить к относительному расположению спрайта по вертикали,
                ; относительно верхней границы видимой области размер спрайта
                ADD HL, BC
                RET NC                                                          ; выход, если при добавлении размера спрайта по вертикали,
                                                                                ; не произошло переполненеи. значение осталось отрицательным
                                                                                ; и спрайт полностью находится выше видимой области

.ClipTop        ; ---------------------------------------------
                ; спрайт урезан верхней частью видимой области
                ; ---------------------------------------------
                RET
        

.BelowTop       ; ---------------------------------------------
                ; спрайт находится ниже верхней границы видимой области
                ; ---------------------------------------------
                RET


.ClipBottom     ; ---------------------------------------------
                ; спрайт урезан нижней частью видимой области
                ; ---------------------------------------------
                RET


                ; ; приведение к 8 битному значению по вертикали HL << 4
                ; ADD HL, HL
                ; ADD HL, HL
                ; ADD HL, HL
                ; ADD HL, HL

                ; ; проверка позиции спрайта в пределах от 0 до 191
                ; LD A, H
                ; CP SCREEN_PIXEL_Y
                ; JR C, .ClipBottom                                               ; переход, если позиция в пределах от 0 до 191

                ; ; проверка позиции спрайта выше экрана
                ; NEG
                ; CP C
                ; RET NC                                                          ; выход, если спрайт выше экрана

                ; D - FCompositeSpriteInfo.Info.OffsetX (SOx)
                ; B - FCompositeSpriteInfo.Info.Width   (Sx)
.SOx            EQU $+1
                LD L, #00
                ; HL = SOx + FUnit.Position.X - GameVar.TilemapOffset.X
.PositionX      EQU $+1
                LD DE, #0000
.Width          EQU $+1
                LD A, #00

                RET

                display " - Prepare Sprite Unit : \t\t", /A, Prepare, " = busy [ ", /D, $ - Prepare, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_SPRITE_UNIT_PREPARE_SPRITE_
