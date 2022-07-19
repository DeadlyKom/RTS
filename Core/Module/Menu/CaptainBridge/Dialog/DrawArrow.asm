
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_DRAW_ARROW_
                define _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_DRAW_ARROW_

DrawArrow:      INC (IY + FDialogVariable.Arrow.Animation)

                ;
                LD A, (IY + FDialogVariable.Arrow.Animation)
                RRA
                JR NC, .Draw

                LD BC, 9
                ADD HL, BC

.Draw           ;   HL - адрес спрайта
                ;   DE - адрес экрана пикселей
                JP DrawCharOne


ClearArrowDown: LD HL, .Arrow
                LD DE, START_ARROW_POS

                ;   HL - адрес спрайта
                ;   DE - адрес экрана пикселей
                JP DrawCharOne

.Arrow          DB %00000001
                DB %00000001
                DB %00000001
                DB %00000001
                DB %00000001
                DB %00000001
                DB %00000001
                DB %11111111
                ZX_COLOR_IPB BLACK, CYAN, 0

DrawArrowDown:  LD HL, .Arrows
                LD DE, START_ARROW_POS
                JP DrawArrow

.Arrows         DB %00000001
                DB %00000001
                DB %01111101
                DB %00111001
                DB %00010001
                DB %00000001
                DB %00000001
                DB %11111111
                ZX_COLOR_IPB BLACK, CYAN, 0

                DB %00000001
                DB %00000001
                DB %00000001
                DB %01111101
                DB %00111001
                DB %00010001
                DB %00000001
                DB %11111111
                ZX_COLOR_IPB BLACK, CYAN, 0

DrawArrowSelect ;
                LD HL, .Arrows
                LD DE, #280A
                LD BC, #0503
                JP DrawSpriteMono

.Arrows         DB %10000000
                DB %11000000
                DB %11100000
                DB %11000000
                DB %10000000

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_DRAW_ARROW_
