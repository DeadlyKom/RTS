
                ifndef _CORE_MODULE_UNIT_SPAWN_UNIT_
                define _CORE_MODULE_UNIT_SPAWN_UNIT_
; -----------------------------------------
; спавн юнита в мире
; In:
;   DE - позиция юнита  (D - y, E - x)
;   BC - параметры      (B -  , C - тип юнита)
; Out:
;   IX - адрес юнита
; Corrupt:
;   IX
; Note:
; -----------------------------------------
Spawn:          ; определение адреса добавления нового юнита
                LD HL, GameAI.UnitArraySize
                LD A, (HL)
                INC (HL)
                CALL Game.Unit.Utils.GetAddress
                
                XOR A

                LD (IX + FUnit.Type), C                                         ; тип юнита
                LD (IX + FUnit.State), A                                        ; сброс состояний юнта
                
                ; установка начальной позиции юнита
                LD (IX + FUnit.Position.X.Low), A
                LD (IX + FUnit.Position.X.High), E
                LD (IX + FUnit.Position.Y.Low), A
                LD (IX + FUnit.Position.Y.High), D

                ; сброс позиции цели
                LD (IX + FUnit.Target.X), A
                LD (IX + FUnit.Target.Y), A

                ; сброс данных
                LD (IX + FUnit.Data), A                                         ; данные WayPoint'а
                LD (IX + FUnit.Idx), A                                          ; данные WayPoint'а
                LD (IX + FUnit.CounterDown), A                                  ; счётчик повороов
                LD (IX + FUnit.CounterUp), A                                    ; счётчик повороов
                LD (IX + FUnit.Delta), A                                        ;
                LD (IX + FUnit.Flags), A                                        ; флаги
                LD (IX + FUnit.Rank), RANK_ROOKIE                               ; начальный ранг
                LD (IX + FUnit.Killed), A                                       ; количество убитых

                ; установка дефолтной брони и уровня HP
                LD (IX + FUnit.Armor), #20
                LD (IX + FUnit.Health), #FF

                ; сброс состояния дерева поведения
                LD (IX + FUnit.BehaviorTree.Info), 0x03 << 6                    ; BTS_UNKNOW
                LD (IX + FUnit.BehaviorTree.Child), A

                ; сброс анимации
                ; CALL Animation.Default
                LD (IX + FUnit.Animation), A
                LD (IX + FUnit.CooldownShot), #01

                ; рандом направление
                CALL Math.Rand8
                LD (IX + FUnit.Direction), A
 
                RET

                display " - Spawn Unit in World : \t\t", /A, Spawn, " = busy [ ", /D, $ - Spawn, " bytes  ]"

                endif ; ~ _CORE_MODULE_UNIT_SPAWN_UNIT_
