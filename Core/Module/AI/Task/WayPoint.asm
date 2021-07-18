
                ifndef _CORE_MODULE_AI_TASK_WAY_POINT_
                define _CORE_MODULE_AI_TASK_WAY_POINT_

; -----------------------------------------
; получение токи пути
; In:
;   IX - pointer to FUnitState (1)
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
WayPoint:       INC IXH                                             ; FUnitLocation     (2)
                INC IXH                                             ; FUnitTargets      (3)

                ; проверка что Way Point валиден
                BIT FUTF_VALID_WP, (IX + FUnitTargets.Data)
                JR Z, .IsNotValid_WP                                ; текущий Way Point не валидный

.Successfully   DEC IXH                                             ; FUnitLocation     (2)
                DEC IXH                                             ; FUnitState        (1)

                ; успешно найденый Way Point
                SCF
                RET

                ; ---------------------------------------------
                ; текущий Way Point стал невалидны (мб дошёл!)
                ; ---------------------------------------------
.IsNotValid_WP  BIT FUTF_VALID_INDEX, (IX + FUnitTargets.Data)
                JR Z, .IsNotValid_IDX                               ; данные об индексе не валидны, 
                                                                    ; дальнейшего пути нет!

                ; ---------------------------------------------
                ; проверка вставки временного WayPoint
                ; ---------------------------------------------
                BIT FUTF_INSERT, (IX + FUnitTargets.Data)
                JR NZ, .InsertWP                                    ; был временно вставлен WayPoint

                ; ---------------------------------------------
                ; итерация к следующему WayPoint
                ; ---------------------------------------------
                LD A, (IX + FUnitTargets.Data)
                AND FUTF_MASK_OFFSET
                DEC A                                               ; уменьшение счётчика

                ; ---------------------------------------------
                ; ToDo можно сделать последовательность > 8
                ; ---------------------------------------------
                ; JR Z, .                                             ; уменьшим счётчик (если С = 0, это мб следующий индекс вложенных масивов)

                JR Z, .CheckLoop                                    ; проверка на зацикленность

                ; расчёт адреса WayPoint
.CalcAdrWP      ADD A, HIGH SequenceWayPointsPtr
                LD H, A
                LD L, (IX + FUnitTargets.Idx)
                
                ; проверка на наличие валидных значений в массиве (0 - пустота)
                LD A, (HL)
                OR A
                JR Z, .CheckLoop                                    ; проверка на зацикленность

                DEC (IX + FUnitTargets.Data)                        ; уменьшить счётчик

                ; копирование WayPoint во внутреннее хранилище
                LD L, A
                LD A, (HighWayPointArrayRef)
                LD H, A
                LD E, (HL)
                INC H
                LD D, (HL)
                LD (IX + FUnitTargets.WayPoint.X), E
                LD (IX + FUnitTargets.WayPoint.Y), D

                JR .Successfully

                ; ---------------------------------------------
                ; проверка на зацикленность WayPoint
                ; ---------------------------------------------
.CheckLoop      BIT FUTF_LOOP, (IX + FUnitTargets.Data)
                JR Z, .Successfully                                 ; все Way WayPoints пройдены

                LD A, (IX + FUnitTargets.Data)
                OR FUTF_MASK_OFFSET
                LD (IX + FUnitTargets.Data), A

                ; копирование WayPoint во внутреннее хранилище
                LD L, FUTF_MASK_OFFSET
.CopyWP         LD A, (HighWayPointArrayRef)
                LD H, A
                LD E, (HL)
                INC H
                LD D, (HL)
                LD (IX + FUnitTargets.WayPoint.X), E
                LD (IX + FUnitTargets.WayPoint.Y), D

                JR .Successfully


.IsNotValid_IDX DEC IXH                                             ; FUnitLocation     (2)
                DEC IXH                                             ; FUnitState        (1)
                
                OR A                                                ; неудачное выполнение
                RET

                ; ---------------------------------------------
                ; ранее была вставка временного WayPoint
                ; ---------------------------------------------
.InsertWP       LD A, (IX + FUnitTargets.Data)
                AND FUTF_MASK_OFFSET
                LD L, A

                JR .CopyWP

                endif ; ~_CORE_MODULE_AI_TASK_WAY_POINT_
