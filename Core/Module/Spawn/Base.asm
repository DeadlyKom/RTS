
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
                LD HL, (UnitArrayRef)
                LD A, (AI_NumUnitsRef)
                ADD A, A
                ADD A, A
                ADD A, L
                LD L, A
                PUSH HL
                POP IX

                ; ---------------------------------------------
                ; FUnitState
                ; ---------------------------------------------
                LD DE, #3802 + 192
                LD (IX + FUnitState.Behavior), E
                LD (IX + FUnitState.Direction), D
                XOR A
                LD (IX + FUnitState.Type), A
                LD A, 0
                LD (IX + FUnitState.Animation), A

                INC IXH                                         ; переход к FUnitLocation

                ; ---------------------------------------------
                ; FUnitLocation
                ; ---------------------------------------------

                ; инициализция позиции юнита
                LD (IX + FUnitLocation.TilePosition.X), C
                LD (IX + FUnitLocation.TilePosition.Y), B
                XOR A
                LD A, #04
                LD (IX + FUnitLocation.OffsetByPixel.X), A
                LD A, #04
                LD (IX + FUnitLocation.OffsetByPixel.Y), A

                INC IXH                                         ; переход к FUnitTargets

                ; ---------------------------------------------
                ; FUnitTargets
                ; ---------------------------------------------

                ; инициализция
                XOR A
                LD (IX + FUnitTargets.Location.IDX_X), A
                LD (IX + FUnitTargets.Location.Y), A
                LD (IX + FUnitTargets.Enemy), A
                LD (IX + FUnitTargets.Flags), A

                INC IXH                                         ; переход к FFUnitAnimation

                ; ---------------------------------------------
                ; FFUnitAnimation
                ; ---------------------------------------------

                ; инициализция
                XOR A
                LD (IX + FFUnitAnimation.Counter + 0), A
                LD (IX + FFUnitAnimation.Counter + 1), A
                LD (IX + FFUnitAnimation.Counter.Second), A
                LD (IX + FFUnitAnimation.Flags), A
 
                ; итерирование счётчика
                LD HL, AI_NumUnitsRef
                INC (HL)

                RET

                endif ; ~_CORE_MODULE_SPAWN_BASE_
