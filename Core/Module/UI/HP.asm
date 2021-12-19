
                ifndef _DISPLAY_UI_HP_
                define _DISPLAY_UI_HP_

                module HP

Draw:           CALL Sprite.FastClipping
                RET C

                EX AF, AF'
                LD (Sprite.PixelClipping.PositionX), A
                
                ; получение адреса хранения информации о спрайте
                DEC D                                                           ; DE = FUnitState.Animation
                DEC E
                CALL Animation.SpriteInfo

                ; DE = FUnitState.Animation

                INC D

                CALL Sprite.PixelClipping
                CALL NC, Sprite.Draw

                RET

                endmodule

                endif ; ~_DISPLAY_UI_HP_
