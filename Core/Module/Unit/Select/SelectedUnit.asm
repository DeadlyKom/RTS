
                ifndef _CORE_MODULE_PATHFINDING_SELECTED_UNIT_
                define _CORE_MODULE_PATHFINDING_SELECTED_UNIT_

; -----------------------------------------
; определить следующего юнита
; In:
; Out:
;   DE - позиция цели (D - y, E - x)
; Corrupt:
;   HL, DE, C, AF
; Note:
; -----------------------------------------
InitSelected:   ; получим значение из очереди
                CALL Pathfinding.Queue.PopUnit
                JP C, SFX.BEEP.Fail                                             ; буфер оказался пустым ?!

                ; расчёт смещения по индексу юнита
                CALL Utils.GetAdrUnit
                LD (FoundPathToUnitRef), IX

                ; включить страницу массива юнитов
                SET_PAGE_UNITS_ARRAY
                
                ; проверим что объект выбран
                BIT FUSF_SELECTED_BIT, (IX + FUnit.State)                       ; объект выбран
                JP Z,  SFX.BEEP.Fail                                            ; юнит почему то не выбран ?!
                
                ; получим координаты тайла юнита
                LD DE, (IX + FUnit.Position)

                RET

                endif ; ~ _CORE_MODULE_PATHFINDING_SELECTED_UNIT_