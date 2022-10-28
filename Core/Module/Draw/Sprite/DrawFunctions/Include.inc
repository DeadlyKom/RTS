
                ifndef _CORE_MODULE_DRAW_SPRITE_DRAW_FUNCTION_INCLUDE_
                define _CORE_MODULE_DRAW_SPRITE_DRAW_FUNCTION_INCLUDE_

                module Function

                include "Shift_LD.asm"
                include "Shift_OR_XOR.asm"
                include "Shift_OR_XOR_Save.asm"
                include "NoShift_LD.asm"
                include "NoShift_OR_XOR.asm"
                include "NoShift_OR_XOR_Save.asm"
Table:          ; таблица функций (горизонталь, ширина спрайта в знакоместах)
.NoShift_LD     DW LD.TableNoShift.LD_8,                    LD.TableNoShift.LD_16,                      LD.TableNoShift.LD_24,                      LD.TableNoShift.LD_32
.NoShift_OR_XOR DW OR_XOR.TableNoShift.OX_8,                OR_XOR.TableNoShift.OX_16,                  OR_XOR.TableNoShift.OX_24,                  OR_XOR.TableNoShift.OX_32
.Shift_LD       DW LD.TableShift.LD_8,                      LD.TableShift.LD_16,                        LD.TableShift.LD_24,                        LD.TableShift.LD_32
.Shift_OR_XOR   DW OR_XOR.TableShift.OX_8,                  OR_XOR.TableShift.OX_16,                    OR_XOR.TableShift.OX_24,                    OR_XOR.TableShift.OX_32

Table_SR:       ; таблица функций сохранение (горизонталь, ширина спрайта в знакоместах)
.NoShift_OR_XOR DW OR_XOR_Save.TableNoShift.OX_8,           OR_XOR_Save.TableNoShift.OX_16,             #0000,                                      #0000
.Shift_OR_XOR   DW OR_XOR_Save.TableShift.OX_8_,             OR_XOR_Save.TableShift.OX_8,               OR_XOR_Save.TableShift.OX_16,               #0000

Exit:           ; точка возврата из функций
.ContainerSP    EQU $+1
                LD SP, #0000
                RET

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_SPRITE_DRAW_FUNCTION_INCLUDE_
