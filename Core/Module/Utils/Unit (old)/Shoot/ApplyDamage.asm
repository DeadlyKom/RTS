
                ifndef _CORE_MODULE_UTILS_UNIT_APPLY_DAMAGE_
                define _CORE_MODULE_UTILS_UNIT_APPLY_DAMAGE_
; -----------------------------------------
; нанесение урона юниту
; In:
;   B  - величина урона FUnitCharacteristics.Damage
;   C  - тип урона      FUnitCharacteristics.Weapon
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ApplyDamage:    ; получение адреса характеристик юнита
                LD HL, (UnitsCharRef)
                CALL Utils.Unit.GetAdrInTable
                PUSH HL
                POP IY

                ; проверка устойчивость к применяемому типу урона
                LD A, C
                LD (.BIT), A
.BIT            EQU $+3
                BIT 0, (IY + FUnitCharacteristics.ResistanceBits)
                RET NZ                                                          ; выход, т.к. у юнита имунитет к этому типу урона

                LD A, (IX + FUnit.Armor)
                SUB B
                JR NC, .SaveArmor

                NEG
                LD B, A
                LD A, (IX + FUnit.Health)
                SUB B
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
