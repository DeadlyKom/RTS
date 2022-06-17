
                ifndef _CORE_MODULE_MENU_MAIN_SCREENSAVER_TIMELINE_
                define _CORE_MODULE_MENU_MAIN_SCREENSAVER_TIMELINE_

Timeline_Tick:  CALL Stars.Tick

.Timeline       EQU $+1
                LD HL, .TimelineTable
                LD E, (HL)
                INC HL
                LD D, (HL)

                LD HL, (TickCounterRef)
                OR A
                SBC HL, DE
                RET C

                LD HL, (.Timeline)
                INC HL
                INC HL
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                LD (Timeline_Tick.Timeline), HL
                EX DE, HL   
                JP (HL)

.TimelineTable  DW 10 * 50
                DW ShowTM
                DW 25 * 50
                DW ShowTM_ATTR
                DW 35 * 50
                DW HiddenTM_ATTR
                DW 50 * 50
                DW PreDestroyStars
                DW 51 * 50
                DW DestroyStars
                DW 58 * 50
                DW Finish

ShowTM:         LD HL, StarFlags
                LD (HL), Stars.STAR
                RET
ShowTM_ATTR:    ;
                SET_SCREEN_BASE
                LD HL, Torn
                JP DrawStencilSpr
HiddenTM_ATTR:  LD HL, StarFlags
                LD (HL), Stars.STAR_CLS
                ATTR_4000_IPB BLUE, BLACK, 1
                RET
PreDestroyStars CLS_4000
                RET
DestroyStars:   LD HL, StarFlags
                LD (HL), Stars.STAR_CLS | Stars.STAR_DESTROY
                RET
Finish:         LD HL, Flags
                LD (HL), #FF
                CLS_4000
                RET
            

                endif ; ~ _CORE_MODULE_MENU_MAIN_SCREENSAVER_TIMELINE_
