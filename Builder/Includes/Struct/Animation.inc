
				ifndef _STRUCTURE_ANIMATION_
				define _STRUCTURE_ANIMATION_

				struct FStaticAnimation
Location:       FLocation                                                       ; позиция на экране
Size:           FSize                                                           ; размер спрайта
Table:          DW #0000                                                        ; адрес таблицы анимаций FSpriteData
FrameNumber:    DB #00                                                          ; номер анимации
FrameCount:     DB #00                                                          ; количество кадров анимации
Countdown:      DB #00                                                          ; обратный счётчик продолжительности
Duration:       DB #00                                                          ; продолжительность анимаций (1/50)

				ends

				endif ; ~_STRUCTURE_ANIMATION_