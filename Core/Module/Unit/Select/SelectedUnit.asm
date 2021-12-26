
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
                JR C, $                                                         ; буфер оказался пустым ?!

                ; расчёт смещения по индексу юнита
                ADD A, A
                ADD A, A
                LD (FoundPathToUnitRef), A

                ; расчёт адреса структуры FUnitState.State необходимого юнита
                LD HL, (UnitArrayRef)                                           ; HL = FUnitState.State             (1)
                ADD A, L
                LD L, A
                
                ;
                BIT FUSF_SELECTED_BIT, (HL)
                JR Z, $                                                         ; юнит почему то не выбран ?!

                INC H                                                           ; HL = FSpriteLocation.TilePosition.X (2)
                
                ; получим координаты тайла юнита
                LD E, (HL)
                INC L                                                           ; HL = FSpriteLocation.TilePosition.Y (2)
                LD D, (HL)
                RET

                endif ; ~ _CORE_MODULE_PATHFINDING_SELECTED_UNIT_