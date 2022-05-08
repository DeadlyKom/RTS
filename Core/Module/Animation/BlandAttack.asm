
                ifndef _CORE_MODULE_ANIMATION_BLAND_ATTACK_
                define _CORE_MODULE_ANIMATION_BLAND_ATTACK_

; -----------------------------------------
; бленд анимации атаки
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Attack:         CALL Utils.Unit.Shot.Cooldown
                JP C, Unit.RefUnitOnScr

.ChangeAnim     ; инкремент анимации
                CALL Animation.Increment
                JP NC, Unit.RefUnitOnScr

                ; получение адреса характеристик юнита
                LD HL, (UnitsCharRef)
                CALL Utils.Unit.GetAdrInTable
                LD A, (HL)                                                      ; FUnitCharacteristics.Cooldown
                INC HL
                LD (IX + FUnit.CooldownShot), A
                CALL Animation.Default

                ; CALL Utils.Math.Rand8
                ; CP #10                                                        ; чем меньше тем реже происходит урон
                ; RET NC

                LD BC, (IX + FUnit.Target)
                CALL Utils.Unit.Tile.GetUnitsInLoc
                ; CALL NC, $                                                      ; добавить VFX
                JP NC, .L1

                PUSH IX

                LD DE, SharedBuffer

.Loop           EX AF, AF'

                LD A, (DE)
                SUB #02
                LD IXL, A
                INC E
                LD A, (DE)
                LD IXH, A
                INC E

                ; применить нанесение урона
                LD C, (HL)                                                      ; FUnitCharacteristics.Weapon
                INC HL
                LD B, (HL)                                                      ; FUnitCharacteristics.Damage
                DEC HL
                CALL Utils.Unit.Shot.ApplyDamage

                ; переход к следующему юниту
                EX AF, AF'
                DEC A
                JR NZ, .Loop

                POP IX

.L1             
                ; обновление облости
                JP Unit.RefUnitOnScr

                endif ; ~_CORE_MODULE_ANIMATION_BLAND_ATTACK_
