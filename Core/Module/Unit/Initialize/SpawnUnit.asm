
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
Spawn:          ; поиск свободной ячейки
                EXX
                ; ToDo добавить ограничения спавна юнитов взятых из настроек уровня

                ; инициализация
                LD HL, Adr.Unit.Array
                LD DE, UNIT_SIZE-1
                LD BC, 129                                                      ; количество элементов
                LD A, UNIT_EMPTY_ELEMENT

                ; поиск свободной ячейки 
.Loop           CPI
                JR Z, .Spawn
                ADD HL, DE
                JP PE, .Loop
                RET

.Spawn          ; адрес свободного элемента найден
                DEC HL
                PUSH HL
                POP IX

                ; увеличение количества юнитов в массиве
                LD HL, GameAI.UnitArraySize
                LD E, (HL)
                LD A, 128
                SUB C
                LD D, A
                PUSH DE                                                         ; сохранение, D - индекс элемента, E - количество элементов в массиве
                INC (HL)
                EXX

                ; -----------------------------------------
                
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
                EXX
                CALL Math.Rand8
                EXX
                LD (IX + FUnit.Direction), A

                ; расчёт индекса чанка
                CALL Game.Unit.Utils.ChunkArray.GetChunkIdx
                LD (IX + FUnit.Chunk), A

                ; -----------------------------------------
                ;   A  - порядковый номер чанка [0..127]
                ;   HL - адрес массива чанков
                ;   D  - добавляемое значение
                ;   E  - количество элементов в массиве
                ; -----------------------------------------

                LD HL, Adr.Unit.UnitChank | 0x80                                ; адрес массива чанков юнитов
                POP DE                                                          ; восстановление, D - индекс элемента, E - количество элементов в массиве
                JP Game.Unit.Utils.ChunkArray.Insert                            ; вставка юнита

                display " - Spawn Unit in World : \t\t\t\t", /A, Spawn, " = busy [ ", /D, $ - Spawn, " bytes  ]"

                endif ; ~ _CORE_MODULE_UNIT_SPAWN_UNIT_
