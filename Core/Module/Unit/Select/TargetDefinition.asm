
                ifndef _CORE_MODULE_UNIT_TARGET_DEFINITION_
                define _CORE_MODULE_UNIT_TARGET_DEFINITION_
; -----------------------------------------
; определяем цель перемещения юнитов
; In:
; Out:
;   DE - позиция цели (D - y, E - x)
; Corrupt:
; Note:
; -----------------------------------------
DefineTarget:   CALL Utils.Mouse.ToTilemap
                RET

                endif ; ~ _CORE_MODULE_UNIT_TARGET_DEFINITION_