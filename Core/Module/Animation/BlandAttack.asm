
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
Attack:         
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
                LD C, #0A
                CALL Utils.Unit.Damage.Apply

                ; переход к следующему юниту
                EX AF, AF'
                DEC A
                JR NZ, .Loop

                POP IX


.L1             ; проверка что юнит составной
                BIT COMPOSITE_UNIT_BIT, (IX + FUnit.Type)
                CALL NZ, Animation.IncrementUp                                  ; юнит является составным
                BIT COMPOSITE_UNIT_BIT, (IX + FUnit.Type)
                CALL Z, Animation.IncrementDown                                 ; юнит не является составным

                ; обновление облости
                CALL Unit.RefUnitOnScr

                RET

                endif ; ~_CORE_MODULE_ANIMATION_BLAND_ATTACK_
