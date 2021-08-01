
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
WayPoint:       ; JR $
                INC IXH                                             ; FUnitLocation     (2)
                INC IXH                                             ; FUnitTargets      (3)

                ; проверка что дельтазначени валиден
                BIT FUTF_VALID_DT_BIT, (IX + FUnitTargets.Data)
                JR Z, .IsNotValid_DT                                ; текущие дельты не валидный

.Successfully   DEC IXH                                             ; FUnitLocation     (2)
                DEC IXH                                             ; FUnitState        (1)

                ; успешно найденый Way Point
                SCF
                RET

                ; ---------------------------------------------
                ; текущие дельты невалидны
                ; ---------------------------------------------
.IsNotValid_DT  BIT FUTF_VALID_IDX_BIT, (IX + FUnitTargets.Data)
                JR Z, .IsNotValid_IDX                               ; данные об индексе не валидны, 
                                                                    ; дальнейшего пути нет!

                ; ---------------------------------------------
                ; проверка вставки временного WayPoint
                ; ---------------------------------------------
                BIT FUTF_INSERT_BIT, (IX + FUnitTargets.Data)
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
                CP FUTF_MASK_OFFSET
                JR Z, .CheckLoop                                    ; проверка на зацикленность

                ; расчёт адреса WayPoint
.CalcAdrWP      ADD A, HIGH WaypointsSequencePtr
                LD H, A
                LD L, (IX + FUnitTargets.Idx)
                
                ; проверка на наличие валидных значений в массиве (0 - пустота)
                LD A, (HL)
                OR A
                JR Z, .CheckLoop                                    ; проверка на зацикленность

                DEC (IX + FUnitTargets.Data)                        ; уменьшить счётчик

                ; получим WayPoint из массива
                LD L, A
.SetDelta       LD A, (HighWaypointArrayRef)
                LD H, A
                INC H                                               ; первое значение, счётчик
                LD E, (HL)
                INC H
                LD D, (HL)
                ; JR $
                
                CALL Utils.GetDeltaTarget                           ; расчёт дельт между 2 точек
                INC IXH                                             ; FUnitTargets      (3)

                LD (IX + FUnitTargets.Delta.X), E
                LD (IX + FUnitTargets.Delta.Y), D

                SET FUTF_VALID_DT_BIT, (IX + FUnitTargets.Data)     ; указаны новые дельты значения
                JR .Successfully

                ; ---------------------------------------------
                ; проверка на зацикленность WayPoint
                ; ---------------------------------------------
.CheckLoop      BIT FUTF_LOOP_BIT, (IX + FUnitTargets.Data)
                JR Z, .Successfully                                 ; все Way WayPoints пройдены

                LD A, (IX + FUnitTargets.Data)
                OR FUTF_MASK_OFFSET
                LD (IX + FUnitTargets.Data), A

                ; копирование WayPoint во внутреннее хранилище
                LD A, FUTF_MASK_OFFSET
                ADD A, HIGH WaypointsSequencePtr
                LD H, A
                LD L, (IX + FUnitTargets.Idx)

                LD L, (HL)
                JR .SetDelta


.IsNotValid_IDX DEC IXH                                             ; FUnitLocation     (2)
                DEC IXH                                             ; FUnitState        (1)
                
                OR A                                                ; неудачное выполнение
                RET

                ; ---------------------------------------------
                ; ранее была вставка временного WayPoint
                ; ---------------------------------------------
.InsertWP       RES FUTF_INSERT_BIT, (IX + FUnitTargets.Data)       ; бит вставки обнулить

                LD A, (IX + FUnitTargets.Data)
                AND FUTF_MASK_OFFSET
                ADD A, HIGH WaypointsSequencePtr
                LD H, A
                LD L, (IX + FUnitTargets.Idx)
                
                LD L, (HL)

                JR .SetDelta

                endif ; ~_CORE_MODULE_AI_TASK_WAY_POINT_
