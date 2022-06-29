
                ifndef _CORE_MODULE_MENU_MAIN_SCREENSAVER_TIMELINE_
                define _CORE_MODULE_MENU_MAIN_SCREENSAVER_TIMELINE_

Timeline_Tick:  ; CALL Stars.Tick

                CALL CheckSkip

.Timeline       EQU $+1
                LD HL, .TimelineTable
                LD E, (HL)
                INC HL
                LD D, (HL)

                LD HL, (TickCounterRef)
                OR A
                SBC HL, DE
                JP C, Stars.Tick

                LD HL, (.Timeline)
                INC HL
                INC HL
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                LD (.Timeline), HL
                EX DE, HL   
                JP (HL)

.TimelineTable  DW 10 * 50
                DW ShowTM
                DW 25 * 50
                DW ShowTM_ATTR_1
                DW 25 * 50 + 4
                DW ShowTM_ATTR_2
                DW 25 * 50 + 8
                DW ShowTM_ATTR_3
                DW 35 * 50
                DW HiddenTM_ATTR
                DW 51 * 50
                DW DestroyStars
                DW 58 * 50
                DW Finish
ShowTM:         LD HL, StarFlags
                LD (HL), Stars.STAR
                RET
ShowTM_ATTR_1:  ;
                SET_SCREEN_SHADOW
                SHOW_SHADOW_SCREEN
                ATTR_C000_IPB BLUE, WHITE, 1
                BORDER WHITE
                RET
ShowTM_ATTR_2:  ;
                ATTR_C000_IPB BLUE, WHITE, 0
                RET
ShowTM_ATTR_3:  ;
                SET_SCREEN_BASE
                SHOW_BASE_SCREEN
                ATTR_4000_IPB BLUE, BLACK, 1
                BORDER BLACK
                LD HL, Torn
                JP DrawStencilSpr
HiddenTM_ATTR:  LD HL, StarFlags
                LD (HL), Stars.STAR_CLS
                ATTR_4000_IPB BLUE, BLACK, 1
                RET
DestroyStars:   LD HL, StarFlags
                LD (HL), Stars.STAR_CLS | Stars.STAR_DESTROY
                RET
Finish:         LD HL, Flags
                LD (HL), #FF
                JP CLS

                endif ; ~ _CORE_MODULE_MENU_MAIN_SCREENSAVER_TIMELINE_
