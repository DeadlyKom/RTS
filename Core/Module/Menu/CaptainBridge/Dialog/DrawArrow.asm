
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_DRAW_ARROW_
                define _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_DRAW_ARROW_

DrawArrow:      INC (IY + FDialogVariable.Arrow.Animation)

                ;
                LD HL, .Arrows

                ;
                LD A, (IY + FDialogVariable.Arrow.Animation)
                RRA
                JR NC, .Draw

                LD BC, 9
                ADD HL, BC
.Draw           LD DE, START_ARROW_POS

                ;   HL - адрес спрайта
                ;   DE - адрес экрана пикселей
                JP DrawCharOne

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

ClearArrow:     LD HL, .Arrow
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

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_DRAW_ARROW_
