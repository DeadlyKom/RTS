
                ifndef _CORE_MODULE_DRAW_SPRITE_UNIT_TANK_
                define _CORE_MODULE_DRAW_SPRITE_UNIT_TANK_
; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawTank:       ; BIT COMPOSITE_UNIT_BIT, (IX + FUnit.Type)
                RET

                display " - Draw Unit Tank : \t\t\t", /A, DrawTank, " = busy [ ", /D, $ - DrawTank, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_SPRITE_UNIT_TANK_
