
				ifndef _STRUCT_ANIM_TILE_
				define _STRUCT_ANIM_TILE_

				struct FAnimTile
Offset:         DB #00                                                          ; смещение в буфере
FrameCount:     DB #00                                                          ; количество кадров анимации
Countdown:      DB #00                                                          ; обратный счётчик продолжительности

				ends

				endif ; ~_STRUCT_ANIM_TILE_
