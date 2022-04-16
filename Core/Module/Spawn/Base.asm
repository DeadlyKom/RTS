
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
                LD A, (AI_NumUnitsRef)            
                CALL Utils.Unit.GetAddress

                ; ---------------------------------------------
                ; FUnitState                                (1)
                ; ---------------------------------------------
                ; LD DE,  FUSE_RECONNAISSANCE | FUSF_RENDER ; | FUSF_SELECTED
                LD (IX + FUnit.State), D

                ; рандом направления
                EXX
                CALL Utils.Math.Rand8
                EXX

                LD (IX + FUnit.Direction), A
                LD (IX + FUnit.Type), E
                LD A, 0
                LD (IX + FUnit.Animation), A

                ; ---------------------------------------------
                ; FSpriteLocation                             (2)
                ; ---------------------------------------------

                ; инициализция позиции юнита
                LD (IX + FUnit.Position.X), BC
                XOR A
                LD A, #00
                LD (IX + FUnit.Offset.X), A
                LD (IX + FUnit.Offset.Y), A

                ; ---------------------------------------------
                ; FUnitTargets                              (3)
                ; ---------------------------------------------

                ; инициализция
                XOR A
                LD (IX + FUnit.Target.X), A
                LD (IX + FUnit.Target.Y), A
                LD (IX + FUnit.Data), A
                LD (IX + FUnit.Idx), A

                ; ---------------------------------------------
                ; FUnitAnimation                            (4)
                ; ---------------------------------------------

                ; инициализция
                XOR A
                LD (IX + FUnit.CounterDown), A
                LD (IX + FUnit.CounterUp), A
                LD (IX + FUnit.Delta), A
                LD (IX + FUnit.Flags), A

                ; установка дефолтной брони и уровня HP
                LD A, #08
                LD (IX + FUnit.Armor), A
                LD A, #FF
                LD (IX + FUnit.Health), A

                ; сброс состояния дерева поведения
                LD A, BTS_UNKNOW
                LD (IX + FUnit.BehaviorTree.Info), A
 
                ; итерирование счётчика
                LD HL, AI_NumUnitsRef
                INC (HL)

                RET

                endif ; ~_CORE_MODULE_SPAWN_BASE_
