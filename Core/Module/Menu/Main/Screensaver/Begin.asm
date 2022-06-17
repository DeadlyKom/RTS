
                ifndef _CORE_MODULE_MENU_MAIN_SCREENSAVER_BEGIN_
                define _CORE_MODULE_MENU_MAIN_SCREENSAVER_BEGIN_

Begin:          ; подготовка экрана 1
                BORDER BLACK
                CLS_4000
                ATTR_4000_IPB BLUE, BLACK, 1
                SHOW_BASE_SCREEN

                ;
                SET_SCREEN_SHADOW
                CLS_C000
                ATTR_C000_IPB RED, BLACK, 0
                LD HL, Torn
                CALL DrawStencilSpr

                ;
                LD HL, TickCounterRef
                LD (HL), #00
                INC HL
                LD (HL), #00
                CALL Stars.Initialize
                SetUserHendler Timeline_Tick
                
.Loop           LD A, (Flags)
                BIT 7, A
                JR Z, .Loop

                OffUserHendler
                RET

Torn:           incbin "Core/Module/Sprites/Screensaver/TornMetal/Torn.spr"
Metal:          incbin "Core/Module/Sprites/Screensaver/TornMetal/Metal.spr"
                DW #0000

                endif ; ~ _CORE_MODULE_MENU_MAIN_SCREENSAVER_BEGIN_
