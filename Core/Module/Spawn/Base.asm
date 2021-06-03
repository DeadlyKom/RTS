
                ifndef _CORE_MODULE_SPAWN_BASE_
                define _CORE_MODULE_SPAWN_BASE_

; -----------------------------------------
; spawn unit on world
; In:
;   DE  - spawn parameters      (E - type unit, D - ?)
;   BC  - unit spawn position   (C - x,         B - y)
; Out:
; Corrupt:
;   IX
; Note:
;   requires included memory page 1 (MemoryPage_Tilemap)
; -----------------------------------------
Unit:           ; определение адреса добавления нового юнита
                LD IX, MapStructure
                LD HL, (IX + FMap.UnitsArray)
                LD A, (CountUnitsRef)
                ADD A, A
                ADD A, A
                ADD A, L
                LD L, A
                PUSH HL
                POP IX

                ; ---------------------------------------------
                ; FUnitLocation
                ; ---------------------------------------------

                ; инициализция позиции юнита
                LD (IX + FUnitLocation.TilePosition.X), C
                LD (IX + FUnitLocation.TilePosition.Y), B
                XOR A
                LD A, #FB
                LD (IX + FUnitLocation.OffsetByPixel.X), A
                LD A, #00
                LD (IX + FUnitLocation.OffsetByPixel.Y), A

                ; ---------------------------------------------
                ; FUnitState
                ; ---------------------------------------------
                LD BC, #0002
                INC IXH
                LD (IX + FUnitState.Behavior), C
                LD (IX + FUnitState.Direction), B
                XOR A
                LD (IX + FUnitState.Type), A
                LD A, 0
                LD (IX + FUnitState.Animation), A
 
                ; итерирование счётчика
                LD HL, CountUnitsRef
                INC (HL)
                RET

                endif ; ~_CORE_MODULE_SPAWN_BASE_
