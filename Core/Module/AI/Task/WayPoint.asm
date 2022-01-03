
                ifndef _CORE_MODULE_AI_TASK_WAY_POINT_
                define _CORE_MODULE_AI_TASK_WAY_POINT_

; -----------------------------------------
; получение токи пути
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
WayPoint:       ; проверка что Way Point валиден
                BIT FUTF_VALID_WP_BIT, (IX + FUnit.Data)                        ; бит валидности Way Point
                JR NZ, .Successfully                                            ; текущий Way Point не валидный

.IsNotValid_WP  ; ---------------------------------------------
                ; текущий Way Point стал невалидны (мб дошёл!)
                ; ---------------------------------------------
                BIT FUTF_VALID_IDX_BIT, (IX + FUnit.Data)                       ; бит валидности данных об индексе
                JR Z, .IsNotValid_IDX                                           ; данные об индексе не валидны, 
                                                                                ; дальнейшего пути нет!

                ; ---------------------------------------------
                ; проверка вставки временного WayPoint
                ; ---------------------------------------------
                BIT FUTF_INSERT_BIT, (IX + FUnit.Data)                          ; бит вставки (если 1 WP хранит временный путь, увеличивать смещение не нужно)
                JR NZ, .InsertWP                                                ; был временно вставлен WayPoint

                ; ---------------------------------------------
                ; итерация к следующему WayPoint
                ; ---------------------------------------------
                LD A, (IX + FUnit.Data)
                AND FUTF_MASK_OFFSET
                DEC A                                                           ; уменьшение счётчика

                ; ---------------------------------------------
                ; ToDo можно сделать последовательность > 8
                ; ---------------------------------------------
                ; JR Z, .                                                         ; уменьшим счётчик (если С = 0, это мб следующий индекс вложенных масивов)
                CP FUTF_MASK_OFFSET
                JR Z, .CheckLoop                                                ; проверка на зацикленность

                ; расчёт адреса WayPoint
.CalcAdrWP      ADD A, HIGH WaypointsSequencePtr
                LD H, A
                LD L, (IX + FUnit.Idx)
                
                ; проверка на наличие валидных значений в массиве (0 - пустота)
                LD A, (HL)
                OR A
                JR Z, .CheckLoop                                                ; проверка на зацикленность

                DEC (IX + FUnit.Data)                                           ; уменьшить счётчик

                ; копирование WayPoint во внутреннее хранилище
                LD L, A
.CopyWP         LD A, (HighWaypointArrayRef)
                LD H, A
                INC H                                                           ; первое значение, счётчик
                LD E, (HL)
                INC H
                LD D, (HL)

                LD (IX + FUnit.WayPoint), DE

                ; указан новый WayPoint
                SET FUTF_VALID_WP_BIT, (IX + FUnit.Data)                        ; бит валидности Way Point
                ; необходимо переинициализировать анимацию перемещения
                RES FUAF_TURN_MOVE, (IX + FUnit.Flags)                          ; бит принадлежности CounterDown (0 - поворот, 1 - перемещение)

.Successfully   ; успешно найденый Way Point
                SCF
                RET

.CheckLoop      ; ---------------------------------------------
                ; проверка на зацикленность WayPoint
                ; ---------------------------------------------
                BIT FUTF_LOOP_BIT, (IX + FUnit.Data)                            ; бит зациклености путей
                JR Z, .FinishWayPoint                                           ; все Way WayPoints пройдены

                LD A, (IX + FUnit.Data)
                OR FUTF_MASK_OFFSET
                LD (IX + FUnit.Data), A

                ; копирование WayPoint во внутреннее хранилище
                LD H, HIGH WaypointsSequencePtr + FUTF_MASK_OFFSET
                LD L, (IX + FUnit.Idx)
                LD L, (HL)
                JR .CopyWP

.FinishWayPoint ; ToDo сбросим состояние всей последовательности
                RES FUTF_VALID_IDX_BIT, (IX + FUnit.Data)                       ; бит валидности данных об индексе

.IsNotValid_IDX ; неудачное выполнение
                OR A                                                            
                RET

.InsertWP       ; ---------------------------------------------
                ; ранее была вставка временного WayPoint
                ; ---------------------------------------------
                ; бит вставки обнулить
                RES FUTF_INSERT_BIT, (IX + FUnit.Data)                          ; бит вставки (если 1 WP хранит временный путь, увеличивать смещение не нужно)

                LD A, (IX + FUnit.Data)
                AND FUTF_MASK_OFFSET
                ADD A, HIGH WaypointsSequencePtr
                LD H, A
                LD L, (IX + FUnit.Idx)
                LD L, (HL)

                JR .CopyWP

                endif ; ~_CORE_MODULE_AI_TASK_WAY_POINT_
