
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_DRAW_ARROW_
                define _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_DRAW_ARROW_

DrawArrowDown:  LD HL, .Arrows
                LD DE, START_ARROW_DOWN
                LD BC, #0507
                INC (IY + FDialogVariable.Arrow.Animation)
                LD A, (IY + FDialogVariable.Arrow.Animation)
                AND %00000001
                ADD A, D
                LD D, A
                JP DrawSpriteORXOR

.Arrows         DB %11111110, %11111110
                DB %11111110, %10000010
                DB %01111100, %01000100
                DB %00111000, %00101000
                DB %00010000, %00010000
ClearArrowDown: LD HL, .Arrow
                LD DE, START_ARROW_DOWN
                LD BC, #0507
                JP DrawSpriteORXOR

.Arrow          DB %11111110, %11111110
                DB %11111110, %11111110
                DB %01111100, %01111100
                DB %00111000, %00111000
                DB %00010000, %00010000
DrawArrowSelect ; расчёт высоты в зависимости от количество выбора и выбранной
                LD B, (IY + FDialogVariable.CurSelectionNum)
                CALL CalcHeightSel
                
                LD HL, .Arrows
                LD BC, #0705
                INC (IY + FDialogVariable.Arrow.Animation)
                LD A, (IY + FDialogVariable.Arrow.Animation)
                AND %00000001
                ADD A, E
                LD E, A
                JP DrawSpriteORXOR

.Arrows         DB %11100000, %11100000
                DB %11100000, %10100000
                DB %11110000, %10010000
                DB %11111000, %10001000
                DB %11110000, %10010000
                DB %11100000, %10100000
                DB %11100000, %11100000
ClearArrowSelect:
                LD B, (IY + FDialogVariable.OldSelectionNum)
.B              CALL CalcHeightSel
                LD HL, .Arrow
                LD BC, #0705
                JP DrawSpriteORXOR

.Arrow          DB %11100000, %11100000
                DB %11100000, %11100000
                DB %11110000, %11110000
                DB %11111000, %11111000
                DB %11110000, %11110000
                DB %11100000, %11100000
                DB %11100000, %11100000

CalcHeightSel:  LD A, NUMBER_ROWS
                SUB (IY + FDialogVariable.Choice.Number)
                ADD A, B
                LD B, A
                LD A, HIGH START_ARROW_RIGHT

.Mult           ADD A, ROW_HEGHT
                DJNZ .Mult
                LD D, A
                LD E, LOW START_ARROW_RIGHT
                RET

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_DRAW_ARROW_
