
                ifndef _CORE_MODULE_UTILS_AABB_GET_RECT_
                define _CORE_MODULE_UTILS_AABB_GET_RECT_

                module AABB
; -----------------------------------------
; получить описывающий прямоугольник указанного юнита в пределах экрана
; In:
;   A - номер юнита из массива
; Out:
;   HL  - H - правый край спрайта,   L - левый край спрайта  (в пикселах)
;   DE  - D - верхний край спрайта,  E - нижний край спрайта (в пикселях)
;   если флаг переполнения C установлен, объект вне экрана
;   HL' - указывает на структуру текущего юнита FSprite.Dummy
;   DE' - указывает на структуру текущего юнита FSpriteLocation.OffsetByPixel.X
; Corrupt:
;   HL, DE, BC, AF, HL', DE', BC', AF'
; Note:
;   необходимо утановить 1 страничку хранения данных об юнитах
; -----------------------------------------
GetScreen:      ; определение адреса указанного юнита
                ADD A, A
                ADD A, A
                JR C, $                                                         ; номер юнита >= 64
.NotCheck       LD E, A

                ToDo "AABB.GetScreen", "Warning : .HighAdrUnits необходимо инициализировать значение!"

.HighAdrUnits   EQU $+1                                                         ; старший адрес массива с информацией об юнитах
                LD D, #FC

.CurrentAddress INC D                                                           ; переход к стурктуре FSpriteLocation
                
                ; быстрое отсечение видимости
                ; подготовка данных для следующих тестов
                CALL Sprite.FastClipping
                RET C
                
                ; получение адреса хранения информации о спрайте
                DEC D                                                           ; DE = FUnitState.Animation
                DEC E
                CALL Animation.SpriteInfo

                INC D

                ; ---------------------------------------------
                LD A, #06                                                       ; дополнительная высота спрайта
                LD (Sprite.Clipping.Vertical.OffsetByPixel), A
                LD (Sprite.Clipping.Vertical.AddSizeByPixel), A
                CALL Sprite.Clipping.Vertical
                XOR A
                LD (Sprite.Clipping.Vertical.OffsetByPixel), A
                LD (Sprite.Clipping.Vertical.AddSizeByPixel), A
                RET C
                ; ---------------------------------------------
                ; L - хранит номер верхней линии спрайта    (в пикселях)
                ; C - высота видимой части спрайта          (в пикселях)
                ; ---------------------------------------------

                LD H, L
                LD A, L
                ADD A, C
                LD L, A
                ; ---------------------------------------------
                ; L - нижний край спрайта       (в пикселах)
                ; H - верхний край спрайта      (в пикселах)
                ; ---------------------------------------------

                PUSH HL

                ; ---------------------------------------------
                CALL Sprite.Clipping.Horizontal
                RET C
                ; ---------------------------------------------
                ; L - левый край спрайта                    (в пикселах)
                ; C - ширина видимой части спрайта          (в пикселах)
                ; ---------------------------------------------
                
                LD A, L
                ADD A, C
                LD H, A
                ; ---------------------------------------------
                ; L - левый край спрайта        (в пикселах)
                ; H - правый край спрайта       (в пикселах)
                ; ---------------------------------------------

                POP DE
                ; OR A
                RET

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_AABB_GET_RECT_