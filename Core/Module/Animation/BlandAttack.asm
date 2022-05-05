
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
                PUSH HL
                POP IY

                LD A, (IY + FUnitCharacteristics.Cooldown)
                LD (IX + FUnit.CooldownShot), A
                CALL Animation.Default


                ; CALL Utils.Math.Rand8
                ; CP #10                                                        ; чем меньше тем чаще происходит урон
                ; RET NC

                LD C, (IX + FUnit.Target.X)
                LD B, (IX + FUnit.Target.Y)
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
                LD C, (IY + FUnitCharacteristics.Damage)
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
