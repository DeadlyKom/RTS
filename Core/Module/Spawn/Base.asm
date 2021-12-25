
                ifndef _CORE_MODULE_SPAWN_BASE_
                define _CORE_MODULE_SPAWN_BASE_

; -----------------------------------------
; spawn unit on world
; In:
;   DE  - spawn parameters      (E - type unit, D - ?)
;   BC  - unit spawn position   (C - x,         B - y)
; Out:
;   IX  - адрес юнита           FUnitState (1)
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
                ; FUnitState                                (1)
                ; ---------------------------------------------
                LD DE,  FUSE_RECONNAISSANCE | FUSF_RENDER ; | FUSF_SELECTED
                LD (IX + FUnitState.State), E

                ; рандом направления
                LD A, R
                LD D, A
.Rand           EQU $+1
                AND %01010101
                LD A, (.Rand)
                RRCA
                XOR D
                RLA
                LD (.Rand), A

                LD (IX + FUnitState.Direction), A
                XOR A
                LD (IX + FUnitState.Type), A
                LD A, 0
                LD (IX + FUnitState.Animation), A

                INC IXH                                                         ; переход к FSpriteLocation

                ; ---------------------------------------------
                ; FSpriteLocation                             (2)
                ; ---------------------------------------------

                ; инициализция позиции юнита
                LD (IX + FSpriteLocation.TilePosition.X), C
                LD (IX + FSpriteLocation.TilePosition.Y), B
                XOR A
                LD A, #00
                LD (IX + FSpriteLocation.OffsetByPixel.X), A
                LD A, #00
                LD (IX + FSpriteLocation.OffsetByPixel.Y), A

                INC IXH                                                         ; переход к FUnitTargets

                ; ---------------------------------------------
                ; FUnitTargets                              (3)
                ; ---------------------------------------------

                ; инициализция
                XOR A
                LD (IX + FUnitTargets.WayPoint.X), A
                LD (IX + FUnitTargets.WayPoint.Y), A
                LD (IX + FUnitTargets.Data), A
                LD (IX + FUnitTargets.Idx), A

                INC IXH                                                         ; переход к FUnitAnimation

                ; ---------------------------------------------
                ; FUnitAnimation                            (4)
                ; ---------------------------------------------

                ; инициализция
                XOR A
                LD (IX + FUnitAnimation.CounterDown), A
                LD (IX + FUnitAnimation.CounterUp), A
                LD (IX + FUnitAnimation.Delta), A
                LD (IX + FUnitAnimation.Flags), A
 
                ; итерирование счётчика
                LD HL, AI_NumUnitsRef
                INC (HL)

                RET

                endif ; ~_CORE_MODULE_SPAWN_BASE_
