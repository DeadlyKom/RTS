
                ifndef _CORE_MODULE_DRAW_SPRITE_DRAW_FUNCTION_SHIFT_
                define _CORE_MODULE_DRAW_SPRITE_DRAW_FUNCTION_SHIFT_
Begin_Shift:    EQU $
; -----------------------------------------
;
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
                RET

                display " - Draw Function 'Shift OR & XOR': \t", /A, Begin_Shift, " = busy [ ", /D, $ - Begin_Shift, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_SPRITE_DRAW_FUNCTION_SHIFT_
