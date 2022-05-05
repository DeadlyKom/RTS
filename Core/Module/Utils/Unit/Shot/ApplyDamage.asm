
                ifndef _CORE_MODULE_UTILS_UNIT_APPLY_DAMAGE_
                define _CORE_MODULE_UTILS_UNIT_APPLY_DAMAGE_
; -----------------------------------------
; нанесение урона юниту
; In:
;   C  - значение урона
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ApplyDamage:    LD A, (IX + FUnit.Armor)
                SUB C
                JR NC, .SaveArmor

                NEG
                LD C, A
                LD A, (IX + FUnit.Health)
                SUB C
                JR C, .SetDEAD                                                  ; уничтожение юнита
                LD (IX + FUnit.Health), A

                ; получение адреса характеристик юнита
                LD HL, (UnitsCharRef)
                CALL Utils.Unit.GetAdrInTable
                PUSH HL
                POP IY
                LD A, (IY + FUnitCharacteristics.Armor)

                SET FUAF_FLASH_BIT, (IX + FUnit.Flags)                          ; включить мерцание

.SaveArmor      ; сохранение значение брони
                LD (IX + FUnit.Armor), A
                RET

.SetDEAD        ; уничтожение юнита
                JP Utils.Unit.State.SetDEAD

                endif ; ~ _CORE_MODULE_UTILS_UNIT_APPLY_DAMAGE_
