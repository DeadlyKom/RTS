
                ifndef _CORE_MODULE_AI_TASK_ATTACK_
                define _CORE_MODULE_AI_TASK_ATTACK_

; -----------------------------------------
; атака цели
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
AttackTo:       ; 
                CALL Utils.Unit.State.SetATTACK                                 ; установка состояния атаки

                ; CALL Utils.Math.Rand8
                ; CP #10                                                        ; чем меньше тем чаще происходит урон
                ; RET NC

                LD C, (IX + FUnit.Target.X)
                LD B, (IX + FUnit.Target.Y)
                CALL Utils.Unit.Tile.GetUnitsInLoc
                ; CALL NC, $                                                      ; добавить VFX
                JP NC, AI.SetBTS_SUCCESS

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

                JP AI.SetBTS_SUCCESS

                endif ; ~_CORE_MODULE_AI_TASK_ATTACK_
