
                ifndef _CORE_MODULE_DRAW_SPRITE_UNIT_INFANTRY_
                define _CORE_MODULE_DRAW_SPRITE_UNIT_INFANTRY_
; -----------------------------------------
; 
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawInfantry:   
                RET

                display " - Draw Unit Infantry : \t\t", /A, DrawInfantry, " = busy [ ", /D, $ - DrawInfantry, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_SPRITE_UNIT_INFANTRY_
