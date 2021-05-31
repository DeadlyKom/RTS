
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

                ; инициализция позиции юнита
                LD (IX + FUnitLocation.TilePosition.X), C
                LD (IX + FUnitLocation.TilePosition.Y), B
                XOR A
                LD (IX + FUnitLocation.OffsetByPixel.X), A
                LD (IX + FUnitLocation.OffsetByPixel.Y), A
 
                ; итерирование счётчика
                LD HL, CountUnitsRef
                INC (HL)
                RET

                endif ; ~_CORE_MODULE_SPAWN_BASE_
