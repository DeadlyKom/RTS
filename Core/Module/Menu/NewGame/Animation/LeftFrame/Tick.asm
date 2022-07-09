
                ifndef _CORE_MODULE_MENU_MAIN_NEW_GAME_ANIMATION_LEFT_TICK_
                define _CORE_MODULE_MENU_MAIN_NEW_GAME_ANIMATION_LEFT_TICK_

@Room.Left.Tick ;
                LD IX, Cooler1Anim
                CALL .Animate
                LD IX, Cooler2Anim
                CALL .Animate
                LD IX, MonitorAnim
                CALL .Animate
                LD IX, StorageAnim

.Animate        ; обратный отсчёт продолжительности 
                DEC (IX + FStaticAnimation.Countdown)
                RET NZ

                ; копирование продолжительности
                LD A, (IX + FStaticAnimation.Duration)
                LD (IX + FStaticAnimation.Countdown), A

                LD A, (IX + FStaticAnimation.FrameNumber)
                INC A
                CP (IX + FStaticAnimation.FrameCount)
                JR C, $+3
                XOR A
                LD (IX + FStaticAnimation.FrameNumber), A
                
                JP Animation.Core.Draw

                endif ; ~ _CORE_MODULE_MENU_MAIN_NEW_GAME_ANIMATION_LEFT_TICK_
