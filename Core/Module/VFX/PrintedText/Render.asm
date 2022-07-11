
                ifndef _CORE_MODULE_VFX_TEXT_PRINTED_RENDER_
                define _CORE_MODULE_VFX_TEXT_PRINTED_RENDER_
; -----------------------------------------
; отображение текста
; In:
;   DE - координаты в пикселах (D - y, E - x)
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawText:       CALL Functions.DrawCharToScr

                RET

                endif ; ~ _CORE_MODULE_VFX_TEXT_PRINTED_RENDER_
